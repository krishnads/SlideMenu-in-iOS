//
//  DetailViewController.m
//  SlideMenuDemo
//
//  Created by Krishana on 11/27/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()


@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"Contact->%@",_contact.description);
    
    
    
//    if ([_contact isKeyAvailable:CNContactGivenNameKey])
//    {
//        if ([contact.nickname isEqualToString:@""])
//        {
//            cell.textLabel.text = [NSMutableString stringWithFormat:@"%@ %@",contact.givenName,contact.familyName];
//        }
//        else
//        {
//            cell.textLabel.text = [NSMutableString stringWithFormat:@"%@ %@ (%@)",contact.givenName,contact.familyName,contact.nickname];
//        }
//        for (CNLabeledValue *number in contact.phoneNumbers)
//        {
//            CNPhoneNumber *num = number.value;
//            cell.detailTextLabel.text = [num stringValue];
//        }
//    }
//    if ([contact isKeyAvailable:CNContactImageDataKey])
//    {
//        if (contact.imageData != nil)
//        {
//            cell.imageView.image  = [UIImage imageWithData:contact.imageData];
//        }
//        else
//        {
//            cell.imageView.image  = [UIImage imageNamed:@"avtar"];
//        }
//    }
//    else
//    {
//        cell.imageView.image = [UIImage imageNamed:@"avtar"];
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
