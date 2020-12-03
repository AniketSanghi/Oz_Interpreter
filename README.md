# Mozart Oz Interpreter
Interpreter for Oz language also written in Oz, developed by:

|       Name            | Roll No |        Email        |
|:---------------------:|:-------:|:-------------------:|
|    Aniket Sanghi      |  170110 |  sanghi@iitk.ac.in  |
|    Sarthak Singhal 	|  170635 | ssinghal@iitk.ac.in |
|    Yasharth Bajpai	|  170822 |   yashb@iitk.ac.in  |

# Description
The Interpreter is built as part of a course project for Principles of Programming Languages under Prof. Satyadev Nandakumar during Fall 2020.<br>
It takes an Abstract Syntax Tree as input, and outputs the sequence ofexecution states during the execution of the statement.<br>
The Interpreter incorporates all important aspects of a Procedural Abstract Machine, like Semantic Stack (SS), Single Assignment Store(SAS) and Environment.<br>
Procedure applications have been facilitated using Closures (with Static scoping).

We intend to add on to this project further by enabling Multithreading in it.

The source code for project can be found at  [Oz_Interpreter](https://github.com/sarthak2007/Oz_Interpreter) 

# Setup
Prerequisites:

	*  Mozart Oz
	*  Emacs

# Running & Examining the Project

Edit the file **interpreter.oz** and use the procedure **InterpretCode** with the Syntax tree as an argument, to evaluate the SAS and SS states.

For Example:

```
{InterpretCode [var ident(x) 
                        [[bind ident(x) literal(1)]
                        [var ident(x)
                           [[bind ident(x) literal(2)]
                            [nop]]]
                        [nop]]]}
```

Run Oz-Emacs IDE using the command in the terminal
```
oz
```
Go to the **'Oz'** tab at the top of the window and select the option **'Feed File'**.
Navigate through the files and select **'interpreter.oz'**.

Now, you'll be able to see the required states of the SAS and SS at every step of the interpretation in the Browse window.

