//
//  MainCellAdapt.m
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

#import "MainCellAdapt.h"
#import "UITableView+Extend.h"

@implementation MainCellAdapt

-(instancetype)initWithDataSource:(ResponseGetUserList*)source
                       identifier:(NSString*)sIdentifier
                      cellDisplay:(cellDisplay)displayBlock
                   viewController:(id)viewController

{
    self = [super init];
    if (self) {
        self.sIdentifier = sIdentifier;
        self.userListObj = source;
        self.cellDisplayBlock = [displayBlock copy];
        
        self.vc = viewController;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userListObj.userList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserItemCell *cell = (UserItemCell*)[tableView customdq:self.sIdentifier];

    if (self.cellDisplayBlock) {
        self.cellDisplayBlock(cell, indexPath.row);
    }
    return cell;
}


@end
