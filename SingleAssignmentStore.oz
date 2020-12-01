\insert 'ProcessRecords.oz'

%==================
% SAS -> dictionary with keys as SAS variables and values as their bindings
% CurrKey -> stores the name of SAS variable that is to be used next
%=================
declare SAS CurrKey

SAS = {Dictionary.new}
CurrKey = {Cell.new 0}

%==================
% Add a new key in SAS and return it
%=================
declare
fun {AddKeyToSAS}
    Key
in
    Key = {Cell.access CurrKey}
    {Dictionary.put SAS Key equivalence(Key)}
    {Cell.assign CurrKey (Key+1)}    
    Key
end

%==================
% Fetch the value corresponding to given Key and do path compression
%=================
declare
fun {RetrieveFromSAS Key}
    Val
in
    Val = {Dictionary.get SAS Key}
    case Val
    of equivalence(!Key) then Val
    [] equivalence(X) then
        local RootValue in
            RootValue = {RetrieveFromSAS X}
            {Dictionary.put SAS Key RootValue} 
            RootValue
        end
    else Val
    end
end

%==================
% Merge 2 equivalence classes
%=================
declare
proc {BindRefToKeyInSAS Key Ref}
    Val RefVal
in
    Val = {RetrieveFromSAS Key}
    RefVal = {RetrieveFromSAS Ref}
    case Val
    of equivalence(X) then
        case RefVal
        of equivalence(_) then {Dictionary.put SAS X RefVal}
        else raise keyAlreadyBound(Ref RefVal) end
        end
    else raise keyAlreadyBound(Key Val) end
    end
end

%==================
% Assign Value to the equivalence class in which Key is present
%=================
declare
proc {BindValueToKeyInSAS Key Value}
    RootValue
in
    RootValue = {RetrieveFromSAS Key}
    case RootValue
    of equivalence(X) then {Dictionary.put SAS X Value}
    else raise keyAlreadyBound(Key RootValue) end
    end
end

%==================
% Check if 2 values are equal
%=================
declare
fun {EqualRecursive Val1 Val2 EqualsSoFar}
    Equals % New list of equals
in
    if {List.member [Val1 Val2] EqualsSoFar} then true
    else
        Equals = {List.append [[Val1 Val2]] EqualsSoFar}
        case Val1
        of record | L | Pairs1 | nil then
            case Val2
            of record | !L | Pairs2 | nil then
                Canon1 = {Canonize Pairs1}
                Canon2 = {Canonize Pairs2}
            in
                % check if features of the records are same
                if {Map Canon1 fun {$ X} X.1 end} == {Map Canon2 fun {$ X} X.1 end} then
                    {List.all {List.zip Canon1 Canon2
                                fun {$ X Y}
                                    {EqualRecursive {RetrieveFromSAS X.2.1} {RetrieveFromSAS Y.2.1} Equals}
                                end}
                                fun {$ X} X end}
                else false
                end
            else false
            end
        else Val1 == Val2
        end
    end
end

%==================
% Print the current contents of SAS in the form of list where each element is:
% 1. an equivalence class(if variables in it are unbound) in form of list
% 2. else a pair with first element as equivalence class and second as the value
%=================
declare
proc {PrintSAS}
    KeyToValue
    ValueToKeys
in
    KeyToValue = {Map {Dictionary.keys SAS} fun {$ X} X#{RetrieveFromSAS X} end}

    ValueToKeys = {Map {FoldR KeyToValue
                        fun {$ X Y}
                            local WithoutX WithX in
                                {List.partition Y fun {$ Z} {EqualRecursive Z.2 X.2 nil} end WithX WithoutX}
                                case WithX of
                                nil then ([X.1]#X.2)|WithoutX
                                [] H|nil then (X.1|H.1)#(H.2)|WithoutX
                                end
                            end
                        end
                        nil}
                    fun {$ X}
                        case X.2 of
                        equivalence(_) then X.1
                        else X
                        end
                    end
                    }

    {Browse '-----Single Assignment Store-----'}
    {Browse ValueToKeys}
end
