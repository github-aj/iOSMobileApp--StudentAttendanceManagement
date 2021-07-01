//
//  AddStudentViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 24/06/21.
//

#import "AddStudentViewController.h"
#import "../Models/students/Students+CoreDataClass.h"
#import "ViewController.h"
@interface AddStudentViewController () {
    NSArray *class;
}
@property (strong, nonatomic) IBOutlet UITextField *studentNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *studentRollTextField;
@property (strong, nonatomic) IBOutlet UITextField *studentClassTextField;
@property (strong, nonatomic) IBOutlet UIButton *addStudentDataTextField;
- (IBAction)addStudentDataToDBActionbtn:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextView *displayresultOfAddButtonTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *classpickerView;


@end

@implementation AddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     class = @[@"Kindergarden", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII",
    @"IX", @"X", @"XI", @"XII"];
    self.classpickerView.dataSource = self;
    self.classpickerView.delegate = self;
    // Do any additional setup after loading the view.
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
}

- (void) popCurrentViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

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
    self.studentClassTextField.text = class[row];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addStudentDataToDBActionbtn:(UIButton *)sender {
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:_studentRollTextField.text];
    
    valid = [alphaNums isSupersetOfSet:inStringSet];
    BOOL classValid = [class containsObject:self.studentClassTextField.text];
    if (classValid){
        if ( valid) {
            NSDictionary *studentInfo = @{
                @"name":self.studentNameTextField.text,
                @"roll": self.studentRollTextField.text,
                @"class": self.studentClassTextField.text,
                };
            BOOL dataAdded = [Students addStudentInfoFromDictionary:studentInfo];
            if(dataAdded){
                [self showToastMessage:@"Student Data  Successfully Added in DataBase"];
            }
        }
        else{
            NSString *message = @"Inalid Roll Number, It must be Integer";
            [self showToastMessage:message];
        }
    }
    else{
        NSString *message = @"Inalid Class, It must be from given pickerView";
        [self showToastMessage:message];
    }
    
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
@end
