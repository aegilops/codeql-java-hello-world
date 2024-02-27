.PHONY: codeql clean all run
all: codeql

Main:
	javac Main.java

run:
	java Main "foo"

codeql:
	codeql database create Main.db --language=java --command="make Main" --overwrite

clean:
	rm -f Main.class Main.db
