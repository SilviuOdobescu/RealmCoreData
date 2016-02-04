//
//  ResultsViewController.h
//  RealmCoreData
//
//  Created by Silviu Odobescu on 27/01/16.
//  Copyright © 2016 Silviu Odobescu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *personImageView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *supervisorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personJobLabel;

@end

@interface ResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@end
