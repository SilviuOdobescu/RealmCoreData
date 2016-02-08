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
#import "Job.h"
#import "RealmPerson.h"
#import "RealmJob.h"

@implementation TableCell

@end

@interface ResultsViewController ()

@property (nonatomic) BOOL shouldLoadCoreData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) RLMResults *realmDataSource;
@property (nonatomic, strong) RLMNotificationToken *notification;

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if(self.shouldLoadCoreData)
    {
        NSLog(@"==== loading Core Data");
        self.dataSource = [[CoreDataManager sharedManager] getArrayOfPersons];
    }
    else
    {
        NSLog(@"==== loading Realm");
        self.realmDataSource = [[RealmDataManager sharedManager] getArrayOfPersons];
    }
    
    // Set realm notification block
    __weak typeof(self) weakSelf = self;
    self.notification = [self.realmDataSource addNotificationBlock:^(RLMResults *data, NSError *error) {
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource and Delegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    Person *person = self.shouldLoadCoreData? self.dataSource[indexPath.row] : self.realmDataSource[indexPath.row];
    
    cell.personNameLabel.text = person.name;
    cell.personImageView.image = person.image;
    cell.supervisorNameLabel.text = person.supervisor.name;
    cell.personJobLabel.text = person.job.name;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.shouldLoadCoreData? self.dataSource.count : self.realmDataSource.count;
    return count;
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
