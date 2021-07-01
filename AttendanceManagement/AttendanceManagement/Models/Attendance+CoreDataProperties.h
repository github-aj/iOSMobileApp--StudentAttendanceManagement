//
//  Attendance+CoreDataProperties.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 28/06/21.
//
//

#import "Attendance+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Attendance (CoreDataProperties)

+ (NSFetchRequest<Attendance *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *classId;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) BOOL present;
@property (nonatomic) int64_t roll;
@property (nullable, nonatomic, copy) NSString *topic;
@property (nullable, nonatomic, retain) Attendance *students;

@end

NS_ASSUME_NONNULL_END
