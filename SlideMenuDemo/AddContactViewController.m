//
//  AddContactViewController.m
//  SlideMenuDemo
//
//  Created by Krishana on 11/27/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "AddContactViewController.h"
@import Contacts;

@interface AddContactViewController ()

@end

@implementation AddContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)submitAction:(id)sender
{
    CNMutableContact *newContact = [[CNMutableContact alloc]init];
    //Name
    newContact.givenName = self.firstName.text;
    newContact.middleName = self.middleName.text;
    newContact.nickname = self.nickName.text;
    
    //Image
    NSData *data = UIImagePNGRepresentation(self.profileImg.image);
    newContact.imageData = data;
    
    //mobile
    CNPhoneNumber *phone = [[CNPhoneNumber alloc]initWithStringValue:self.mobile.text];
    CNLabeledValue *mobile = [[CNLabeledValue alloc]initWithLabel:CNLabelWork value:phone];
    newContact.phoneNumbers = @[mobile];
    
    //Email
    CNLabeledValue *email = [[CNLabeledValue alloc]initWithLabel:CNLabelWork value:self.email.text];
    newContact.emailAddresses = @[email];
    
    //Job Details
    newContact.jobTitle = self.jobTitle.text;
    newContact.organizationName = self.orgNmae.text;
    newContact.departmentName = self.deptName.text;

    //Social Accounts
    CNSocialProfile *fb = [[CNSocialProfile alloc]initWithUrlString:@"https://www.twitter.com/krisup" username:@"krisup01" userIdentifier:@"krishna" service:CNSocialProfileServiceFacebook];
    
    CNSocialProfile *twitter = [[CNSocialProfile alloc]initWithUrlString:@"https://www.facebook.com/krisup" username:@"9456655152" userIdentifier:@"krishna" service:CNSocialProfileServiceTwitter];
    CNLabeledValue *socialFb = [[CNLabeledValue alloc]initWithLabel:@"Facebook" value:fb];
    CNLabeledValue *socialTwitter = [[CNLabeledValue alloc]initWithLabel:@"Twitter" value:twitter];

    newContact.socialProfiles = @[socialFb, socialTwitter];
    
    //Skype Profile
    CNInstantMessageAddress *addrs = [[CNInstantMessageAddress alloc]initWithUsername:@"krishnads03" service:CNInstantMessageServiceSkype];
    CNLabeledValue *socialSkype = [[CNLabeledValue alloc]initWithLabel:@"Skype" value:addrs];
    newContact.instantMessageAddresses = @[socialSkype];
    
    //BirthDay
    NSDateComponents *birthDay = [[NSDateComponents alloc]init];
    birthDay.year = 1992;
    birthDay.month = 3;
    birthDay.day = 1;
    
    newContact.birthday = birthDay;
    
    //Save Contact
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc]init];
    [saveRequest addContact:newContact toContainerWithIdentifier:nil];
    
    CNContactStore *store = [[CNContactStore alloc]init];
    
    NSError *error;
    
    BOOL query = [store executeSaveRequest:saveRequest error:&error];
    
    if (query)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"wohoo!!!..." message:@"Contact Added Successfully" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
        {
            [self.navigationController popViewControllerAnimated:true];
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ooopss!!!..." message:@"Contact could not be saved" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
}


//Update Contacts

//func updateContact(contactIdentifier: String) {
//    do {
//        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactBirthdayKey, CNContactPhoneNumbersKey, CNContactViewController.descriptorForRequiredKeys()]
//        let contact = try store.unifiedContactWithIdentifier(contactIdentifier, keysToFetch:keysToFetch)    let contactToUpdate = contact.mutableCopy() as! CNMutableContact
//        contactToUpdate.phoneNumbers = [CNLabeledValue(label: CNLabelWork, value: CNPhoneNumber(stringValue: "+440987654321"))]    let saveRequest = CNSaveRequest()
//        saveRequest.updateContact(contactToUpdate)
//        try store.executeSaveRequest(saveRequest)
//    } catch let error{
//        print(error)}}


- (void)didReceiveMemoryWarning
{
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
