cmake_minimum_required(VERSION 3.10.2)

# we use IMPORTED because fftw3 is pre-built
# https://stackoverflow.com/questions/40352177/imported-lib-notfound-in-building-ffmpeg-3-2-for-android-studio-2-2
# https://developer.android.com/studio/projects/configure-cmake

add_library(fftw3 STATIC IMPORTED)
set_target_properties( # Specifies the target library.
                       fftw3

                       # Specifies the parameter you want to define.
                       PROPERTIES IMPORTED_LOCATION

                       # Provides the path to the library you want to import.
                       fftw_library/lib/libfftw3.a )

add_library( fftw_plugin_static
             STATIC
             ./src/fftw_plugin.cpp )

SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fpermissive")
target_include_directories(fftw_plugin_static PRIVATE fftw_library/include)

#link_directories(fftw_library/lib)
# TO DEBUG this is the command that does not work
#find_library(FFTW3_LIBRARY fftw3 HINTS fftw_library/lib)
#find_library(
 #   FFTW3_LIBRARY
 #   NAMES fftw3
 #   PATHS /home/thierry/repos/audio_analyzer/fftw_plugin/fftw_library
 #   PATH_SUFFIXES lib
 #   NO_DEFAULT_PATH
#)

#message(MESSAGE)
#message(${FFTW3_LIBRARY})
#message(${CMAKE_CURRENT_SOURCE_DIR}/fftw_library/lib)

#target_link_libraries(fftw_plugin_static PRIVATE ${FFTW3_LIBRARY} m)
target_link_libraries(fftw_plugin_static PRIVATE fftw3 m)

#add_library(fftw_plugin SHARED)
#target_link_libraries(fftw_plugin PUBLIC fftw_plugin_static ${FFTW3_LIBRARY} m)
