import ast.*;
import visitors.AstPrintVisitor;
import visitors.AstRenamerVisitor;
import visitors.AstSymbolsVisitor;
import visitors.AstSemanticDBVisitor;
import visitors.AstSemanticCheckVisitor;

import java.io.*;

public class Main {
    public static void main(String[] args) {
        try {
            var inputMethod = args[0];
            var action = args[1];
            var filename = args[args.length - 2];
            var outfilename = args[args.length - 1];

            Program prog;

            if (inputMethod.equals("parse")) {
                Parser parser = new Parser(new Lexer(new FileReader(filename)));
                prog = (Program)(parser.parse().value);
            } else if (inputMethod.equals("unmarshal")) {
                AstXMLSerializer xmlSerializer = new AstXMLSerializer();
                prog = xmlSerializer.deserialize(new File(filename));
            } else {
                throw new UnsupportedOperationException("unknown input method " + inputMethod);
            }

            var outFile = new PrintWriter(outfilename);
            try {

                if (action.equals("marshal")) {
                    AstXMLSerializer xmlSerializer = new AstXMLSerializer();
                    xmlSerializer.serialize(prog, outfilename);
                } else if (action.equals("print")) {
                    AstPrintVisitor astPrinter = new AstPrintVisitor();
                    astPrinter.visit(prog);
                    outFile.write(astPrinter.getString());

                } else if (action.equals("semantic")) {
                    try {
                        // Builds the classes hierarchy,
                        // collects all the classes, methods and vars declarations information.
                        AstSemanticDBVisitor semanticDBVisitor = new AstSemanticDBVisitor();
                        semanticDBVisitor.visit(prog);

                        // Performs statement related semantic checks
                        AstSemanticCheckVisitor semanticChecker = new AstSemanticCheckVisitor(semanticDBVisitor.getSemanticDB());
                        semanticChecker.visit(prog);

                        outFile.write("OK\n");
                    }
                    catch (Exception e) {
                        outFile.write("ERROR\n");
                        throw e;
                    }

                } else if (action.equals("compile")) {
                    AstSymbolsVisitor astSymbols = new AstSymbolsVisitor();
                    astSymbols.visit(prog);

                    AstIRClassGeneratorVisitor irClassGeneratorVisitor = new AstIRClassGeneratorVisitor();
                    irClassGeneratorVisitor.visit(prog);

                    AstIRGeneratorVisitor irGeneratorVisitor = new AstIRGeneratorVisitor(
                        astSymbols.GetAstSymbolTable(), irClassGeneratorVisitor.getIRGenerator()
                    );
                    irGeneratorVisitor.visit(prog);
                    outFile.write(irGeneratorVisitor.getString());

                } else if (action.equals("rename")) {
                    var type = args[2];
                    var originalName = args[3];
                    var originalLine = args[4];
                    var newName = args[5];

                    boolean isMethod;
                    if (type.equals("var")) {
                        isMethod = false;
                    } else if (type.equals("method")) {
                        isMethod = true;
                    } else {
                        throw new IllegalArgumentException("unknown rename type " + type);
                    }

                    AstSymbolsVisitor astSymbols = new AstSymbolsVisitor();
                    astSymbols.visit(prog);

                    AstRenamerVisitor astRenamer = new AstRenamerVisitor(
                        astSymbols.GetAstSymbolTable(),
                        originalName,
                        newName,
                        Integer.parseInt(originalLine),
                        isMethod);
                    astRenamer.visit(prog);

                    AstXMLSerializer xmlSerializer = new AstXMLSerializer();
                    xmlSerializer.serialize(prog, outfilename);
                } else {
                    throw new IllegalArgumentException("unknown command line action " + action);
                }
            } finally {
                outFile.flush();
                outFile.close();
            }

        } catch (FileNotFoundException e) {
            System.out.println("Error reading file: " + e);
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("General error: " + e);
            e.printStackTrace();
        }
    }
}
