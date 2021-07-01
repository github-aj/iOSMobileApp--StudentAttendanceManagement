//
//  StudentInfoTableViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 29/06/21.
//

#import "StudentInfoTableViewController.h"
#import "../Models/students/Students+CoreDataClass.h"
#import "StudentInfoViewController.h"
@interface StudentInfoTableViewController (){
    NSArray *classArray;
    NSArray *studentOfGivenClass;
    NSDictionary *selectedStudent;
}
@property (strong, nonatomic) IBOutlet UITextField *selectedStudentTextfield;
@property (strong, nonatomic) IBOutlet UITextField *classTextfield;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)doneActionButton:(UIButton *)sender;

@end

@implementation StudentInfoTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    classArray = @[@"Kindergarden", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII",
   @"IX", @"X", @"XI", @"XII"];
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    _classTextfield.inputView = pickerView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
}

- (void) popCurrentViewController{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)detailButtonAction:(UIButton *)sender {
    selectedStudent =[studentOfGivenClass objectAtIndex:[sender tag]];
    _selectedStudentTextfield.text = selectedStudent[@"name"];
}

#pragma mark - Table View Data source
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return studentOfGivenClass.count;//number rows you want in table
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *cellIdentifier = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    UILabel *lbl = [cell viewWithTag:1];
    lbl.text =[studentOfGivenClass objectAtIndex:indexPath.row][@"name"] ;
    UIButton *btn = [cell viewWithTag:2];
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(detailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
    return [classArray count];//Or, return as suitable for you...normally we use array for dynamic
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return classArray[row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    _classTextfield.text =classArray[row];
    studentOfGivenClass = [Students getAllStudentsFromClass:classArray[row]];
    [_classTextfield resignFirstResponder];
    [_tableView reloadData];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if([segue.identifier isEqualToString:@"showStudentAttendanceDetail"]){
     StudentInfoViewController *controller = (StudentInfoViewController *)segue.destinationViewController;
     controller.selectedStudent = selectedStudent;
      }
}

- (IBAction)doneActionButton:(UIButton *)sender {
}
@end
