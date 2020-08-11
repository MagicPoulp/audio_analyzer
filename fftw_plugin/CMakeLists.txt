cmake_minimum_required(VERSION 3.10.2)

# THis cmake file can only be built if libfftw3.a are pre-built first
# See the README.md file in the folder fftw_plugin
# to pre-compile the libfftw3.a static library on 4 architectures

# we use IMPORTED because fftw3 is pre-built
# https://stackoverflow.com/questions/40352177/imported-lib-notfound-in-building-ffmpeg-3-2-for-android-studio-2-2
# https://developer.android.com/studio/projects/configure-cmake
# https://stackoverflow.com/questions/37924383/combining-several-static-libraries-into-one-using-cmake
# https://stackoverflow.com/questions/11429055/cmake-how-create-a-single-shared-library-from-all-static-libraries-of-subprojec

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
             SHARED
             ./src/fftw_plugin.cpp )

SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fpermissive")
target_include_directories(fftw_plugin PRIVATE fftw_library1/include)
target_link_libraries(fftw_plugin PRIVATE fftw3 m)
