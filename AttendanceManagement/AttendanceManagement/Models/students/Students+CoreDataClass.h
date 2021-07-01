//
//  Students+CoreDataClass.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 26/06/21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Students : NSManagedObject
+(BOOL)addStudentInfoFromDictionary: (NSDictionary *)studentInfo;
+ (NSArray *)getAllStudentsFromClass: (NSString *)class ;
+(void)fetchAllDatafromStudents;
+(void)deleteStudentData:(NSInteger )rollNumber;
@end

NS_ASSUME_NONNULL_END

#import "Students+CoreDataProperties.h"
