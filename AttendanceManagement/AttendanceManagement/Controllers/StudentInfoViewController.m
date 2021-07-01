//
//  StudentInfoViewController.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 29/06/21.
//

#import "StudentInfoViewController.h"
#import "../Models/Attendance+CoreDataClass.h"
@interface StudentInfoViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *classLabel;
@property (strong, nonatomic) IBOutlet UILabel *rollNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *attendancePecentLabel;
@property (strong, nonatomic) IBOutlet UITableView *presentTableView;
@property (strong, nonatomic) IBOutlet UITableView *absentTableView;

@end

@implementation StudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *givenStudent =[Attendance fetchGivenStudentRecord:_selectedStudent[@"classId"]
                            studentName:_selectedStudent[@"name"]];
    _nameLabel.text =givenStudent[@"name"];
    _classLabel.text =  givenStudent[@"classId"];
    _rollNumberLabel.text =  givenStudent[@"roll"];
    float percent = (float)([givenStudent[@"presentDates"] count] *100)/ ([givenStudent[@"presentDates"] count]
                                                                    + [givenStudent[@"absentDates"] count]);
    _attendancePecentLabel.text = [[NSString alloc] initWithFormat:@"%f", percent];
   // @"topicMissed"
    //@"topicAttended"
    
    // Do any additional setup after loading the view.
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popCurrentViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
}

- (void) popCurrentViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
