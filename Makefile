SRC=src
OUT=out

MD=$(sort $(wildcard ${SRC}/*.md))
META=${SRC}/meta.yaml
BEFORE_BODY=${SRC}/before-body.tex
IN_HEADER=${SRC}/in-header.tex

FLAGS=-N --toc --top-level-division=chapter

${OUT}/appunti.pdf ${OUT}/appunti.tex: ${MD} ${META} ${BEFORE_BODY} ${IN_HEADER} | DIRS
	pandoc -t latex ${FLAGS} \
		--metadata-file=${META} \
		-B ${BEFORE_BODY} \
		-H ${IN_HEADER} \
		-o $@ ${MD}

DIRS:
	mkdir -p ${OUT}

