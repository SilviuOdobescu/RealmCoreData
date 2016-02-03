//
//  MigrationManager.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataLayerManagerProtocol.h"

@interface MigrationManager : NSObject

- (instancetype)initWithInitialStore:(id<DataLayerManagerProtocol>)initialStore newStore:(id<DataLayerManagerProtocol>)newStore;
- (void)initiateMigrationProcess;

@end
