//
//  Categoria.h
//  Llama Expense
//
//  Created by Paul on 11/11/13.
//  Copyright (c) 2013 NextRocket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Categoria : NSManagedObject

@property (nonatomic, retain) UNKNOWN_TYPE nombre;
@property (nonatomic, retain) NSSet *gastos;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addGastosObject:(NSManagedObject *)value;
- (void)removeGastosObject:(NSManagedObject *)value;
- (void)addGastos:(NSSet *)values;
- (void)removeGastos:(NSSet *)values;

@end
