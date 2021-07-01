//
//  DataTransferDelegate.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 25/06/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DataTransferDelegate <NSObject>
- (void)getClass:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
