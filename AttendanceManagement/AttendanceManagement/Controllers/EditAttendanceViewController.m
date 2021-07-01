//
//  EditAttendanceViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 30/06/21.
//

#import "EditAttendanceViewController.h"
#import "../Models/Attendance+CoreDataClass.h"

@interface EditAttendanceViewController (){
    NSArray *mentoinedAttendance;
    BOOL flag;
}
- (IBAction)resetActionButton:(UIButton *)sender;
- (IBAction)doneActionButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *presentButtonResponse;
@property (strong, nonatomic) NSMutableArray *studentAttendence;

@end

@implementation EditAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = FALSE;
    mentoinedAttendance = [Attendance getAttendanceWithDate: _dateOfAttendance
                                                      topic:_topicOfAttendance
                                                      class: _givenClass];
    _presentButtonResponse = [[NSMutableArray alloc] init];
    _studentAttendence = [[NSMutableArray alloc] init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // Do any additional setup after loading the view.
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
}
-(void)viewWillAppear:(BOOL)animated {
    
}

- (void) popCurrentViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)presentSwitchAction:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to change the attendence status to present?" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *yesActionButton = [UIAlertAction actionWithTitle:@"Yes" style:
                                          UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UISwitch *btn = [self->_presentButtonResponse objectAtIndex:[sender tag]];
            if(btn.on)
                [self->_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"YES"];
            else
                [self->_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"NO"];
        }];

    UIAlertAction *noActionButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        UISwitch *btn = [self->_presentButtonResponse objectAtIndex:[sender tag]];
        btn.on = !btn.on;
    }];
    [alert addAction:yesActionButton];
    [alert addAction:noActionButton];
    [self presentViewController:alert animated:YES completion:nil];
    }

#pragma mark-Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{[mentoinedAttendance count];//number rows you want in table
    return [mentoinedAttendance count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    UILabel *rollNoLabel = [cell viewWithTag:1];
    UILabel *nameLabel = [cell viewWithTag:2];
    NSInteger rollNo = [[mentoinedAttendance objectAtIndex:indexPath.row][@"roll"] intValue];
    rollNoLabel.text = [NSString stringWithFormat:@"%ld", rollNo];
    nameLabel.text = [mentoinedAttendance objectAtIndex:indexPath.row][@"name"];
    
    UISwitch *presentSwitch;
    presentSwitch = [cell viewWithTag:3];
    presentSwitch.tag = indexPath.row;
    if ([[mentoinedAttendance objectAtIndex:indexPath.row][@"present"] isEqualToString: @"YES"])
        presentSwitch.on = YES;
    else
        presentSwitch.on = FALSE;
    [_studentAttendence addObject:[mentoinedAttendance objectAtIndex:indexPath.row][@"present"]];
    if ([_presentButtonResponse count] < [mentoinedAttendance count]){
        [_presentButtonResponse addObject:presentSwitch];
    }
       
    
    [presentSwitch addTarget:self action:@selector(presentSwitchAction:) forControlEvents:UIControlEventTouchUpInside];    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //by default is 1
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneActionButton:(UIButton *)sender {
    [Attendance modifyAttendance: _studentAttendence
                   oldAttendance:mentoinedAttendance];
}

- (IBAction)resetActionButton:(UIButton *)sender {
    mentoinedAttendance = [Attendance getAttendanceWithDate: _dateOfAttendance
                                                      topic:_topicOfAttendance
                                                      class: _givenClass];
    flag = TRUE;
    [_tableView reloadData];
}
@end
