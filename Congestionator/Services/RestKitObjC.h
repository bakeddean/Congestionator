//
//  NSObject+RestKitObjC.h
//  FloorMaps
//
//  Created by Malcolm Pullman on 12/01/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface RestKitObjC : NSObject
+ (void) initLoggingForObjectMapping:(NSString*)objectMappingLevel andCoreData:(NSString*)coreDataLevel;
@end
