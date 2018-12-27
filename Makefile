SRC=src
OUT=out

MD=$(sort $(wildcard ${SRC}/*.md))
META=${SRC}/meta.yaml
TEX_DEFS=${SRC}/newcommands.tex

FLAGS=-N --toc --top-level-division=chapter

${OUT}/appunti.pdf: ${MD} ${META} ${TEX_DEFS} | DIRS
	pandoc -t latex ${FLAGS} --metadata-file=${META} -B ${TEX_DEFS} -o $@ ${MD}

DIRS:
	mkdir -p ${OUT}

