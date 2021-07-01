//
//  main.m
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 24/06/21.
//

#import <UIKit/UIKit.h>
#import "Delegates/AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
