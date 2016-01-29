//
//  MigrationManager.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "MigrationManager.h"

@interface MigrationManager()

@property (nonatomic, strong) id<DataLayerManagerProtocol> initialStore;
@property (nonatomic, strong) id<DataLayerManagerProtocol> finalStore;
@property (nonatomic, strong) NSDictionary *mappingInfo;

@end

@implementation MigrationManager

- (instancetype)initWithInitialStore:(id<DataLayerManagerProtocol>)initialStore newStore:(id<DataLayerManagerProtocol>)newStore mappingInfo:(NSDictionary *)mappingInfo
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    
    self.initialStore = initialStore;
    self.finalStore = newStore;
    self.mappingInfo = mappingInfo;
    
    return self;
}

- (void)initiateMigrationProcess
{
    NSLog(@"should initiate transition process");
}

@end
