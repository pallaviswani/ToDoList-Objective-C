//
//  TaskAddViewController.m
//  Pallavi_ToDoList_machine_Task
//
//  Created by Student P_08 on 05/03/17.
//  Copyright © 2017 Pallavi Wani. All rights reserved.
//

#import "TaskAddViewController.h"
#import "AppDelegate.h"

@interface TaskAddViewController ()

@end

@implementation TaskAddViewController
{
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    employeeId=1;
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=appDelegate.persistentContainer.viewContext;
    if(!_isAddSelect)
        [self setUpDesign];

    // Do any additional setup after loading the view.
}
-(void)setUpDesign
{
    self.txtName.text=self.TaskName;
    self.txtDetail.text=self.TaskDetail;
    self.txtDate.text=self.TaskDate;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)segmentValueChange:(id)sender {
    UISegmentedControl *segcontrol=(UISegmentedControl *)sender;
    if(segcontrol.selectedSegmentIndex==0)
        employeeId=1;
    
    else if (segcontrol.selectedSegmentIndex==1)
        employeeId=2;
    else
        employeeId=3;
}

- (IBAction)datePickerValueChange:(id)sender {
    UIDatePicker *datePicker=(UIDatePicker *)sender;
    NSLog(@"%@",datePicker.date);
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    self.txtDate.text=[dateFormatter stringFromDate:datePicker.date];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==_txtDate)
    {
        _datePicker.hidden=NO;
    }
}


- (IBAction)btnSave:(id)sender {
    NSEntityDescription *employeeEntity=[NSEntityDescription entityForName:@"EmployeeTask" inManagedObjectContext:context];
    NSManagedObject *objEmployee=[[NSManagedObject alloc]initWithEntity:employeeEntity insertIntoManagedObjectContext:context];
    int TaskID=arc4random();
    [objEmployee setValue:[NSNumber numberWithInt:TaskID] forKey:@"identifire"];
    [objEmployee setValue:[NSNumber numberWithInteger:employeeId] forKey:@"empid"];
    [objEmployee setValue:_txtName.text forKey:@"taskname"];
    [objEmployee setValue:_txtDetail.text forKey:@"taskdetail"];
    [objEmployee setValue:_txtDate.text forKey:@"taskdate"];
    NSError *error;
    [context save:&error];
    if(error)
        NSLog(@"%@",error);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"data successfuly saved" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}

- (IBAction)btnCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
