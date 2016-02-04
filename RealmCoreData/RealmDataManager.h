//
//  RealmDataManager.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealmJob.h"
#import "RealmPerson.h"

@interface RealmDataManager : NSObject

- (void)insertInfoInRealm;
+ (RealmDataManager *)sharedManager;
- (id)getArrayOfPersons;

@end
