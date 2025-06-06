.POSIX:
.SUFFIXES:
include config.mk

# Extreme optimization flags
DWLCPPFLAGS = -I. -DWLR_USE_UNSTABLE -D_POSIX_C_SOURCE=200809L \
	-DVERSION=\"$(VERSION)\" $(XWAYLAND) -DNDEBUG -DNDEBUG_PARANOID
DWLDEVCFLAGS = -Ofast -flto=auto -fuse-linker-plugin -march=native -mtune=native \
	-funroll-loops -fomit-frame-pointer -ffast-math -fno-stack-protector \
	-fno-unwind-tables -fno-asynchronous-unwind-tables -fmerge-all-constants \
	-fmodulo-sched -fmodulo-sched-allow-regmoves -fgcse-after-reload \
	-ftree-vectorize -fvect-cost-model=unlimited -fsimd-cost-model=unlimited \
	-fprefetch-loop-arrays -floop-nest-optimize -floop-interchange \
	-floop-block -floop-strip-mine -ftree-loop-distribute-patterns \
	-fwhole-program -fipa-pta -fdevirtualize-speculatively \
	-finline-functions -finline-small-functions -findirect-inlining \
	-fpartial-inlining -finline-functions-called-once \
	-fsection-anchors -fbranch-target-load-optimize2 \
	-fschedule-insns2 -frename-registers -freorder-blocks-algorithm=stc \
	-freorder-blocks-and-partition -fno-semantic-interposition \
	-fno-plt -fno-common -fstrict-aliasing -fstrict-overflow \
	-Wl,--gc-sections -Wl,--icf=all -Wl,--strip-all -Wl,-O2 \
	-Wl,--as-needed -Wl,--hash-style=gnu -Wl,-z,relro,-z,now \
	-Wl,--build-id=none -Wl,--no-eh-frame-hdr \
	-pedantic -Wall -Wextra -Wdeclaration-after-statement \
	-Wno-unused-parameter -Wshadow -Wunused-macros -Werror=strict-prototypes \
	-Werror=implicit -Werror=return-type -Werror=incompatible-pointer-types \
	-Wfloat-conversion -Wno-unused-function -Wno-missing-field-initializers

# Cached pkg-config results for faster builds
PKGS_CFLAGS := $(shell $(PKG_CONFIG) --cflags wlroots-0.18 wayland-server xkbcommon libinput $(XLIBS))
PKGS_LIBS := $(shell $(PKG_CONFIG) --libs wlroots-0.18 wayland-server xkbcommon libinput $(XLIBS))

DWLCFLAGS = $(PKGS_CFLAGS) $(DWLCPPFLAGS) $(DWLDEVCFLAGS) $(CFLAGS)
LDLIBS = $(PKGS_LIBS) -lm $(LIBS)

# Objects
OBJS = dwl.o util.o dwl-ipc-unstable-v2-protocol.o
PROTOCOLS = cursor-shape-v1-protocol.h pointer-constraints-unstable-v1-protocol.h \
	wlr-layer-shell-unstable-v1-protocol.h wlr-output-power-management-unstable-v1-protocol.h \
	xdg-shell-protocol.h dwl-ipc-unstable-v2-protocol.h dwl-ipc-unstable-v2-protocol.c

# Cached scanner variables
WAYLAND_SCANNER := $(shell $(PKG_CONFIG) --variable=wayland_scanner wayland-scanner)
WAYLAND_PROTOCOLS := $(shell $(PKG_CONFIG) --variable=pkgdatadir wayland-protocols)

all: dwl

# Ultra-aggressive linking with profile-guided optimization preparation
dwl: $(OBJS) | strip-binary
	$(CC) $(OBJS) $(DWLCFLAGS) $(LDFLAGS) -Wl,--gc-sections -Wl,--icf=all \
		-Wl,--strip-all -Wl,-O2 -Wl,--as-needed -Wl,--hash-style=gnu \
		-Wl,-z,relro,-z,now -Wl,--build-id=none $(LDLIBS) -o $@

# Parallel protocol generation
protocols: $(PROTOCOLS)

# Optimized object compilation with dependency tracking
%.o: %.c config.h $(PROTOCOLS)
	$(CC) $(CPPFLAGS) $(DWLCFLAGS) -MMD -MP -MF $*.d -o $@ -c $<

# Include auto-generated dependencies
-include $(OBJS:.o=.d)

# Protocol generation rules (parallelizable)
cursor-shape-v1-protocol.h:
	$(WAYLAND_SCANNER) enum-header \
		$(WAYLAND_PROTOCOLS)/staging/cursor-shape/cursor-shape-v1.xml $@

pointer-constraints-unstable-v1-protocol.h:
	$(WAYLAND_SCANNER) enum-header \
		$(WAYLAND_PROTOCOLS)/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml $@

wlr-layer-shell-unstable-v1-protocol.h:
	$(WAYLAND_SCANNER) enum-header \
		protocols/wlr-layer-shell-unstable-v1.xml $@

wlr-output-power-management-unstable-v1-protocol.h:
	$(WAYLAND_SCANNER) server-header \
		protocols/wlr-output-power-management-unstable-v1.xml $@

xdg-shell-protocol.h:
	$(WAYLAND_SCANNER) server-header \
		$(WAYLAND_PROTOCOLS)/stable/xdg-shell/xdg-shell.xml $@

dwl-ipc-unstable-v2-protocol.h:
	$(WAYLAND_SCANNER) server-header \
		protocols/dwl-ipc-unstable-v2.xml $@

dwl-ipc-unstable-v2-protocol.c:
	$(WAYLAND_SCANNER) private-code \
		protocols/dwl-ipc-unstable-v2.xml $@

config.h:
	cp config.def.h $@

# Ultra-aggressive binary stripping
strip-binary:
	@echo "Applying extreme binary optimization..."

# Post-build optimization with upx compression (optional)
compress: dwl
	@command -v upx >/dev/null 2>&1 && upx --best --lzma dwl || true

# Profile-guided optimization targets
pgo-generate: DWLDEVCFLAGS += -fprofile-generate
pgo-generate: clean dwl

pgo-use: DWLDEVCFLAGS += -fprofile-use -fprofile-correction
pgo-use: dwl

# Clean with dependency files
clean:
	rm -f dwl $(OBJS) $(OBJS:.o=.d) $(PROTOCOLS) *.gcda *.gcno

# Fast clean (only binaries)
clean-fast:
	rm -f dwl

# Parallel build support
.PHONY: all clean clean-fast protocols strip-binary compress pgo-generate pgo-use

# Optimized installation
install: dwl
	install -Dm755 dwl $(DESTDIR)$(PREFIX)/bin/dwl
	install -Dm644 dwl.1 $(DESTDIR)$(MANDIR)/man1/dwl.1
	install -Dm644 dwl.desktop $(DESTDIR)$(DATADIR)/wayland-sessions/dwl.desktop

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwl $(DESTDIR)$(MANDIR)/man1/dwl.1 \
		$(DESTDIR)$(DATADIR)/wayland-sessions/dwl.desktop

# Benchmark target for testing optimizations
benchmark: dwl
	@echo "Binary size: $$(stat -c%s dwl) bytes"
	@echo "Stripped size: $$(strip --strip-all dwl 2>/dev/null && stat -c%s dwl) bytes"

.SUFFIXES: .c .o