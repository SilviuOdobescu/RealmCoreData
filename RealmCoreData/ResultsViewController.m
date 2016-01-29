//
//  ResultsViewController.m
//  RealmCoreData
//
//  Created by Silviu Odobescu on 27/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import "ResultsViewController.h"
#import "CoreDataManager.h"
#import "Person.h"

@implementation TableCell

@end

@interface ResultsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataSource = [[CoreDataManager sharedManager] getArrayOfPersons];
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


@end
