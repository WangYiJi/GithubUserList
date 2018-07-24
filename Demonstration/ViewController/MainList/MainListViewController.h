//
//  MainListViewController.h
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^requestFinish)(NSObject *obj);

@interface MainListViewController : UIViewController <UITableViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView *mainTableview;

-(void)getUserList:(requestFinish)finishBlock;
@end
