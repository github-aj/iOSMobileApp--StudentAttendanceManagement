//
//  DisplayClassInfoViewController.h
//  AttendanceManagement
//
//  Created by Akshat Jaiswal on 25/06/21.
//

#import <UIKit/UIKit.h>
#import "../Delegates/DataTransferDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface DisplayClassInfoViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,
UITableViewDelegate, UITableViewDataSource>

@property(weak, atomic) NSString *classs;
@end

NS_ASSUME_NONNULL_END
