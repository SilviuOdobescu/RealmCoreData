//
//  RealmPerson.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

@class RealmJob;

@interface RealmPerson : RLMObject

@property NSData *imageData;
@property NSString *name;
@property RealmJob *job;
@property RealmPerson *supervisor;
@property (readonly) NSArray *teamMembers; //this is the inverse of supervisor 
@property (readonly) UIImage *image;    //this property is ignored (aka not persisted)

@end

// This protocol enables typed collections. i.e.:
// RLMArray<RealmPerson>
RLM_ARRAY_TYPE(RealmPerson)
