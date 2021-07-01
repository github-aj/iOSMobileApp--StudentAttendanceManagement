//
//  DeleteStudentViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 29/06/21.
//

#import "DeleteStudentViewController.h"
#import "../Models/students/Students+CoreDataClass.h"

@interface DeleteStudentViewController (){
    NSArray *class;
    NSArray *studentOfGivenClass;
}
@property (strong, nonatomic) IBOutlet UITextField *classTextfield;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DeleteStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    class = @[@"Kindergarden", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII",
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

- (void)deleteButtonAction:(id)sender {
    NSDictionary *studentInfo =[studentOfGivenClass objectAtIndex:[sender tag]];
    NSInteger i =[studentInfo[@"roll"] integerValue];
    [Students deleteStudentData:i];
    studentOfGivenClass = [Students getAllStudentsFromClass: _classTextfield.text];
    [_tableView reloadData];
    NSLog(@"%@",@"Delete");
}
#pragma mark - Table View Data source
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return studentOfGivenClass.count;//number rows you want in table
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *cellIdentifier = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    UILabel *lbl = [cell viewWithTag:1];
    lbl.text =[studentOfGivenClass objectAtIndex:indexPath.row][@"name"] ;
    UIButton *btn = [cell viewWithTag:2];
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
    _classTextfield.text =class[row];
    studentOfGivenClass = [Students getAllStudentsFromClass: _classTextfield.text];
    [_classTextfield resignFirstResponder];
    [_tableView reloadData];
    
}

@end
