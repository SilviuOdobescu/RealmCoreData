//
//  ViewController.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 27/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "MigrationManager.h"
#import "RealmDataManager.h"

@interface ViewController ()

@property (nonatomic, strong) MigrationManager* migrationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CoreDataManager *coreDataManager = [CoreDataManager sharedManager];
    [coreDataManager insertInfoInCoreData];
    
    RealmDataManager *realmManager = [RealmDataManager sharedManager];
    
    NSMutableDictionary *mappingDict = [NSMutableDictionary new];
    
    
    self.migrationManager = [[MigrationManager alloc] initWithInitialStore:coreDataManager newStore:realmManager mappingInfo:mappingDict];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (IBAction)convertToRealmButtonClicked:(id)sender
{
    [self.migrationManager initiateMigrationProcess];
}

- (IBAction)resetEverythingButtonClicked:(id)sender
{
    
}
@end
