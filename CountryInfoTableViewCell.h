//
//  CountryInfoTableViewCell.h
//  iPayDemoProject
//
//  Created by Dream 71 on 1/12/17.
//  Copyright © 2017 Dream71. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *counrtyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *capitalOrCallingCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *capitalOrCallingCodeTitleLabel;

@end
