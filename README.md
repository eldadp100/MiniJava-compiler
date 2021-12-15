A compiler for simplified version of java. 
Taking a text file, transforming it to an abstract syntax tree, applying static analysis on top of it to enforce type system correctness and to find use before initialization occurrences, then transforming the AST to LLVM code that is finally converted to assembly and executed.
