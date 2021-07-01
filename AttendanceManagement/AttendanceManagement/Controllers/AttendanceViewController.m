//
//  AttendanceViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 27/06/21.
//

#import "AttendanceViewController.h"
#import "../Models/students/Students+CoreDataClass.h"
#import "../Models/Attendance+CoreDataClass.h"

@interface AttendanceViewController (){
    NSArray *arr;
    NSArray *class;
    NSString *classString;
}
@property (strong, nonatomic) NSArray *studentsOfMentionedClass;
@property (strong, nonatomic) NSMutableArray *studentAttendence;

- (IBAction)doneButtonAction:(UIButton *)sender;
- (IBAction)resetButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView; // done
@property (weak, nonatomic) IBOutlet UIButton *doneButton; //done
@property (weak, nonatomic) IBOutlet UIButton *resetButton; //done
@property (strong, nonatomic) NSMutableArray *presentButtonResponse;

@end

@implementation AttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(AttendenceClassViewController)];
    
    //rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    //[self.view addGestureRecognizer: rightSwipe];
    
    _studentsOfMentionedClass = [Students getAllStudentsFromClass:self.classId];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _presentButtonResponse = [[NSMutableArray alloc] init];
    _studentAttendence = [[NSMutableArray alloc] init];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
}

- (void) popCurrentViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    
    for (int i=0; i<[_studentsOfMentionedClass count]; i++){
        [_studentAttendence addObject:@"0"];
    }
    
    if ([_studentAttendence count] == 0){
        _resetButton.enabled = NO;
        _doneButton.enabled = NO;
        _resetButton.alpha = 0.5;
        _doneButton.alpha = 0.5;
    }
    else{
        //_classLabel.text =[NSString stringWithFormat:@"Class: %@", _studentClass];
        _resetButton.enabled = YES;
        _doneButton.enabled = YES;
        _resetButton.alpha = 1;
        _doneButton.alpha = 1;
    }
    
}

-(void)setStudentClass:(NSString *)studentClass{
    //_studentClass = studentClass;
}

- (void)presentSwitchAction:(id)sender{
    
    
    UISwitch *correspondingAbsentButton = [_presentButtonResponse objectAtIndex:[sender tag]];
    BOOL isCorrespondingPresentButtonEnabled = !correspondingAbsentButton.on;
    
    if (isCorrespondingPresentButtonEnabled){// earlier it was on.
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to change the attendence status to present?" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *yesActionButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            UISwitch *btn = [self->_presentButtonResponse objectAtIndex:[sender tag]];
            
            btn.alpha = 1;
            btn.on = NO;
            [self->_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"0"];
        }];

        UIAlertAction *noActionButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
        [_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"1"];
        UISwitch *btn = [self->_presentButtonResponse objectAtIndex:[sender tag]];
        
        btn.alpha = 1;
        btn.on = YES;
        [alert addAction:yesActionButton];
        [alert addAction:noActionButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        
       NSLog(@"tapped on present button with tag: %li and done", [sender tag]);
        UISwitch *btn = [_presentButtonResponse objectAtIndex:[sender tag]];

        btn.enabled = YES;
        
        [_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"1"];
    }
}

#pragma mark-Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger i = [_studentsOfMentionedClass count];//number rows you want in table
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    UILabel *rollNoLabel = [cell viewWithTag:1];
    UILabel *nameLabel = [cell viewWithTag:2];
    
    NSInteger rollNo = [[_studentsOfMentionedClass objectAtIndex:indexPath.row][@"roll"] intValue];
    rollNoLabel.text = [NSString stringWithFormat:@"%ld", rollNo];
    nameLabel.text = [_studentsOfMentionedClass objectAtIndex:indexPath.row][@"name"];
    
    UISwitch *presentSwitch = [cell viewWithTag:4];
    
    presentSwitch.tag = indexPath.row;
    
    [_presentButtonResponse addObject:presentSwitch];
    
    [presentSwitch addTarget:self action:@selector(presentSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    
   // [presentButton addTarget:self action:@selector(presentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //by default is 1
}

#pragma mark-Action Buttons
- (IBAction)resetButtonAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to reset the attendence sheet?" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *yesActionButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        for (int i=0; i<[self->_studentsOfMentionedClass count]; i++){
            UISwitch *correspondingPresentSwitch = [self->_presentButtonResponse objectAtIndex:i];
            correspondingPresentSwitch.enabled = YES;
            //correspondingPresentSwitch.alpha = 0.5;
            
            [self->_studentAttendence replaceObjectAtIndex:i withObject:@"1"];
        }
        
    }];

    UIAlertAction *noActionButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];

    [alert addAction:yesActionButton];
    [alert addAction:noActionButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)doneButtonAction:(UIButton *)sender {
    if (_studentsOfMentionedClass.count>0) {
        [Attendance addAttendenceRecord:_studentsOfMentionedClass attendanceData:_studentAttendence date:_dateOfAttendance topic:_topicOfAttendance];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Attendence saved successfully!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
        
        [alert addAction:okActionButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

@end
