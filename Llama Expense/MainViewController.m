//
//  MainViewController.m
//  Llama Expense
//
//  Created by Paul on 11/11/13.
//  Copyright (c) 2013 NextRocket. All rights reserved.
//

#import "MainViewController.h"
#import "GastoCell.h"
#import "Gasto.h"
#import "Categoria.h"

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataSourceExpenses;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self inicializarDataSource];
	[self recalcularTotal];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)recalcularTotal
{
	double total = 0.0;
	
	for (Gasto *gasto in self.dataSourceExpenses) {
		total += gasto.monto.doubleValue;
	}
	
	self.totalLabel.text = [NSString stringWithFormat:@"US$ %.2f",total];
}
#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
	Categoria *categoriaSeleccionada = controller.dataSourceCategorias[controller.segmentedControl.selectedSegmentIndex];
	[self crearGastoParaMonto:controller.displayTextField.text categoria:categoriaSeleccionada];
	[self recalcularTotal];
	[self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
		FlipsideViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.delegate = self;
		destinationViewController.managedObjectContext = self.managedObjectContext;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataSourceExpenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	GastoCell *cell = (GastoCell *)[tableView dequeueReusableCellWithIdentifier:@"gastoCell"];
	
	Gasto *gasto = self.dataSourceExpenses[indexPath.row];
	Categoria *categoria = gasto.categoria;
	cell.montoLabel.text = [NSString stringWithFormat:@"US$ %.2f",gasto.monto.doubleValue];
	cell.nombreCategoria.text = categoria.nombre;
	cell.colorCategoria.backgroundColor = [UIColor colorWithRed:categoria.color_red.floatValue/255.0f green:categoria.color_green.floatValue/255.0f blue:categoria.color_blue.floatValue/255.0f alpha:1.0];
	
	return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Eliminamos
		Gasto *gastoAEliminar = self.dataSourceExpenses[indexPath.row];
		[tableView beginUpdates];
		[self.dataSourceExpenses removeObject:gastoAEliminar];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		[tableView endUpdates];
		[self.managedObjectContext deleteObject:gastoAEliminar];
		[self recalcularTotal];
		
	}
}
#pragma mark - Data Acess Methods
- (void)inicializarDataSource
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Gasto"];
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"fecha" ascending:YES]];
	
	NSError *error = nil;
	NSArray *gastos = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (error) {
		NSLog(@"%@",error);
	}
	self.dataSourceExpenses = gastos.mutableCopy;
}
- (void)crearGastoParaMonto:(NSString*)monto categoria:(Categoria*)categoria
{
	Gasto *nuevoGasto = [NSEntityDescription insertNewObjectForEntityForName:@"Gasto" inManagedObjectContext:self.managedObjectContext];
	nuevoGasto.fecha = [NSDate date];
	nuevoGasto.monto = [NSNumber numberWithDouble:monto.doubleValue];
	nuevoGasto.categoria = categoria;
	
	[self.dataSourceExpenses addObject:nuevoGasto];
}
@end
