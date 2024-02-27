/**
 * @name Hello world println detector with class
 * @description Finds Hello, World println, with class
 * @id java/hello-world-println-class
 * @kind problem
 * @severity info
 */

import java

class HelloWorld extends MethodCall {
  HelloWorld() {
    this.getCallee().hasQualifiedName("java.io", "PrintStream", "println") and
    this.getArgument(0).(StringLiteral).getValue() = "Hello, World!"
  }

  string getName() { result = this.getCallee().getName() }
}

from HelloWorld h
select h, "Hello, World! found in call to $@", h, h.getName()
