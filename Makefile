.PHONY: codeql clean all
all: codeql

Main:
	javac Main.java

codeql:
	codeql database create Main.db --language=java --command="make Main" --overwrite

clean:
	rm -f Main.class Main.db
