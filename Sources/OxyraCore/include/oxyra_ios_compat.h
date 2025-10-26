#ifndef OXYRA_IOS_COMPAT_H
#define OXYRA_IOS_COMPAT_H

// iOS-specific compatibility fixes for C++ compilation

#ifdef __cplusplus
extern "C" {
#endif

// Fix for iOS SDK C++ standard library compatibility
#ifdef __APPLE__
    #ifdef __cplusplus
        // Enable deprecated C++ features for iOS compatibility
        #define _LIBCPP_ENABLE_CXX17_REMOVED_UNARY_BINARY_FUNCTION 1
        #define _LIBCPP_ENABLE_CXX17_REMOVED_AUTO_PTR 1
        
        // Fix for missing C++ standard library features on iOS
        #ifndef _LIBCPP_VERSION
            #define _LIBCPP_VERSION 14000
        #endif
        
        // Ensure proper C++ standard library includes
        #include <cstdint>
        #include <cstddef>
        #include <cstdlib>
        #include <cstring>
        #include <cstdio>
        #include <exception>
        #include <string>
        #include <memory>
    #endif
#endif

// iOS-specific type definitions
#ifdef __APPLE__
    #ifndef size_t
        typedef unsigned long size_t;
    #endif
    
    #ifndef ssize_t
        typedef long ssize_t;
    #endif
#endif

#ifdef __cplusplus
}
#endif

#endif // OXYRA_IOS_COMPAT_H
