//
//  Attendance+CoreDataClass.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 28/06/21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Attendance : NSManagedObject
+(void) addAttendenceRecord:(NSArray *)studentsOfMentoinedClass attendanceData:(NSMutableArray *)attendanceData
                       date:(NSDate *)date topic:(NSString *)topic;
+(NSDictionary *)fetchGivenStudentRecord:(NSString *)classId studentName:(NSString *)studentName ;
+(NSArray *) getAttendanceWithDate: dateOfAttendance topic:topicOfAttendance class: givenClass;
+(void) modifyAttendance: (NSArray *) newAttendance oldAttendance: (NSArray *)mentoinedAttendance;
@end

NS_ASSUME_NONNULL_END

#import "Attendance+CoreDataProperties.h"
