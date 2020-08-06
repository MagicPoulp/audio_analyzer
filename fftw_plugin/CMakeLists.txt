cmake_minimum_required(VERSION 3.10.2)

add_library( fftw_plugin_static
             STATIC
             ./src/fftw_plugin.cpp )

SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fpermissive")
target_include_directories(fftw_plugin_static PRIVATE fftw_library/include)

link_directories(fftw_library/lib)
find_library(FFTW3_LIBRARY fftw3 HINTS fftw_library/lib)

message(MESSAGE)
message(${FFTW3_LIBRARY})
message(${CMAKE_CURRENT_SOURCE_DIR}/fftw_library/lib)

target_link_libraries(fftw_plugin_static PRIVATE ${FFTW3_LIBRARY})

add_library(fftw_plugin SHARED)
target_link_libraries(fftw_plugin PUBLIC fftw_plugin_static)
