//
//  AppDelegate.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 24/06/21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

