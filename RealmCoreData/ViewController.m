//
//  ViewController.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 27/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "RealmDataManager.h"
#import "RealmDataManager+CoreDataMigration.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CoreDataManager *coreDataManager = [CoreDataManager sharedManager];
    [coreDataManager insertInfoInCoreData];
    
//    RealmDataManager *realmManager = [RealmDataManager sharedManager];
//    [realmManager insertInfoInRealm];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowCoreData"])
    {
        if([segue.destinationViewController respondsToSelector:@selector(loadCoreData)])
        {
            [segue.destinationViewController performSelector:@selector(loadCoreData)];
        }
    }
    else if ([segue.identifier isEqualToString:@"ShowRealm"])
    {
        if([segue.destinationViewController respondsToSelector:@selector(loadRealm)])
        {
            [segue.destinationViewController performSelector:@selector(loadRealm)];
        }
    }
}

- (IBAction)convertToRealmButtonClicked:(id)sender
{
    [[RealmDataManager sharedManager] initiateMigrationProcess];
}

- (IBAction)resetEverythingButtonClicked:(id)sender
{
    
}
@end
