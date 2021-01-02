
This tester is a modified version of the one sent in the students' whatsapp group for Ex1, and therefore most of the credit belongs to its authors.
Unzip the file and folder in your project folder (the one that holds the "src" folder).
Run the tester using (on ubuntu) "python3 tester.py"

In case it can't find one in your project's folder, the tester will create a new mjavac.jar file using the command (on ubuntu) "ant -lib" ./tools" . 
This can be a source for a lot of exceptions so pay attention.
Also if you wish this tester to create the "mjavac.jar" file, make sure to change the default jdk version to java 11 before you try to run it.

The tester runs your program on various examples and compare its output to the formal LLVM code.
It removes leading and trailing whitespaces along with any comment in the two LLVM codes before the comparison

This tester haven't been tried yet by my group since we still haven't finish our project. If you find any interesting bugs please let me know.