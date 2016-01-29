//
//  ResultsViewController.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 27/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "ResultsViewController.h"
#import "CoreDataManager.h"
#import "RealmDataManager.h"
#import "Person.h"

@implementation TableCell

@end

@interface ResultsViewController ()

@property (nonatomic) BOOL shouldLoadCoreData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    id<DataLayerManagerProtocol> dataSourceManager;
    
    if(self.shouldLoadCoreData)
    {
        NSLog(@"==== loading Core Data");
        dataSourceManager = [CoreDataManager sharedManager];
    }
    else
    {
        NSLog(@"==== loading Realm");
        dataSourceManager = [RealmDataManager sharedManager];
    }
    self.dataSource = [dataSourceManager getArrayOfPersons];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource and Delegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    Person *person = self.dataSource[indexPath.row];
    
    cell.personNameLabel.text = person.name;
    cell.personImageView.image = person.image;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mark - Private methods
- (void)loadCoreData
{
    self.shouldLoadCoreData = YES;
}

- (void)LoadRealm
{
    self.shouldLoadCoreData = NO;
}

@end
