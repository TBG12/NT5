#
# DO NOT EDIT THIS FILE!!!  Edit .\sources. if you want to add a new source
# file to this component.  This file merely indirects to the real make file
# that is shared by all the components of NT OS/2
#
#!INCLUDE $(NTMAKEENV)\makefile.def

BASEDIR=$(_NTDRIVE)$(_NTROOT)

INCLUDES=-I$(BASEDIR)\public\sdk\inc -I$(BASEDIR)\public\sdk\inc\crt -I$(BASEDIR)\public\internal\ds\inc
DEFINES=-DNDEBUG -DWIN32_LEAN_AND_MEAN -DWIN32 -D_WIN32 -DUNICODE -D_UNICODE
CFLAGS=/c /Zel /Zp8 /W3 /WX /Gz /Gi- /Gm- /GX- /GR- /GF -Z7 /Od

obj\i386\shortsig00.lib: .\Release\shortsig2000.obj .\Release\field.obj .\Release\kpolys.obj obj\i386
	lib -out:obj\i386\shortsig00.lib .\Release\shortsig2000.obj .\Release\field.obj .\Release\kpolys.obj

.\Release\shortsig2000.obj: shortsig2000.c shortsig2000.h kpolys.h field.h .\Release
	cl -nologo $(INCLUDES) $(DEFINES) $(CFLAGS) shortsig2000.c /Fo.\Release\shortsig2000.obj

.\Release\field.obj: field.c field.h .\Release
	cl -nologo $(INCLUDES) $(DEFINES) $(CFLAGS) field.c /Fo.\Release\field.obj

.\Release\kpolys.obj: kpolys.c kpolys.h field.h .\Release
	cl -nologo $(INCLUDES) $(DEFINES) $(CFLAGS) kpolys.c /Fo.\Release\kpolys.obj

.\Release:
	md Release

obj\i386:
	md obj
	md obj\i386
