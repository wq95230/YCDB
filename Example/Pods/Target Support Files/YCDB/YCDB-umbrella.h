#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DBManager.h"
#import "AGDatabase+Sqlite.h"
#import "AGDatabase.h"

FOUNDATION_EXPORT double YCDBVersionNumber;
FOUNDATION_EXPORT const unsigned char YCDBVersionString[];

