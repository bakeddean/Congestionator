//
//  NSObject+RestKitObjC.m
//  FloorMaps
//
//  Created by Malcolm Pullman on 12/01/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

#import "RestKitObjC.h"

@implementation RestKitObjC : NSObject

+ (void) initLoggingForObjectMapping:(NSString*)objectMappingLevel andCoreData:(NSString*)coreDataLevel {
    RKLogConfigureByName("RestKit/ObjectMapping", [self getEnumForString:objectMappingLevel]);
    RKLogConfigureByName("RestKit/CoreData", [self getEnumForString:coreDataLevel]);
}

+ (enum _RKlcl_enum_level_t) getEnumForString:(NSString*)string {
    if ([string isEqual: @"Off"]) {
        return RKLogLevelOff;
    } else if ([string isEqual: @"Critical"]) {
        return RKLogLevelCritical;
    } else if ([string isEqual: @"Error"]) {
        return RKLogLevelCritical;
    } else if ([string isEqual: @"Warning"]) {
        return RKLogLevelWarning;
    } else if ([string isEqual: @"Info"]) {
        return RKLogLevelInfo;
    } else if ([string isEqual: @"Debug"]) {
        return RKLogLevelDebug;
    } else if ([string isEqual: @"Trace"]) {
        return RKLogLevelTrace;
    } else {
        NSLog(@"WARNING: A Restkit logging level has has been set in Config.plist, but is not a recongised value. Defaulting to 'Off'");
        return RKLogLevelOff;
    }
}

@end

/*
#define RKLogLevelOff
#define RKLogLevelCritical
#define RKLogLevelError
#define RKLogLevelWarning
#define RKLogLevelInfo
#define RKLogLevelDebug
#define RKLogLevelTrace

*/
