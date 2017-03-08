//
//  ViewController.m
//  Pallavi_ToDoList_machine_Task
//
//  Created by Student P_08 on 05/03/17.
//  Copyright © 2017 Pallavi Wani. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TableViewCell.h"
#import "TaskAddViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    empId=1;
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=appDelegate.persistentContainer.viewContext;

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getData];
}
-(void)getData
{
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:@"EmployeeTask"];
    NSPredicate *prediCate=[NSPredicate predicateWithFormat:@"empid == %ld",empId];
    [fetch setPredicate:prediCate];
    NSError *error;
    taskArray=[context executeFetchRequest:fetch error:&error];
    if(error)
        NSLog(@"%@",error.localizedDescription);
    if(taskArray.count)
        [_tableTaskList reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return taskArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.lblName.text=[[taskArray objectAtIndex:indexPath.row] valueForKey:@"taskname"];
    cell.lblDetail.text=[[taskArray objectAtIndex:indexPath.row]valueForKey:@"taskdetail"];
    cell.lblDate.text=[[taskArray objectAtIndex:indexPath.row]valueForKey:@"taskdate"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _isAddClicked=NO;
    selectedIndex=indexPath;
    [self performSegueWithIdentifier:@"addSegue" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddSegue"])
    {
        
        TaskAddViewController *addTaskVC=[segue destinationViewController];
        if(_isAddClicked)
        {
            addTaskVC.isAddSelect=YES;
        }
        else
        {
            addTaskVC.isAddSelect=NO;
            addTaskVC.TaskName=[[taskArray objectAtIndex:selectedIndex.row] valueForKey:@"taskname"];
            addTaskVC.TaskDetail=[[taskArray objectAtIndex:selectedIndex.row]valueForKey:@"taskdetail"];
            addTaskVC.TaskDate=[[taskArray objectAtIndex:selectedIndex.row]valueForKey:@"taskdate"];
        }
    }

}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld",(long)indexPath.row);
        
        NSManagedObject *obj =[taskArray objectAtIndex:indexPath.row];
        [context deleteObject:obj];
        NSError *error;
        [context save:nil];
        if (error != nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        
        //  [context deleteObject:obj];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        array = [taskArray mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        taskArray = [array copy];
        [_tableTaskList reloadData];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SegValueChange:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    if(segmentControl.selectedSegmentIndex==0)
        empId=1;
    
    else if (segmentControl.selectedSegmentIndex==1)
        empId=2;
    else
        empId=3;
    
    [self getData];

}

- (IBAction)addTask:(id)sender {
    _isAddClicked=YES;
    [self performSegueWithIdentifier:@"addSegue" sender:nil];
}
@end
