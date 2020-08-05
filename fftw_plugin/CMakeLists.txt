cmake_minimum_required(VERSION 3.6)

add_library( fftw_plugin
             STATIC
             ./src/fftw_plugin.cpp )

target_include_directories(fftw_plugin PRIVATE fftw_library/include)

target_link_directories(fftw_plugin PRIVATE fftw_library/lib)

target_link_libraries(fftw_plugin PRIVATE fftw3 m)

SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fpermissive")

#add_executable(test ./src/test.cpp)

#target_link_libraries(test PRIVATE fftw_plugin PRIVATE)

#target_link_directories(test PRIVATE fftw_library/lib)
