//
//  Students+CoreDataProperties.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 26/06/21.
//
//

#import "Students+CoreDataProperties.h"

@implementation Students (CoreDataProperties)

+ (NSFetchRequest<Students *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Students"];
}

@dynamic classId;
@dynamic name;
@dynamic rollNumber;

@end
