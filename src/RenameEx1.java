import ast.AstNode;

import java.util.ArrayList;

import ast.*;
import ast.Program;

public class RenameEx1 {
    protected Program ast;

    public RenameEx1(Program _ast) {
        ast = _ast;
    }

    public Status run(boolean isMethod, String originalName, int originalLine, String newName) {
        if (isMethod) {
            AstMethodRenamerFirstTraverseVisitor visitor1 = new AstMethodRenamerFirstTraverseVisitor(originalName, originalLine, newName);
            ArrayList<AstNode> line_nodes = visitor1.getVisitorOrignalLines();
            if (line_nodes.size() == 0)
                return Status.NoSuchLine;

            AstNode first_instance = line_nodes.get(0);
            

            // #1 investigate which type of declaration is it


            // #2 appy second visior to find all right places and rename 
            AstMethodRenamerSecondTraverseVisitor visitor2 = new AstMethodRenamerSecondTraverseVisitor();

        } else {

        }

        
        
        return Status.SUCCESS;
    }
}
