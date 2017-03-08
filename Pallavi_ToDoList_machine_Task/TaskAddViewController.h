//
//  TaskAddViewController.h
//  Pallavi_ToDoList_machine_Task
//
//  Created by Student P_08 on 05/03/17.
//  Copyright © 2017 Pallavi Wani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskAddViewController : UIViewController<UITextFieldDelegate>
{
    NSInteger employeeId;
}
@property BOOL isAddSelect;
@property (strong, nonatomic)NSString *TaskName;
@property (strong, nonatomic)NSString *TaskDetail;
@property (strong, nonatomic)NSString *TaskDate;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtDetail;
@property (strong, nonatomic) IBOutlet UITextField *txtDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)segmentValueChange:(id)sender;
- (IBAction)datePickerValueChange:(id)sender;
- (IBAction)btnSave:(id)sender;
- (IBAction)btnCancel:(id)sender;

@end
