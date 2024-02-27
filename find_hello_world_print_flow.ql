/**
 * @name Tainted println detector with global taint flow
 * @description Finds tainted println
 * @id java/tainted-println-global-flow
 * @kind path-problem
 * @severity info
 */

import java
import semmle.code.java.dataflow.DataFlow
import semmle.code.java.dataflow.FlowSources

abstract class Source extends DataFlow::Node { }

abstract class Sink extends DataFlow::Node { }

module PrintlnFlowConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof Source }

  predicate isSink(DataFlow::Node sink) { sink instanceof Sink }

  predicate isBarrier(DataFlow::Node node) { none() }

  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) { none() }
}

module PrintlnFlow = TaintTracking::Global<PrintlnFlowConfig>;

import PrintlnFlow::PathGraph

class LocalSource extends Source instanceof LocalUserInput { }

class PrintlnSink extends Sink {
  Println p;

  PrintlnSink() { this.asExpr() = p.getArgument() }

  Println getCall() { result = p }
}

class Println extends MethodCall {
  Println() { this.getCallee().hasQualifiedName("java.io", "PrintStream", "println") }

  string getName() { result = this.getCallee().getName() }

  Expr getArgument() { result = this.getArgument(0) }
}

from PrintlnFlow::PathNode source, PrintlnFlow::PathNode sink
where PrintlnFlow::flowPath(source, sink)
select sink, source, sink, "Tainted println found in call to $@ from source $@", sink,
  sink.getNode().(PrintlnSink).getCall().getName(), source, source.getNode().toString()
