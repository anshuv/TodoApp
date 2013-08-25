//
//  TableViewController.m
//  TodoApp
//
//  Created by Anshu Veda Jain on 8/25/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\anshuv. All rights reserved.
//

#import "TableViewController.h"
#import "TodoAppCell.h"

@interface TableViewController ()
@property(strong,nonatomic) NSMutableArray* todoTasksArray;
@end

@implementation TableViewController

- (NSMutableArray *)todoTasksArray {
    if(_todoTasksArray == nil)
        _todoTasksArray = [[NSMutableArray alloc] init];
    return _todoTasksArray;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTaskButton)];
    UINib * customNib=[UINib nibWithNibName:@"TodoAppCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"TodoAppCell"];
 //   [self.tableView reloadData];
}

- (void) addTaskButton
{
    [self.todoTasksArray addObject:@""];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"+ numberOfRowsInSection count is %d", [self.todoTasksArray count]);
    return [self.todoTasksArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"TodoAppCell";

    TodoAppCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.todoTaskTextField.tag=indexPath.row;
    [cell.todoTaskTextField addTarget:self action:@selector(updateModel:) forControlEvents:UIControlEventEditingDidEnd];
    NSLog(@"Invoked for row %d", indexPath.row);

    // Configure the cell...
    NSString * value=[self.todoTasksArray objectAtIndex:indexPath.row];
    
    cell.todoTaskTextField.text=value;
    if([value isEqualToString:@""]) {
        [cell.todoTaskTextField becomeFirstResponder];
    }
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tv
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [self.todoTasksArray count] ) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert;
    }
    
}

- (void) updateModel:(UITextField *) sender{
    [self.todoTasksArray replaceObjectAtIndex:sender.tag withObject:sender.text];
    [self.tableView reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if(indexPath.row < [self.todoTasksArray count]) {
            [self.todoTasksArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                  withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
