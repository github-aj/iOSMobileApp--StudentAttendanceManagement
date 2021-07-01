//
//  DisplayClassInfoViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 25/06/21.
//
#import "../Models/students/Students+CoreDataClass.h"
#import "DisplayClassInfoViewController.h"
#import "AppDelegate.h"

@interface DisplayClassInfoViewController () {
    NSArray *arr;
    NSArray *class;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)getClassInfoActionButton:(UIButton *)sender;

@end

@implementation DisplayClassInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    class = @[@"Kindergarden", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII",
   @"IX", @"X", @"XI", @"XII"];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_tableView reloadData];
    
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
}

- (void) popCurrentViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) showToastMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [self presentViewController:alert animated:YES completion:nil];

    int duration = 1; // duration in seconds

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark - Table View Data source
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;//number rows you want in table
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *cellIdentifier = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text =[arr objectAtIndex:indexPath.row][@"name"] ;
    cell.detailTextLabel.text = [arr objectAtIndex:indexPath.row][@"roll"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //by default is 1
}

 #pragma mark- PickerViewDataSource
 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
     return 1;  // Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return [class count];//Or, return as suitable for you...normally we use array for dynamic
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return class[row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    self.classLabel.text =class[row];
    arr = [Students getAllStudentsFromClass: _classLabel.text];
}

- (IBAction)getClassInfoActionButton:(UIButton *)sender {
    BOOL isClassValid = [class containsObject:self.classLabel.text ];
    if (isClassValid){
        [self.tableView reloadData];
    }
    else{
        [self showToastMessage:@"Invalid Class Input"];
    }
}
@end
