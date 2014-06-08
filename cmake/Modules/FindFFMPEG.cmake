# - Try to find ffmpeg libraries (libavcodec, libavformat and libavutil)
# Once done this will define
#
#  FFMPEG_FOUND - system has ffmpeg or libav
#  FFMPEG_INCLUDE_DIR - the ffmpeg include directory
#  FFMPEG_LIBRARIES - Link these to use ffmpeg
#  FFMPEG_LIBAVCODEC
#  FFMPEG_LIBAVFORMAT
#  FFMPEG_LIBAVUTIL
#  FFMPEG_LIBSWRESAMPLE
#
#  Copyright (c) 2008 Andreas Schneider <mail@cynapses.org>
#  Modified for other libraries by Lasse Kärkkäinen <tronic>
#  Modified for Hedgewars by Stepik777
#  Modified to use LibFindMacros by CaptainHayashi
#
#  Redistribution and use is allowed according to the terms of the New
#  BSD license.
#

include(LibFindMacros)

if (FFMPEG_LIBRARIES AND FFMPEG_INCLUDE_DIR)
  # in cache already
  set(FFMPEG_FOUND TRUE)
else (FFMPEG_LIBRARIES AND FFMPEG_INCLUDE_DIR)
  libfind_pkg_check_modules(_FFMPEG_AVCODEC libavcodec)
  libfind_pkg_check_modules(_FFMPEG_AVFORMAT libavformat)
  libfind_pkg_check_modules(_FFMPEG_AVUTIL libavutil)
  libfind_pkg_check_modules(_FFMPEG_SWRESAMPLE libswresample)

  find_path(FFMPEG_AVCODEC_INCLUDE_DIR
    NAMES libavcodec/avcodec.h
    PATHS ${_FFMPEG_AVCODEC_INCLUDE_DIRS} /usr/include /usr/local/include /opt/local/include /sw/include
    PATH_SUFFIXES ffmpeg libav
  )

  find_library(FFMPEG_LIBAVCODEC
    NAMES avcodec
    PATHS ${_FFMPEG_AVCODEC_LIBRARY_DIRS} /usr/lib /usr/local/lib /opt/local/lib /sw/lib
  )

  find_library(FFMPEG_LIBAVFORMAT
    NAMES avformat
    PATHS ${_FFMPEG_AVFORMAT_LIBRARY_DIRS} /usr/lib /usr/local/lib /opt/local/lib /sw/lib
  )

  find_library(FFMPEG_LIBAVUTIL
    NAMES avutil
    PATHS ${_FFMPEG_AVUTIL_LIBRARY_DIRS} /usr/lib /usr/local/lib /opt/local/lib /sw/lib
  )

  find_library(FFMPEG_LIBSWRESAMPLE
    NAMES swresample
    PATHS ${_FFMPEG_SWRESAMPLE_LIBRARY_DIRS} /usr/lib /usr/local/lib /opt/local/lib /sw/lib
  )

  set(FFMPEG_PROCESS_INCLUDES FFMPEG_AVCODEC_INCLUDE_DIR)
  set(FFMPEG_PROCESS_LIBS
    FFMPEG_LIBAVCODEC
    FFMPEG_LIBAVFORMAT
    FFMPEG_LIBAVUTIL
    FFMPEG_LIBSWRESAMPLE
  )
  libfind_process(FFMPEG)
endif (FFMPEG_LIBRARIES AND FFMPEG_INCLUDE_DIR)

