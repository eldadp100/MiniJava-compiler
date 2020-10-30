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
            AstMethodRenamerFirstTraverseVisitor visitor1 = new AstMethodRenamerFirstTraverseVisitor(originalName, originalLine);
            MethodDecl decl = visitor1.decl;
            if (decl == null)
                return Status.NoSuchLine;

            // start renaming
            for (ClassDecl c : visitor1.superclasses) {
                for (MethodDecl m : c.methoddecls()) {
                    if (m.name() == originalName)
                        m.setName(newName);
                }
            }

            for (ClassDecl c : visitor1.extendsclasees) {
                for (MethodDecl m : c.methoddecls()) {
                    if (m.name() == originalName)
                        m.setName(newName);
                }
            }
            // we left with renaming the calls expression. we need also static types information - maybe with same visitor.
            for (MethodCallExpr mc : visitor1.calls) {
                if ( TODO = write the condition here) {
                    mc.setMethodId(decl.name());
                }
            }

        } else {

        }
        
        return Status.SUCCESS;
    }
}
