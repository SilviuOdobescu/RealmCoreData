//
//  DataLayerManagerProtocol.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 28/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#ifndef DataLayerManagerProtocol_h
#define DataLayerManagerProtocol_h

@protocol DataLayerManagerProtocol <NSObject>

+ (id<DataLayerManagerProtocol>)sharedManager;
- (id)getArrayOfPersons;
- (id)addNewJob:(NSString *)jobName;
- (void)addNewPerson:(NSString *)personName avatar:(NSData *)avatarData job:(NSString *)jobName;
- (id)personForName:(NSString *)personName;
//- (id)findOrAddPerson:(NSString *)personName avatar:(NSData *)avatarData
- (id)findOrAddJob:(NSString *)jobName;
- (void)mapPersonRelations:(NSDictionary *)mappingInfo;

@end

#endif /* DataLayerManagerProtocol_h */
