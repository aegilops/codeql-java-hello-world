/**
 * @name Hello world string detector
 * @description Finds Hello, World strings.
 * @id java/hello-world-string
 * @kind problem
 * @severity info
 */

import java

from StringLiteral sl
where sl.getValue() = "Hello, World!"
select sl, "Hello, World! found"
