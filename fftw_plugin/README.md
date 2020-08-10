Valid architecture names are: i386 x86_64 x86_64h armv4t arm armv5e armv6 armv6m armv7 armv7em armv7k armv7m armv7s arm64 arm64_32 ppc ppc64

https://stackoverflow.com/questions/21990021/how-to-determine-host-value-for-configure-when-using-cross-compiler

We compile statically the fftw3 library in C using the android studio compiler
Then we make a shared library from it

fftw-3.3.8.tar.gz
http://www.fftw.org/fftw3_doc/Complex-One_002dDimensional-DFTs.html

The compiler commands can be compied from the android studio logs and passed to the configure command
The commands below build the third party library fftw3.
Then Android studio creates 4 .so files here:
/home/thierry/repos/audio_analyzer/build/app/intermediates/cmake/debug/obj/

--enable-float is added to use float instead of double

x86:
./configure --enable-float -prefix ~/repos/audio_analyzer/fftw_plugin/fftw_library1 CC="/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/bin/clang --target=i686-none-linux-android16 --gcc-toolchain=/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64 --sysroot=/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/sysroot  -Dfftw_plugin_EXPORTS -I/home/thierry/repos/audio_analyzer/fftw_plugin/fftw_library/include  -g -DANDROID -fdata-sections -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -mstackrealign -D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security   -fpermissive -O0 -fno-limit-debug-info  -fPIC" --host=x86 && make && make install

x86_64:
./configure --enable-float -prefix ~/repos/audio_analyzer/fftw_plugin/fftw_library2 CC="/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/bin/clang --target=x86_64-none-linux-android21 --gcc-toolchain=/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64 --sysroot=/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/sysroot  -Dfftw_plugin_EXPORTS -I/home/thierry/repos/audio_analyzer/fftw_plugin/fftw_library/include  -g -DANDROID -fdata-sections -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security   -fpermissive -O0 -fno-limit-debug-info  -fPIC" --host=amd64 && make && make install

arm7:
./configure --enable-float -prefix ~/repos/audio_analyzer/fftw_plugin/fftw_library3 CC="/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/bin/clang --target=armv7-none-linux-androideabi16 --gcc-toolchain=/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64 --sysroot=/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/sysroot  -Dfftw_plugin_EXPORTS -I/home/thierry/repos/audio_analyzer/fftw_plugin/fftw_library/include  -g -DANDROID -fdata-sections -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -D_FORTIFY_SOURCE=2 -march=armv7-a -mthumb -Wformat -Werror=format-security   -fpermissive -O0 -fno-limit-debug-info  -fPIC" --host=arm && make && make install

arm64:
./configure --enable-float -prefix ~/repos/audio_analyzer/fftw_plugin/fftw_library4 CC="/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/bin/clang --target=aarch64-none-linux-android21 --gcc-toolchain=/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64 --sysroot=/home/thierry/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/sysroot  -Dfftw_plugin_EXPORTS -I/home/thierry/repos/audio_analyzer/fftw_plugin/fftw_library/include  -g -DANDROID -fdata-sections -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security   -fpermissive -O0 -fno-limit-debug-info  -fPIC" --host=arm && make && make install
