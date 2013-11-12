//
//  Categoria.h
//  Llama Expense
//
//  Created by Paul on 11/11/13.
//  Copyright (c) 2013 NextRocket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Gasto;

@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * color_red;
@property (nonatomic, retain) NSNumber * color_green;
@property (nonatomic, retain) NSNumber * color_blue;
@property (nonatomic, retain) NSSet *gastos;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addGastosObject:(Gasto *)value;
- (void)removeGastosObject:(Gasto *)value;
- (void)addGastos:(NSSet *)values;
- (void)removeGastos:(NSSet *)values;

@end
