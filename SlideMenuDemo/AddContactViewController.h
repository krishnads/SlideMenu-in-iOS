//
//  AddContactViewController.h
//  SlideMenuDemo
//
//  Created by Krishana on 11/27/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddContactViewController : UIViewController



@property(weak, nonatomic) IBOutlet UITextField *firstName;
@property(weak, nonatomic) IBOutlet UITextField *nickName;
@property(weak, nonatomic) IBOutlet UITextField *middleName;
@property(weak, nonatomic) IBOutlet UITextField *mobile;
@property(weak, nonatomic) IBOutlet UITextField *email;
@property(weak, nonatomic) IBOutlet UITextField *jobTitle;
@property(weak, nonatomic) IBOutlet UITextField *orgNmae;
@property(weak, nonatomic) IBOutlet UITextField *deptName;
@property(weak, nonatomic) IBOutlet UIImageView *profileImg;


@end
