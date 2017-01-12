//
//  ViewController.m
//  iPayDemoProject
//
//  Created by Dream 71 on 1/12/17.
//  Copyright © 2017 Dream71. All rights reserved.
//

#import "ViewController.h"
#define capitalCityApiURL @"https://restcountries.eu/rest/v1/all"
#define callCodeUrl @"https://restcountries.eu/rest/v1/callingcode/7"

@interface ViewController ()
{
    UIActivityIndicatorView * progressHud;
    NSMutableArray * countryArray;
    
    BOOL cityOrCallCode;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cityOrCallCode=0;
    progressHud=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [progressHud setCenter:self.view.center]; // I do this
    [self.view addSubview:progressHud];
    [self cityInfo];
    [self.capitalCityButton setBackgroundColor:[UIColor colorWithRed:0.3961 green:0.7059 blue:0.2627 alpha:1]];
     [self.callingCodeButton setBackgroundColor:[UIColor colorWithRed:0.4941 green:0.7647 blue:0.3490 alpha:1]];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)capitalCityClicked:(UIButton *)sender {
    [self.capitalCityButton setBackgroundColor:[UIColor colorWithRed:0.3961 green:0.7059 blue:0.2627 alpha:1]];
    [self.callingCodeButton setBackgroundColor:[UIColor colorWithRed:0.4941 green:0.7647 blue:0.3490 alpha:1]];
    cityOrCallCode=0;
    [self cityInfo];
}

- (IBAction)callingCodeClicked:(UIButton *)sender {
    [self.callingCodeButton setBackgroundColor:[UIColor colorWithRed:0.3961 green:0.7059 blue:0.2627 alpha:1]];
    [self.capitalCityButton setBackgroundColor:[UIColor colorWithRed:0.4941 green:0.7647 blue:0.3490 alpha:1]];
    cityOrCallCode=1;
    [self callCodeInfo];
}

- (void) cityInfo {
    countryArray=[[NSMutableArray alloc]init];
    [self.countryInfoTableView reloadData];
    NSString *RequestURL = [NSString stringWithFormat:@"%@",capitalCityApiURL] ;

    
    [progressHud startAnimating];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:RequestURL  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSMutableArray * json =(NSMutableArray *)responseObject;
        
       
        if (json) {
            
            countryArray=json;
            
            [self.countryInfoTableView reloadData];
            [progressHud stopAnimating];
            
                  }
        else{
            [progressHud stopAnimating];

            UIAlertController * alert=[UIAlertController
                                       alertControllerWithTitle:@"No data found"
                                       message:nil
                                       preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                    
                                       }];
            
            
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:nil];

            
        }
    }
     
     
          failure:^(NSURLSessionTask *operation, NSError *error) {
              [progressHud stopAnimating];
              UIAlertController * alert=[UIAlertController
                                         alertControllerWithTitle:@"Internet Failure"
                                         message:nil
                                         preferredStyle:UIAlertControllerStyleAlert];
              UIAlertAction *okAction = [UIAlertAction
                                         actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action)
                                         {
                                           
                                         }];
              
              
              [alert addAction:okAction];
              
              [self presentViewController:alert animated:YES completion:nil];
          }];
}

- (void) callCodeInfo {
    countryArray=[[NSMutableArray alloc]init];
    [self.countryInfoTableView reloadData];
    NSString *RequestURL = [NSString stringWithFormat:@"%@",callCodeUrl] ;
    
    
    [progressHud startAnimating];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:RequestURL  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSMutableArray * json =(NSMutableArray *)responseObject;
        
        if (json) {
            
            countryArray=json;
            [self.countryInfoTableView reloadData];
              [progressHud stopAnimating];
            
            
        }
        else{
            [progressHud stopAnimating];
            
            UIAlertController * alert=[UIAlertController
                                       alertControllerWithTitle:@"No data found"
                                       message:nil
                                       preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           
                                       }];
            
            
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
     
     
         failure:^(NSURLSessionTask *operation, NSError *error) {
            [progressHud stopAnimating];
             UIAlertController * alert=[UIAlertController
                                        alertControllerWithTitle:@"Internet Failure"
                                        message:nil
                                        preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *okAction = [UIAlertAction
                                        actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action)
                                        {
                                    
                                        }];
             
             
             [alert addAction:okAction];
                          
             [self presentViewController:alert animated:YES completion:nil];
         }];
}


#pragma table view delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!cityOrCallCode) {
        return 1;
    }
    else
        return [countryArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (!cityOrCallCode) {
         return [countryArray count];
    }
    else
        return [[[countryArray valueForKey:@"callingCodes"]objectAtIndex:sectionIndex]count ];
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountryInfoTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"CountryInfoTableViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CountryInfoTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    if (!cityOrCallCode) {
        cell.counrtyNameLabel.text=[[countryArray valueForKey:@"name"]objectAtIndex:indexPath.row];
        cell.capitalOrCallingCodeLabel.text=[[countryArray valueForKey:@"capital"]objectAtIndex:indexPath.row];
        cell.capitalOrCallingCodeTitleLabel.text=@"Capital City :";

    }
    
    else{
        cell.counrtyNameLabel.text=[[countryArray valueForKey:@"name"]objectAtIndex:indexPath.section];
        cell.capitalOrCallingCodeLabel.text=[[[countryArray valueForKey:@"callingCodes"]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.capitalOrCallingCodeTitleLabel.text=@"Calling Code :";

    
    }
    return cell;
}

#pragma hidingstatusbar

-(BOOL)prefersStatusBarHidden{
    
    return YES;
    
}



@end
