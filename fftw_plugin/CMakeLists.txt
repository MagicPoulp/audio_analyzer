add_library( fftw_plugin

             # Sets the library as a shared library.
             STATIC

             # Provides a relative path to your source file(s).
             ./src/fftw_plugin.cpp )

target_include_directories(fftw_plugin PRIVATE fftw_library/include)
