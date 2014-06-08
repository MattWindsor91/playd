# - Try to find Portaudio
# Once done this will define
#
#  PORTAUDIO_FOUND - system has Portaudio
#  PORTAUDIO_INCLUDE_DIR - the Portaudio include directory
#  PORTAUDIO_LIBRARIES - Link these to use Portaudio
#  PORTAUDIO_DEFINITIONS - Compiler switches required for using Portaudio
#  PORTAUDIO_VERSION - Portaudio version
#
#  Copyright (c) 2006 Andreas Schneider <mail@cynapses.org>
#  Fixes backported from FindFFMPEG.cmake, which is:
#    Copyright (c) 2008 Andreas Schneider <mail@cynapses.org>
#    Modified for other libraries by Lasse Kärkkäinen <tronic>
#    Modified for Hedgewars by Stepik777
#  Modified to use LibFindMacros by CaptainHayashi
#
# Redistribution and use is allowed according to the terms of the New BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

include(LibFindMacros)

if (PORTAUDIO_LIBRARIES AND PORTAUDIO_INCLUDE_DIR)
  # in cache already
  set(PORTAUDIO_FOUND TRUE)
else (PORTAUDIO_LIBRARIES AND PORTAUDIO_INCLUDE_DIR)
  libfind_pkg_check_modules(_PORTAUDIO portaudio-2.0)

  find_path(PORTAUDIO_INCLUDE_DIR
    NAMES portaudio.h
    PATHS ${_PORTAUDIO_INCLUDE_DIRS} /usr/include /usr/local/include /opt/local/include /sw/include
    PATH_SUFFIXES portaudio portaudio2
  )

  find_library(PORTAUDIO_LIBRARY
    NAMES portaudio
    PATHS ${_PORTAUDIO_LIBRARY_DIRS} /usr/lib /usr/local/lib /opt/local/lib /sw/lib
  )

  set(PORTAUDIO_PROCESS_INCLUDES PORTAUDIO_INCLUDE_DIR)
  set(PORTAUDIO_PROCESS_LIBS PORTAUDIO_LIBRARY)
  libfind_process(PORTAUDIO)
endif (PORTAUDIO_LIBRARIES AND PORTAUDIO_INCLUDE_DIR)
