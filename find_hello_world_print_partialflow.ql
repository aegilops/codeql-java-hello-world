/**
 * @name Tainted println detector with global taint partial flow
 * @description Finds tainted println (partial flow)
 * @id java/tainted-println-global-flow-partial
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

  // [+] add a barrier of the sink, so we don't do dataflow past it
  predicate isBarrier(DataFlow::Node node) { node instanceof Sink }

  predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) { none() }
}

module PrintlnFlow = TaintTracking::Global<PrintlnFlowConfig>;
// [+] add an exploration limit
int explorationLimit() { result = 20 }
// [+] define a new partial flow module, using that limit
module PrintlnFlowPartial = PrintlnFlow::FlowExplorationFwd<explorationLimit/0>;

// [~] import the partial flow graph, instead of the PathGraph
import PrintlnFlowPartial::PartialPathGraph

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

// [~] use PartialPathNode instead of PathNode
from PrintlnFlowPartial::PartialPathNode source, PrintlnFlowPartial::PartialPathNode sink
// [~] use partialFlow instead of flowPath, and add a placeholder third argument
where PrintlnFlowPartial::partialFlow(source, sink, _)
// [~] modify the message
select sink.getNode(), source, sink, "This node receives taint from $@", source, "this source"
