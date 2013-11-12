//
//  FlipsideViewController.m
//  Llama Expense
//
//  Created by Paul on 11/11/13.
//  Copyright (c) 2013 NextRocket. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Categoria.h"
@interface FlipsideViewController ()
@end

@implementation FlipsideViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self inicializarDataSource];
	
	self.segmentedControl.tintColor = [UIColor grayColor];
	for (int i=0; i<self.dataSourceCategorias.count; i++) {
		Categoria *categoria = self.dataSourceCategorias[i];
		[self.segmentedControl setTitle:categoria.nombre forSegmentAtIndex:i];
	}
}
- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.displayTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)cancelar:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Data Acess Methods
- (void)inicializarDataSource
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Categoria"];
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]];
	
	NSError *error = nil;

	NSManagedObjectContext *context = self.managedObjectContext;
	NSArray *categorias = [context executeFetchRequest:request error:&error];
	if (error) {
		NSLog(@"%@",error);
	}
	self.dataSourceCategorias = categorias.mutableCopy;
}

@end
