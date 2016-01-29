//
//  RealmPerson.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "RealmPerson.h"

@implementation RealmPerson

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"uuid" : [[NSUUID UUID] UUIDString],
             @"name" : @"",
             @"imageData" : [NSData data]};
}

+ (NSArray *)requiredProperties {
    return @[@"name", @"uuid", @"imageData"];
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
