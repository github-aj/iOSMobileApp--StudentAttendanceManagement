//
//  AteendanceClassViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 28/06/21.
//

#import "AtendanceClassViewController.h"
#import "AttendanceViewController.h"

@interface AtendanceClassViewController (){
    NSArray *class;
}
@property (strong, nonatomic) NSString *classId;


@property (weak, nonatomic) IBOutlet UITextField *topicTextfield;
- (IBAction)doneActionButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *classPickerView;
@end

@implementation AtendanceClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    class = @[@"Kindergarden", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII",
   @"IX", @"X", @"XI", @"XII"];
    
    _classPickerView.dataSource =self;
    _classPickerView.delegate = self;
    
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
   
   _classLabel.text = class[row];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
        AttendanceViewController *controller = (AttendanceViewController *)segue.destinationViewController;
        controller.classId = _classLabel.text;
        controller.dateOfAttendance = [_datePickerView date];
        /*
                                                             
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"YYYY/MM/dd"];
        NSString *chaluDate = [dateformatter stringFromDate:_datePickerView.date];
        [dateformatter dateFormat] */
        
        controller.topicOfAttendance = _topicTextfield.text;
        
         }
}


- (IBAction)doneActionButton:(UIButton *)sender {
    BOOL isTopicEmpty = [_topicTextfield.text isEqualToString:@""];
    if ([_topicTextfield.text length] ==0)
        isTopicEmpty = YES;
    
}
@end
