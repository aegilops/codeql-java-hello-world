/**
 * @name Hello world println detector
 * @description Finds Hello, World println.
 * @id java/hello-world-println
 * @kind problem
 * @severity info
 */

import java

from StringLiteral sl, MethodCall mc, Callable c
where
  sl.getValue() = "Hello, World!" and
  mc.getCallee() = c and
  c.hasQualifiedName("java.io", "PrintStream", "println") and
  mc.getArgument(0) = sl
select mc, "Hello, World! found in call to $@", mc, c.getName()
