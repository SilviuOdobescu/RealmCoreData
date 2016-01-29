//
//  Person.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 27/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "Person.h"

@implementation Person

// Insert code here to add functionality to your managed object subclass

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
