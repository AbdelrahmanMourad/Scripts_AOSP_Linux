/*

Android Build path:
***** This contains what you need to flash your device 
(system.img & system)
(product.img & product)
super.img => contains everything
The system directory contains the most of the operation system libraries 
aosp/out/target/product/vsoc_x86_64_only(Target_for_cuttlefish)/system/
_______________________________________________________________
total 124
drwxrwxr-x 13 mourad mourad  4096 Aug 16 17:06 ./
drwxrwxr-x 24 mourad mourad  4096 Aug 16 20:30 ../
drwxrwxr-x  2 mourad mourad  4096 Aug 16 20:29 apex/
drwxrwxr-x 23 mourad mourad  4096 Aug 16 20:09 app/
drwxrwxr-x  4 mourad mourad 16384 Aug 16 20:09 bin/
-rw-rw-r--  1 mourad mourad  5356 Aug 16 17:06 build.prop
drwxrwxr-x 17 mourad mourad  4096 Aug 16 20:29 etc/
drwxrwxr-x  2 mourad mourad 12288 Aug 16 17:06 fonts/
drwxrwxr-x  4 mourad mourad 12288 Aug 16 20:12 framework/
drwxrwxr-x  2 mourad mourad  4096 Aug 16 17:06 lib/
drwxrwxr-x  4 mourad mourad 36864 Aug 16 20:09 lib64/
drwxrwxr-x 44 mourad mourad  4096 Aug 16 20:09 priv-app/
lrwxrwxrwx  1 mourad mourad     8 Aug 16 17:06 product -> /product
lrwxrwxrwx  1 mourad mourad    11 Aug 16 17:06 system_ext -> /system_ext
drwxrwxr-x  7 mourad mourad  4096 Aug 16 20:04 usr/
lrwxrwxrwx  1 mourad mourad     7 Aug 16 17:06 vendor -> /vendor
drwxrwxr-x  2 mourad mourad  4096 Aug 16 17:06 xbin/
_______________________________________________________________


***** Contains the apps that are built for cuttlefish
aosp/out/target/product/vsoc_x86_64_only/system/app


***** Contains priviliged-apps like shell, proxyHandler, Wifi,..etc.
aosp/out/target/product/vsoc_x86_64_only/system/priv-app


***** Contains all the Java libraries (.jar) files
aosp/out/target/product/vsoc_x86_64_only/system/framework


***** Contains all the C++ libraries (.so) files
aosp/out/target/product/vsoc_x86_64_only/system/lib


***** Contains applications such as (ZIP, make, sdcard) 
        any thing you need to work with target via the command line 
        is located in the bin directory
aosp/out/target/product/vsoc_x86_64_only/system/bin


***** applications that comes with libraries for Java/C++
        {{{{""""  It's only for OS developer  """"}}}}.
aosp/out/target/product/vsoc_x86_64_only/system/apex


***** preloaded classes like zygote, that you can later use as application deveoper
aosp/out/target/product/vsoc_x86_64_only/system/etc


*****
aosp/out/target/product/vsoc_x86_64_only/system/usr


*****
aosp/out/target/product/vsoc_x86_64_only/system/fonts





*/