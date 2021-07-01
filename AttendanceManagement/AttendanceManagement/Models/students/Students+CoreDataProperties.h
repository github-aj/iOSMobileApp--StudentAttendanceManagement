//
//  Students+CoreDataProperties.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 26/06/21.
//
//

#import "Students+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Students (CoreDataProperties)

+ (NSFetchRequest<Students *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *classId;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t rollNumber;

@end

NS_ASSUME_NONNULL_END
