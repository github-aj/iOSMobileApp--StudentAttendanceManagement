//
//  Attendance+CoreDataClass.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 28/06/21.
//
//

#import "Attendance+CoreDataClass.h"
#import "AppDelegate.h"

@implementation Attendance

+ (void) addAttendenceRecord:(NSArray *)studentsOfMentoinedClass attendanceData:(NSMutableArray *)attendanceData
                        date:(NSDate *)date topic:(NSString *)topic {
    for(int i =0; i< studentsOfMentoinedClass.count; i++){
        AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        Attendance *attendanceRecordEntity = nil;
        
        attendanceRecordEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Attendance" inManagedObjectContext:context];
        attendanceRecordEntity.name = [studentsOfMentoinedClass objectAtIndex:i][@"name"];
        attendanceRecordEntity.roll = [[studentsOfMentoinedClass objectAtIndex:i][@"roll"] intValue];
        attendanceRecordEntity.classId =[studentsOfMentoinedClass objectAtIndex:i][@"classId"];
        attendanceRecordEntity.date = date;
        attendanceRecordEntity.topic = topic;
        if([attendanceData[i] isEqual:@"0"])
            attendanceRecordEntity.present = NO;
        else
            attendanceRecordEntity.present = YES;
        //NSError *error;
        [appDelegate saveContext];
        NSLog(@"DataAdded");
    }
    [self fetchAllDatafromAttendanceRecord];
}

+(void)fetchAllDatafromAttendanceRecord {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetch = [Attendance fetchRequest];
    NSError *error;
    NSArray *array = [context executeFetchRequest:fetch error:&error];
    for(Attendance *student in array){
        NSLog(@"%@ %lld %@ %@ %@ ", student.name, student.roll, student.classId, student.topic, student.date);
        NSLog(@"%@", student.present? @"YES": @"NO");
    }
    NSLog(@"%lu",[array count]);
}

+(NSDictionary *)fetchGivenStudentRecord:(NSString *)classId studentName:(NSString *) studentName {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *request= [Attendance fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat : @"classId == %@ AND name == %@",classId, studentName];
    NSError *error;
    NSArray *arr = [context executeFetchRequest:request error:&error];
    NSDictionary *student = [self createObjectFromEntity:arr];
    return student;
}

+ (NSArray *) getAttendanceWithDate: dateOfAttendance topic:topicOfAttendance class: givenClass;{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *request= [Attendance fetchRequest];
    [self fetchAllDatafromAttendanceRecord];
    
    request.predicate = [NSPredicate predicateWithFormat : @"classId == %@ AND date == %@ AND topic == %@",givenClass, dateOfAttendance, topicOfAttendance];
    NSError *error;
    NSArray *arr = [context executeFetchRequest:request error:&error];
    return [self createObjectArrayFromEntityArray:arr];
}

+(void) deleteAttendance:(NSArray *)attendanceArray {
    for(NSDictionary *temp in attendanceArray){
        AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        NSFetchRequest *request= [Attendance fetchRequest];
        request.predicate = [NSPredicate predicateWithFormat : @"classId == %@ AND name == %@ AND topic ==%@ AND date == %@ ",temp[@"classId"],temp[@"name"], temp[@"topic"],temp[@"date"] ];
        NSError *error;
        NSArray *arr = [context executeFetchRequest:request error:&error];
        [context deleteObject:[arr firstObject]];
        [appDelegate saveContext];
        //NSError *error;
        NSLog(@"DataDeleted");
    }
}
+(void) modifyAttendance: (NSArray *) newAttendance oldAttendance: (NSArray *)mentoinedAttendance {
    int i=0;
    for(NSDictionary *temp in mentoinedAttendance){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        NSFetchRequest *request= [Attendance fetchRequest];
        request.predicate = [NSPredicate predicateWithFormat : @"classId == %@ AND name == %@ AND topic ==%@ AND date == %@ ",temp[@"classId"],temp[@"name"], temp[@"topic"],temp[@"date"] ];
        NSError *error;
        NSArray *arr = [context executeFetchRequest:request error:&error];
        Attendance *modifydata = [ arr objectAtIndex:0];
        if([newAttendance[i] isEqualToString: @"YES"]) {
            if (modifydata!= nil) {
                modifydata.present = YES;
                [appDelegate saveContext];
            }
        }
        else {
            modifydata.present = NO;
        }
        i++;
        [appDelegate saveContext];
    }
}

+ (NSArray *)createObjectArrayFromEntityArray:(NSArray *) studentArray {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(Attendance *student in studentArray){
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        tempDict[@"name"] = student.name;
        tempDict[@"classId"] = student.classId;
        tempDict[@"roll"] = [[NSString alloc]initWithFormat:@"%lld", student.roll ];
        tempDict[@"topic"]= student.topic;
        tempDict[@"date"]= student.date;
        tempDict[@"present"]= student.present? @"YES": @"NO";
        [arr addObject:tempDict];
    }
    return arr;
}

+ (NSDictionary *)createObjectFromEntity:(NSArray *) studentArray {
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    Attendance *studentInfo = [studentArray firstObject];
    tempDict[@"name"] = studentInfo.name;
    tempDict[@"classId"] = studentInfo.classId;
    tempDict[@"roll"] = [[NSString alloc]initWithFormat:@"%lld", studentInfo.roll ];
    tempDict[@"topicMissed"]= [[NSMutableArray alloc] init];
    tempDict[@"topicAttended"]= [[NSMutableArray alloc] init];
    tempDict[@"absentDates"]= [[NSMutableArray alloc] init];
    tempDict[@"presentDates"]= [[NSMutableArray alloc] init];
    
    
    for(Attendance *student in studentArray){
        if(student.present == YES) {
            [tempDict[@"topicAttended"] addObject:student.topic];
            [tempDict[@"presentDates"] addObject:student.date];
        }
        else {
            [tempDict[@"absentDates"] addObject:student.date];
            [tempDict[@"topicMissed"] addObject:student.topic];
        }
            
    }
    return tempDict;
}

@end
