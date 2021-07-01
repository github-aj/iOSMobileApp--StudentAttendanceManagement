//
//  AttendanceViewController.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 27/06/21.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttendanceViewController : ViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSString *classId;
@property(strong, nonatomic) NSDate *dateOfAttendance;
@property(strong, nonatomic) NSString *topicOfAttendance;

@end

NS_ASSUME_NONNULL_END
