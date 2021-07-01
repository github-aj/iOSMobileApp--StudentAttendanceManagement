//
//  takeInputsForEditAttendanceViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 30/06/21.
//

#import "takeInputsForEditAttendanceViewController.h"
#import "EditAttendanceViewController.h"

@interface takeInputsForEditAttendanceViewController (){
    NSArray *studentClasses;
}

@property (strong, nonatomic) IBOutlet UITextField *topicOfAttendance;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateOfAttendance;
@property (strong, nonatomic) IBOutlet UITextField *classTextField;
@end

@implementation takeInputsForEditAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    studentClasses = @[@"Kindergarden", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII",
   @"IX", @"X", @"XI", @"XII"];
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    _classTextField.inputView = pickerView;
    
    [_dateOfAttendance datePickerMode];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
}

- (void) popCurrentViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- PickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;  // Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
   return [studentClasses count];//Or, return as suitable for you...normally we use array for dynamic
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
            titleForRow:(NSInteger)row forComponent:(NSInteger)component {
   return studentClasses[row];
}

- (void)pickerView:(UIPickerView *)thePickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
   _classTextField.text = studentClasses[row];
   //studentOfGivenClass = [Students getAllStudentsFromClass: _classTextfield.text];
   [_classTextField resignFirstResponder];
   
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"editAttendance"]) {
        EditAttendanceViewController *controller = (EditAttendanceViewController *)segue.destinationViewController;
        controller.givenClass = _classTextField.text;
        controller.dateOfAttendance = [_dateOfAttendance date];
        controller.topicOfAttendance = _topicOfAttendance.text;
         }
}


@end
