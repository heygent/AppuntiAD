SRC=src
SRC_FILES=$(sort $(wildcard ${SRC}/*.md ${SRC}/*.yaml))
OUT=out
FLAGS=--top-level-division=chapter

${OUT}/appunti.pdf: ${SRC_FILES} | DIRS
	pandoc -t latex ${FLAGS} -o $@ $^

DIRS:
	mkdir -p ${OUT}

