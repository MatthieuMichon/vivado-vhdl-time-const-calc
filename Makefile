XVD ?= vivado
MODE ?= batch
FLAGS ?= -quiet -nojournal -notrace -mode $(MODE)
WORKDIR	= ./run

.PHONY: all
all:
	mkdir -p $(WORKDIR)
	cd $(WORKDIR) && ${XVD} ${FLAGS} -source ../build_vivado_project.tcl

.PHONY: clean
clean:
	$(RM) -r $(WORKDIR)
