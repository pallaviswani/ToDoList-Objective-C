//
//  ViewController.h
//  Pallavi_ToDoList_machine_Task
//
//  Created by Student P_08 on 05/03/17.
//  Copyright © 2017 Pallavi Wani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger empId;
    NSArray *taskArray;
    NSIndexPath *selectedIndex;
}
@property BOOL isAddClicked;
@property (strong, nonatomic) IBOutlet UITableView *tableTaskList;
@property (strong, nonatomic) IBOutlet UISegmentedControl *empSegment;
- (IBAction)SegValueChange:(id)sender;
- (IBAction)addTask:(id)sender;


@end

