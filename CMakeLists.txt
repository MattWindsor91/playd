cmake_minimum_required(VERSION 2.8)
project(playslave++)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

include(EnableCXX11)

# Why is this explicit?
# See https://www.mail-archive.com/cmake@cmake.org/msg04904.html
set(SRC audio.cpp
        audio.h
        audio_av.cpp
        audio_av.h
        audio_cb.cpp
        audio_cb.h
        audio_resample.cpp
        audio_resample.h
        cmd.cpp
        cmd.h
        errors.cpp
        errors.hpp
        io.cpp
        io.hpp
        main.cpp
        messages.h
        player.cpp
        player.h
        resource.h
        ringbuffer.hpp
        sample_formats.hpp
	contrib/pa_ringbuffer.c
	contrib/pa_ringbuffer.h)

add_executable(playslave++ ${SRC})
    
find_package(FFMPEG REQUIRED)
include_directories(${FFMPEG_INCLUDE_DIRS})
set(LIBS ${LIBS} ${FFMPEG_LIBRARIES})

find_package(Portaudio REQUIRED)
include_directories(${PORTAUDIO_INCLUDE_DIRS})
set(LIBS ${LIBS} ${PORTAUDIO_LIBRARIES})

message(STATUS ${LIBS})
target_link_libraries(playslave++ ${LIBS})
