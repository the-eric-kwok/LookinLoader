//
//  RHRevealLoader.xm
//  RHRevealLoader
//
//  Created by Richard Heard on 21/03/2014.
//  Copyright (c) 2014 Richard Heard. All rights reserved.
//

#include <Foundation/Foundation.h>
#include <dlfcn.h>

%ctor {
    @autoreleasepool {

        NSArray *possibleLibraryPaths = @[
            @"/Library/LookinLoader/LookinServer",
            @"/private/preboot/E9CC79F022012F43DBF23CB479D6560437265815/jb-3gihKswR/procursus/Library/LookinLoader/LookinServer",
        ];

        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

        // Skip loading the tweak if the current process is SpringBoard
        if ([bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
            NSLog(@"LookinLoader(%@): Skipping for SpringBoard", bundleIdentifier);
            return;
        }

        BOOL isLoaded = NO;

        for (NSString *libraryPath in possibleLibraryPaths) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
                if (dlopen([libraryPath UTF8String], RTLD_NOW)) {
                    isLoaded = YES;
                    NSLog(@"LookinLoader(%@): loaded from %@", bundleIdentifier, libraryPath);
                } else {
                    char* err = dlerror();
                    NSLog(@"LookinLoader(%@):[ERROR] failed to load from %@, because of error %s", bundleIdentifier, libraryPath, err);
                }
            }
        }

        if (!isLoaded) {
            NSLog(@"LookinLoader(%@):[ERROR] LookinServer not found", bundleIdentifier);
        }
    }
}
