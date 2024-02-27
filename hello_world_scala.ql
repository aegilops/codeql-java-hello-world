/**
 * @name Hello, world
 * @kind problem
 * @problem.severity warning
 * @id scala/hello-world
 */

import java

// find "Hello, world" being printed out using the Scala standard library

from MethodAccess e, Method m
where e.getMethod() = m
    and m.hasQualifiedName("scala", "Predef$", "println")
    and e.getArgument(0).getUnderlyingExpr().(StringLiteral).getValue() = "Hello, world"
select e, "Call to println(\"Hello, world\") in Scala standard library"
