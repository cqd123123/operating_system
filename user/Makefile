INCLUDES = -I../include/

#CROSS_COMPILE := /usr/eldk/usr/bin/mips_4KC-
#CC			  := $(CROSS_COMPILE)gcc
#CFLAGS		  := -O -G 0 -mno-abicalls -fno-builtin -Wa,-xgot -Wall -fPIC
#LD			  := $(CROSS_COMPILE)ld
# For embedding one program in another

USERLIB := printf.o \
		print.o \
		libos.o \
		fork.o \
		pgfault.o \
		syscall_lib.o \
		ipc.o \
		string.o \
		fd.o \
                fs.o\
                ide_asm.o\
                ide.o\
		pageref.o \
		file.o \
		fsipc.o \
		wait.o \
		spawn.o \
		pipe.o \
		console.o \
		fprintf.o

CFLAGS += -nostdlib -static

all: fktest.x fktest.b testfdsharing.x testfdsharing.b pingpong.x pingpong.b idle.x testspawn.x testarg.b testpipe.x testpiperace.x icode.x init.b init.x sh.b sh.x  serv.o serv.x cat.b ls.b ls.x $(USERLIB) entry.o syscall_wrap.o

%.x: %.b.c
	echo cc1 $<
	$(CC) $(CFLAGS) -c -o $@ $<

%.b.c: %.b
	echo create $@
	echo bintoc $* $< > $@~
	./bintoc $* $< > $@~ && mv -f $@~ $@
#	grep \. $@
	
%.b: entry.o syscall_wrap.o %.o $(USERLIB)
	echo ld $@
	$(LD) -o $@ $(LDFLAGS) -G 0 -static -n -nostdlib -T ./user.lds $^

%.o: %.c
	echo user1 cc $<
	$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

%.o: %.S
	echo as $<
	$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

%.o: lib.h

.PHONY: clean

clean:
	rm -rf *~ *.o *.b.c *.x *.b

include ../include.mk
