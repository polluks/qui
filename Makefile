CC = gcc
LD = $(CC)
AR = ar

CFLAGS ?= -O2 -g

DESTDIR ?=

# Allow users to override build settings without dirtying their trees
# For debugging, put this in local.mk:
#
#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
#
DFRAME_LOCAL_CONFIG ?= local.mk
-include ${DFRAME_LOCAL_CONFIG}

LIB_OBJS :=
LIB_OBJS += util.o
LIB_OBJS += list.o
LIB_OBJS += qui.o
LIB_OBJS += app.o
LIB_OBJS += window.o
LIB_OBJS += view.o

TESTS :=
TESTS += test/list

EXAMPLES :=
EXAMPLES += example/basic

PROGRAMS :=
PROGRAMS += $(TESTS) $(EXAMPLES)

all:

cflags = -fno-strict-aliasing
cflags += -Wall -Wwrite-strings
cflags += -I.

OSNAME := $(shell uname)
ifeq ($(OSNAME),Darwin)
ldflags += -framework Cocoa
ldflags += -Lplatform/mac-cocoa
LIBS += platform/mac-cocoa/libqui-mac-cocoa.a
# TODO: recursive make libqui-mac-cocoa.a
else
$(error Your OS is not supported yet)
endif

LIBS += libqui.a
OBJS := $(LIB_OBJS) $(EXTRA_OBJS) $(PROGRAMS:%=%.o)

# Pretty print
V := @
Q := $(V:1=)

all: $(PROGRAMS)

ldflags += $($(@)-ldflags) $(LDFLAGS)
ldlibs += $($(@)-ldlibs)  $(LDLIBS)
$(PROGRAMS): % : %.o $(LIBS)
	@echo "  LD      $@"
	$(Q)$(LD) $(ldflags) $^ $(ldlibs) -o $@

libqui.a: $(LIB_OBJS)
	@echo "  AR      $@"
	$(Q)$(AR) rcs $@ $^


cflags += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
%.o: %.c
	@echo "  CC      $@"
	$(Q)$(CC) $(cflags) -c -o $@ $<

clean:
	@echo "  CLEAN"
	@rm -f *.[oa] .*.d $(PROGRAMS)
