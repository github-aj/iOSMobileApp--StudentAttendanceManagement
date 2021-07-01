//
//  EditAttendanceViewController.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 30/06/21.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditAttendanceViewController : ViewController<UITableViewDelegate, UITableViewDataSource>

@property(strong,nonatomic) NSString *topicOfAttendance;
@property(strong, nonatomic) NSDate *dateOfAttendance;
@property(strong, nonatomic) NSString *givenClass;

@end

NS_ASSUME_NONNULL_END
