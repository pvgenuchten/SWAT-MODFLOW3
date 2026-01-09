# ./src/Makefile
FC ?= gfortran
# "Loose" flags: no optimization, debug info, runtime backtrace
FCFLAGS ?= -O0 -g -fbacktrace -fno-underscoring -Wno-unused-variable -Wno-tabs -Wno-unused-dummy-argument -ffixed-line-length-none -ffree-line-length-none

# Linker flags (add netCDF etc. if needed)
LDFLAGS ?=

# Module directory and binary
MODDIR ?= mod
BINARY ?= ./swat_modflow3

# Find all Fortran sources under this directory (recursive)
ALL_SOURCES := $(shell find . -type f \( -iname '*.f' -o -iname '*.F' -o -iname '*.f90' -o -iname '*.F90' \) | sort)

# Ordered basenames based on inheritence
ORDERED_BASENAMES := \
modparm.f \
smrt_parm.f \
rt_modparm.f \
mf_rt_link.f \
mf_mach_mod.f90 \
mf_gwf2bas7_NWT.f \
mf_de47_NWT.f \
mf_sip7_NWT.f \
mf_gwf2riv7_NWT.f \
mf_modules.f90 \
mf_gwfsfrmodule_NWT.f \
mf_gwfuzfmodule_NWT.f \
mf_pcg7_NWT.f \
mf_nogmg.f \
mf_NWT1_module.f \
mf_gwf2bcf7.f \
mf_gwf2lpf7.f \
mf_gwf2huf7.f \
mf_gwf2upw1.f \
mf_gwf2sub7.f \
mf_gwf2drn7_NWT.f \
mf_obs2bas7.f \
mf_obs2drn7.f \
mf_obs2riv7.f \
mf_gwf2str7.f \
mf_obs2str7.f \
mf_gwf2ghb7_NWT.f \
mf_obs2ghb7.f \
mf_obs2chd7.f \
mf_gwf2swr7_NWT.f \
mf_gwf2wel7_NWT.f \
mf_gwf2evt7.f \
mf_gwf2rch7.f \
mf_NWT1_gmres.f90 \
mf_NWT1_xmdlib.f \
mf_NWT1_xmd.f \
mf_gwf2fhb7.f \
mf_gwf2res7.f \
mf_gwf2ibs7.f \
mf_gwf2chd7.f \
mf_gwf2hydmod7.f \
mf_gwf2hfb7_NWT.f \
mf_gwf2lak7_NWT.f \
mf_gwf2ets7.f \
mf_gwf2drt7.f \
mf_gwf2sfr7_NWT.f \
mf_gwf2gag7.f \
mf_gwf2mnw27_NWT.f \
mf_gwf2mnw2i7.f \
mf_gwf2uzf1_NWT.f \
mf_gwf2swt7.f \
mf_gwf2mnw17_NWT.f \
mf_lmt7_NWT.f \
mf_NWT1_ilupc_mod.f90

# Resolve ordered basenames to actual paths under ./src (first match)
ORDERED_SOURCES := $(shell for b in $(ORDERED_BASENAMES); do f=$$(find . -type f -iname $$b | head -n 1); if [ -n "$$f" ]; then echo $$f; fi; done)

# Warn if some ordered basenames were not found
MISSING_ORDERED := $(shell for b in $(ORDERED_BASENAMES); do f=$$(find . -type f -iname $$b | head -n 1); if [ -z "$$f" ]; then echo $$b; fi; done)
ifeq ($(MISSING_ORDERED),)
else
$(warning The following ordered source basenames were NOT found under ./src: $(MISSING_ORDERED))
endif

# Other sources = all sources minus the ordered ones
OTHER_SOURCES := $(filter-out $(ORDERED_SOURCES), $(ALL_SOURCES))

# Final ordered source list: user-ordered then the rest
SRCS := $(ORDERED_SOURCES) $(OTHER_SOURCES)

# Map sources to object filenames (preserve path)
OBJS := $(patsubst %.f,%.o,$(patsubst %.F,%.o,$(patsubst %.f90,%.o,$(patsubst %.F90,%.o,$(SRCS)))))

ORDERED_OBJS := $(patsubst %.f,%.o,$(patsubst %.F,%.o,$(patsubst %.f90,%.o,$(patsubst %.F90,%.o,$(ORDERED_SOURCES)))))
OTHER_OBJS := $(filter-out $(ORDERED_OBJS),$(OBJS))

.PHONY: all clean distclean list-sources help

all: $(BINARY)

# Ensure the ordered objects are built first (they're prerequisites)
$(BINARY): $(ORDERED_OBJS) $(OTHER_OBJS)
	@echo "Linking $@"
	$(FC) $(FCFLAGS) -J$(MODDIR) -o $@ $(ORDERED_OBJS) $(OTHER_OBJS) $(LDFLAGS)
	@echo "Built $@"

# Generic compile rules: every source compiled with -ffree-form -ffree-line-length-none
%.o: %.f
	@mkdir -p $(MODDIR)
	$(FC) $(FCFLAGS) -J$(MODDIR) -c -o $@ $<
%.o: %.F
	@mkdir -p $(MODDIR)
	$(FC) $(FCFLAGS) -J$(MODDIR) -c -o $@ $<
%.o: %.f90
	@mkdir -p $(MODDIR)
	$(FC) $(FCFLAGS) -J$(MODDIR) -c -o $@ $<
%.o: %.F90
	@mkdir -p $(MODDIR)
	$(FC) $(FCFLAGS) -J$(MODDIR) -c -o $@ $<

list-sources:
	@echo "All Fortran sources found:"
	@printf "%s\n" $(ALL_SOURCES)
	@echo
	@echo "Resolved ordered sources (built first):"
	@printf "%s\n" $(ORDERED_SOURCES)
	@echo
	@echo "Remaining sources (built after the above):"
	@printf "%s\n" $(OTHER_SOURCES)

clean:
	@echo "Removing object files and module files..."
	-@find . -name '*.o' -type f -delete
	-@find . -name '*.mod' -type f -delete
	-@find . -name '*.mod.*' -type f -delete
	-@rm -rf $(MODDIR)

distclean: clean
	-@rm -f $(BINARY)

help:
	@echo "Usage:"
	@echo "  make            Build binary ($(BINARY))"
	@echo "  make FC=ifort   Use another compiler"
	@echo "  make FCFLAGS='...'  Override flags"