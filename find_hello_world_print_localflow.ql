/**
 * @name Tainted println detector with local taint flow
 * @description Finds tainted println
 * @id java/tainted-println-local-flow
 * @kind problem
 * @severity info
 */

import java
import semmle.code.java.dataflow.DataFlow
import semmle.code.java.dataflow.FlowSources

class PrintlnSink extends DataFlow::Node {
  Println p;

  PrintlnSink() { this.asExpr() = p.getArgument() }

  Println getCall() { result = p }
}

class Println extends MethodCall {
  Println() { this.getCallee().hasQualifiedName("java.io", "PrintStream", "println") }

  string getName() { result = this.getCallee().getName() }

  Expr getArgument() { result = this.getArgument(0) }
}

from LocalUserInput source, PrintlnSink sink
where TaintTracking::localTaint(source, sink)
select sink, "Tainted println found in call to $@ from source $@", sink,
  sink.(PrintlnSink).getCall().getName(), source, source.toString()
