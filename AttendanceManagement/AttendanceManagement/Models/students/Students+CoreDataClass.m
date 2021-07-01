//
//  Students+CoreDataClass.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 26/06/21.
//
//

#import "Students+CoreDataClass.h"
#import "../../Delegates/AppDelegate.h"

@implementation Students
+(BOOL)addStudentInfoFromDictionary: (NSDictionary *)studentInfo{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    Students *studentEntity = nil;
    
    studentEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Students" inManagedObjectContext:context];
    
    studentEntity.rollNumber= [[studentInfo valueForKey:@"roll"] intValue];
    studentEntity.name= [studentInfo valueForKey:@"name"];
    studentEntity.classId = [studentInfo valueForKey:@"class"] ;
    
    NSFetchRequest *request = [Students fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat : @"rollNumber = %lld",studentEntity.rollNumber];
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if([array count] ==1){
        [appDelegate saveContext];
        NSLog(@"DataAdded");
        return YES;
    }
    //[self fetchAllDatafromStudents];
    return  NO;
}

+(void)fetchAllDatafromStudents {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetch = [Students fetchRequest];
    NSError *error;
    NSArray *array = [context executeFetchRequest:fetch error:&error];
    for(Students *student in array){
        NSLog(@"%@ %lld %@ ", student.name, student.rollNumber, student.classId);
    }
    NSLog(@"%lu",[array count]);
}

+ (NSArray *)getAllStudentsFromClass: (NSString *)class {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *request = [Students fetchRequest];
    NSError *error;
    //class =@"I";
    request.predicate = [NSPredicate predicateWithFormat : @"classId ==  %@", class];
    NSArray *arr = [context executeFetchRequest:request error:&error];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for( Students *studentEntity in arr) {
        NSDictionary *tempDict = [self createObjectFromEntity:studentEntity];
        [results addObject:tempDict];
    }
    [self fetchAllDatafromStudents];
    NSLog(@"%lu", [results count]);
    return results;
}

+ (NSDictionary *)createObjectFromEntity:(Students *)studentInfo {
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    tempDict[@"name"] = studentInfo.name;
    tempDict[@"classId"] = studentInfo.classId;
    tempDict[@"roll"] = [[NSString alloc]initWithFormat:@"%lld", studentInfo.rollNumber ];
    return tempDict;
}

+ (void)deleteStudentData:(NSInteger )roll {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *request = [Students fetchRequest];
    NSError *error;
    request.predicate = [NSPredicate predicateWithFormat : @"rollNumber == %lld", roll];
    NSArray *arr = [context executeFetchRequest:request error:&error];
    [context deleteObject:arr[0]];
    [appDelegate saveContext];
}
@end
