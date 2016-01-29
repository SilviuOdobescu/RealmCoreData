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
- (id)addNewPerson:(NSString *)personName avatar:(NSData *)avatarData supervisor:(id)supervisor;

@end

#endif /* DataLayerManagerProtocol_h */
