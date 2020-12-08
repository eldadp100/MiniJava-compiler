## Task Pool
| Task                                                         | Subtask                                 | Assignees                        | Status                          |
| :----------------------------------------------------------- | --------------------------------------- | ------------------------------- | ------------------------------- |
| Create task pool.                                            |                                         | @nityuiop18, @eldadp100, @yuval | ![](https://progress-bar.dev/33) |
| Implement *IRGeneratorVisitor.java* completely, taking all possibilities into account. | -             |                                 | ![](https://progress-bar.dev/0) |
| Implement *IRGenerator.java*.                                | -                                       |                                 |                                 |
| -                                                            | Define the module functions signatures. | @nityuiop18                     | ![](https://progress-bar.dev/0) |
| Define IRObject.java interface. IRObjects returns the actual IR text for their object. | -                                       |                                 | ![](https://progress-bar.dev/0) |
| Implement IRFunction.java.                                   | -                                       |                                 |                                 |
| -                                                            | Support static function.                |                                 | ![](https://progress-bar.dev/0) |
| -                                                            | Support class method.                   |                                 | ![](https://progress-bar.dev/0) |
| Implement IRVariable.java.                                   | -                                       |                                 |                                 |
| -                                                            | Support local variable.                 |                                 | ![](https://progress-bar.dev/0) |
| -                                                            | Support function parameter.             |                                 | ![](https://progress-bar.dev/0) |
| -                                                            | Support class field.                    |                                 | ![](https://progress-bar.dev/0) |
| Implement IRClass.java.                                      | -                                       |                                 |                                 |
| -                                                            | Support vtable.                         |                                 | ![](https://progress-bar.dev/0) |
| Document everything.                                         | -                                       |                                 | ![](https://progress-bar.dev/0) |
| Code review & Tests.                                         | -                                       |                                 | ![](https://progress-bar.dev/0) |
|                                                              |                                         |                                 | ![](https://progress-bar.dev/0) |
|                                                              |                                         |                                 | ![](https://progress-bar.dev/0) |
|                                                              |                                         |                                 | ![](https://progress-bar.dev/0) |
|                                                              |                                         |                                 | ![](https://progress-bar.dev/0) |
|                                                              |                                         |                                 | ![](https://progress-bar.dev/0) |



--------------------------------------------------------------------------------------------------------------------------------
This is our project. We should change the readme sometime


Welcome to the compiler project 2020 starter kit!

=== Structure ===

build.xml
	(directives for compiling the project using 'ant')

build/
	(temp directory created when you build)

examples/
	ast/
		(examples of AST XMLs representing Java programs)

	(more examples to come for each exercise)

schema/
	ast.xsd
		(XML schema for ASTs)

src/
	(where all your stuff is going to go)

	ast/*
		(Java representation of AST, including XML marshaling & unmarshaling, Visitor interface, and printing to Java. Some files to note:)

		AstXMLSerializer.java
			(for converting ASTs between XML <-> Java classes)

		AstPrintVisitor.java
			(printing AST as a Java program)

		Visitor.java
			(visitor interface)

		Program.java
			(the root of the AST)

	cup/
		Parser.cup
		(directives for CUP - to be used in ex4)

	jflex/
		Scanner.jfled
		(directives for JFlex - to be used in ex4)

	Main.java
		(main file, including a skeleton for the command line arguments we will use in the exercises. already does XML marshaling and unarmshaling and printing to Java)

	Lexer.java
		(generated when you build - to be used in ex4)

	Parser.java
		(generated when you build - to be used in ex4)

	sym.java
		(generated when you build - to be used in ex4)	

tools/*
	(third party JARs for lexing & parsing (ex4) and XML manipulation)

mjava.jar
	(*the* build)

README.md
	(<-- you are here)


=== All those things with ex4?? ===
Ignore them (for now; you know, Chekhov's gun and the like).

=== Compiling the project ===
ant

=== Cleaning ===
ant clean

=== From AST XML to Java program ===
java -jar mjavac.jar unmarshal print examples/BinaryTree.xml res.java

=== From AST XML to... AST XML ===
java -jar mjavac.jar unmarshal marshal examples/BinaryTree.xml res.xml

(you will use the code for this "marhsal" option when generating ASTs in ex1,ex4)
