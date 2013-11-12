//
//  MainViewController.m
//  Llama Expense
//
//  Created by Paul on 11/11/13.
//  Copyright (c) 2013 NextRocket. All rights reserved.
//

#import "MainViewController.h"
#import "GastoCell.h"

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataSourceExpenses;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataSourceExpenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	GastoCell *cell = (GastoCell *)[tableView dequeueReusableCellWithIdentifier:@"gastoCell"];
	cell.montoLabel.text = @"$ 12.00";
	cell.colorCategoria.backgroundColor = [UIColor colorWithRed:12/255.0f green:12/255.0f blue:12/255.0f alpha:1.0];
	
	return cell;
}

@end
