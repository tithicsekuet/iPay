//
//  ViewController.h
//  iPayDemoProject
//
//  Created by Dream 71 on 1/12/17.
//  Copyright © 2017 Dream71. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CountryInfoTableViewCell.h"
@interface ViewController : UIViewController
#pragma variables

@property (strong, nonatomic) IBOutlet UITableView *countryInfoTableView;
@property (strong, nonatomic) IBOutlet UIButton *capitalCityButton;
@property (strong, nonatomic) IBOutlet UIButton *callingCodeButton;

#pragma actions

- (IBAction)capitalCityClicked:(UIButton *)sender;
- (IBAction)callingCodeClicked:(UIButton *)sender;


@end

