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
    return @{@"name" : @"",
             @"imageData" : [NSData data]};
}

+ (NSArray *)requiredProperties {
    return @[@"name", @"uuid", @"imageData"];
}

+ (NSString *)primaryKey {
    return @"name";
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

- (UIImage *)image
{
    UIImage *image = nil;
    if (self.imageData)
    {
        image = [UIImage imageWithData:self.imageData];
    }
    return image;
}

@end
