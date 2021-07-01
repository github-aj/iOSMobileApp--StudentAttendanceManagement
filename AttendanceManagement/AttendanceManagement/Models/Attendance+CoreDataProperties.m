//
//  Attendance+CoreDataProperties.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 28/06/21.
//
//

#import "Attendance+CoreDataProperties.h"

@implementation Attendance (CoreDataProperties)

+ (NSFetchRequest<Attendance *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Attendance"];
}

@dynamic classId;
@dynamic date;
@dynamic name;
@dynamic present;
@dynamic roll;
@dynamic topic;
@dynamic students;

@end
