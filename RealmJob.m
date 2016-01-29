//
//  RealmJob.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "RealmJob.h"

@implementation RealmJob

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"uuid" : [[NSUUID UUID] UUIDString],
             @"name" : @""};
}

+ (NSArray *)requiredProperties {
    return @[@"name"];
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end