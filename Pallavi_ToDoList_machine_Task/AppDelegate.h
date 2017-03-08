//
//  AppDelegate.h
//  Pallavi_ToDoList_machine_Task
//
//  Created by Student P_08 on 05/03/17.
//  Copyright © 2017 Pallavi Wani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

