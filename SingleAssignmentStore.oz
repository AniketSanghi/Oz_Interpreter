declare SAS CurrKey

SAS = {Dictionary.new}
CurrKey = {Cell.new 0}

fun {AddKeyToSAS}
    Key
in
    Key = {Cell.access CurrKey}
    {Dictionary.put SAS Key equivalence(Key)}
    {Cell.assign CurrKey (Key+1)}    
    Key
end

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

proc {BindValueToKeyInSAS Key Value}
    RootValue
in
    RootValue = {RetrieveFromSAS Key}
    case RootValue
    of equivalence(X) then {Dictionary.put SAS X Value}
    else raise keyAlreadyBound(Key RootValue) end
    end
end
