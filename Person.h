//
//  Person.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 27/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class Job;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (UIImage *)image;

@end

NS_ASSUME_NONNULL_END

#import "Person+CoreDataProperties.h"
