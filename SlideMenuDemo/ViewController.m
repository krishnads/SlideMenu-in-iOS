//
//  ViewController.m
//  SlideMenuDemo
//
//  Created by Krishana on 11/26/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@import Contacts;
@import ContactsUI;

@interface ViewController ()<CNContactPickerDelegate,UITableViewDataSource,UITableViewDelegate,CNContactViewControllerDelegate>
{
    NSMutableArray *tableData;
    IBOutlet UITableView *contactTable;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)showContactPickerAction:(id)sender
{
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc]init];
    contactPicker.delegate = self;
    [self presentViewController:contactPicker animated:true completion:nil];
}

-(IBAction)fetchContactsAction:(id)sender
{
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error)
    {
        // make sure the user granted us access
        if (!granted)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Permission is not granted" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
            });
            return;
        }
        // build array of contacts
       // NSMutableArray *contacts = [NSMutableArray array];
        tableData = [[NSMutableArray alloc]init];
        
        
        NSError *fetchError;
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:
                                         @[
                                              CNContactIdentifierKey,
                                              [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],
                                              CNContactGivenNameKey,
                                              CNContactFamilyNameKey,
                                              CNContactEmailAddressesKey,
                                              CNContactNicknameKey,
                                              CNContactPhoneNumbersKey,
                                              CNContactImageDataKey]
                                          ];
        
        BOOL success = [store enumerateContactsWithFetchRequest:request error:&fetchError usingBlock:^(CNContact *contact, BOOL *stop)
        {
            [tableData addObject:contact];
            [contactTable reloadData];

        }];
        if (!success)
        {
            NSLog(@"error = %@", fetchError);
        }
    }];
}

#pragma mark -CNContactPickerDelegate function

-(void) contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    NSLog(@"selected Contact->%@",contact.description);
    
    CNContactViewController *contactVC = [CNContactViewController viewControllerForContact:contact];
    contactVC.delegate = self;
    contactVC.allowsEditing = true;
    contactVC.allowsActions = true;
    [self.navigationController pushViewController:contactVC animated:true];
}

-(void) contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    
}

//-(void) contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts
//{
//    
//}

#pragma mark - Table View Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
//    cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"name"];
//    cell.detailTextLabel.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"mobile"];
//    cell.imageView.image = [UIImage imageNamed:@"avtar"];//[[tableData objectAtIndex:indexPath.row] objectForKey:@"img"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CNContact *contact = [tableData objectAtIndex:indexPath.row];
    
    if ([contact isKeyAvailable:CNContactGivenNameKey])//Optional
    {
        if ([contact.nickname isEqualToString:@""])
        {
            cell.textLabel.text = [NSMutableString stringWithFormat:@"%@ %@",contact.givenName,contact.familyName];
        }
        else
        {
            cell.textLabel.text = [NSMutableString stringWithFormat:@"%@ %@ (%@)",contact.givenName,contact.familyName,contact.nickname];
        }
        for (CNLabeledValue *number in contact.phoneNumbers)
        {
            CNPhoneNumber *num = number.value;
             cell.detailTextLabel.text = [num stringValue];
        }
    }
    if ([contact isKeyAvailable:CNContactImageDataKey])
    {
        if (contact.imageData != nil)
        {
            cell.imageView.image  = [UIImage imageWithData:contact.imageData];
        }
        else
        {
            cell.imageView.image  = [UIImage imageNamed:@"avtar"];
        }
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"avtar"];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark - Deleting Contact
    
//    CNSaveRequest *saveRequest = [[CNSaveRequest alloc]init];
//    [saveRequest deleteContact:(CNMutableContact *)[tableData objectAtIndex:indexPath.row]];
//    CNContactStore *store = [[CNContactStore alloc]init];
//    NSError *error;
//    BOOL query = [store executeSaveRequest:saveRequest error:&error];
//    
//    if (query)
//    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"wohoo!!!..." message:@"Contact Deleted Successfully" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
//                          {
//                             // [self.navigationController popViewControllerAnimated:true];
//                          }]];
//        
//        [self presentViewController:alert animated:true completion:nil];
//    }
//    else
//    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ooopss!!!..." message:@"Contact could not be deleted" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController:alert animated:true completion:nil];
//    }


    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *dvc = [story instantiateViewControllerWithIdentifier:@"DetailViewController"];
    dvc.contact = [tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dvc animated:true];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=0)
    {
        scrollView.contentOffset = CGPointZero;
    }
}

#pragma mark - SlideMenu Delegate Method
-(BOOL) slideNavigationControllerShouldDisplayLeftMenu
{
    return true;
}

#pragma mark - CNContactViewController Delegate Methods
-(void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact
{
    
}

-(BOOL)contactViewController:(CNContactViewController *)viewController shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property
{
    return true;
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
