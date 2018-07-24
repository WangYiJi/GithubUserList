//
//  MainCellAdapt.h
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Demonstration-Swift.h"
#import <UIKit/UIKit.h>

typedef void (^cellDisplay)(UserItemCell *cell,NSInteger index);


@interface MainCellAdapt : NSObject <UITableViewDataSource>

@property (nonatomic,copy) NSString *sIdentifier;
@property (nonatomic,strong) ResponseGetUserList *userListObj;
@property (nonatomic,copy) cellDisplay cellDisplayBlock;
@property (nonatomic,weak) id vc;

-(instancetype)initWithDataSource:(ResponseGetUserList*)source
                       identifier:(NSString*)sIdentifier
                      cellDisplay:(cellDisplay)displayBlock
                   viewController:(id)viewController;


@end
