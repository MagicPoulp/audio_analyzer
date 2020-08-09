cmake_minimum_required(VERSION 3.10.2)

# we use IMPORTED because fftw3 is pre-built
# https://stackoverflow.com/questions/40352177/imported-lib-notfound-in-building-ffmpeg-3-2-for-android-studio-2-2
# https://developer.android.com/studio/projects/configure-cmake
# https://stackoverflow.com/questions/37924383/combining-several-static-libraries-into-one-using-cmake
# https://stackoverflow.com/questions/11429055/cmake-how-create-a-single-shared-library-from-all-static-libraries-of-subprojec
message(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
message(bin: ${CMAKE_CURRENT_BINARY_DIR})
if(${CMAKE_CURRENT_BINARY_DIR} MATCHES "arm64-v8a")
    set(LIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/fftw_library4/lib/libfftw3.a)
endif()
if(${CMAKE_CURRENT_BINARY_DIR} MATCHES "armeabi-v7a")
    set(LIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/fftw_library3/lib/libfftw3.a)
endif()
if(${CMAKE_CURRENT_BINARY_DIR} MATCHES "x86$")
    set(LIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/fftw_library1/lib/libfftw3.a)
endif()
if(${CMAKE_CURRENT_BINARY_DIR} MATCHES "x86_64$")
    set(LIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/fftw_library2/lib/libfftw3.a)
endif()

message(LIB_PATH: ${LIB_PATH})
add_library(fftw3 STATIC IMPORTED)
set_target_properties( # Specifies the target library.
                       fftw3

                       # Specifies the parameter you want to define.
                       PROPERTIES IMPORTED_LOCATION

                       # Provides the path to the library you want to import.
                       #                       fftw_library/lib/libfftw3.a )
                       # a full path is required
                       ${LIB_PATH} )

add_library( fftw_plugin
  #             STATIC
             SHARED
             ./src/fftw_plugin.cpp )

SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fpermissive")
target_include_directories(fftw_plugin PRIVATE fftw_library/include)

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

#target_link_libraries(fftw_plugin PRIVATE ${FFTW3_LIBRARY} m)
# maybe PRIVATE is enough here
target_link_libraries(fftw_plugin PUBLIC fftw3 m)

# https://stackoverflow.com/questions/7935421/linking-archives-a-into-shared-object-so
#set_target_properties(fftw_plugin PROPERTIES
  #LINK_FLAGS "-Wl,--allow-multiple-definition --whole-archive ${CMAKE_CURRENT_SOURCE_DIR}/fftw_library/lib/libfftw3.a"
  #  LINK_FLAGS "-Wl,--whole-archive ${CMAKE_CURRENT_SOURCE_DIR}/fftw_library/lib/libfftw3.a --allow-multiple-definition -Wl,--no-whole-archive"
#)
