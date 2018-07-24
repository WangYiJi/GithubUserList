//
//  MainListViewController.m
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

#import "MainListViewController.h"
#import "Demonstration-Swift.h"
#import "UITableView+Extend.h"
#import "NSImage+WebCache.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "MainCellAdapt.h"
#import "Global.h"


@interface MainListViewController ()
@property (nonatomic,strong) ResponseGetUserList *userListObj;
@property (nonatomic,strong) MainCellAdapt *cellAdapt;

@end

@implementation MainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GitHub Users";
    
    [self getUserList:nil];
    // Do any additional setup after loading the view from its nib.
}

//Block for unit test
-(void)getUserList:(requestFinish)finishBlock
{
    __weak typeof(self) weakSelf = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    
//        RequestGetUserList *request = [[RequestGetUserList alloc] init];
//        request.sURL = DEF_RequestURL;
//
//        [request startRequestWithBlock:^(NSObject *json) {
//            ResponseGetUserList *r = (ResponseGetUserList*)json;
//            weakSelf.userListObj = r;
//
//            if (finishBlock) {
//                finishBlock(json);
//            }
//
//            [weakSelf refreshView];
//        } Fail:^(NSError *error) {
//            if (finishBlock) {
//                finishBlock(nil);
//            }
//        }];
        
    });
}

-(void)refreshView
{
    __weak typeof(self) weakSelf = self;
    //Event display in cell
    cellDisplay displayBlock = ^(UserItemCell *cell,NSInteger index){
        
        UserListItem *item = [weakSelf.cellAdapt.userListObj.userList objectAtIndex:index];
        cell.lblName.text = item.login;
        [cell.imgIcon sd_setImageWithURL:[NSURL URLWithString:item.avatar_url] placeholderImage:[UIImage imageNamed:@"default_pic.png"]];
        
        //NSLog(@"%@",item.login);
    };
    
    self.cellAdapt = [[MainCellAdapt alloc] initWithDataSource:self.userListObj identifier:@"UserItemCell" cellDisplay:displayBlock viewController:self];

    self.mainTableview.dataSource = self.cellAdapt;
    self.mainTableview.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
 
        [weakSelf.mainTableview reloadData];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    });
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.userListObj.userList.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UserListItem *item = [self.userListObj.userList objectAtIndex:indexPath.row];
//    UserItemCell *cell = (UserItemCell*)[tableView customdq:@"UserItemCell"];
//    cell.lblName.text = item.login;
//    [cell.imgIcon sd_setImageWithURL:[NSURL URLWithString:item.avatar_url] placeholderImage:[UIImage imageNamed:@""]];
//
//    NSLog(@"%@",item.login);
//    return cell;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserListViewController *r = [[UserListViewController alloc] initWithNibName:@"UserListViewController" bundle:nil];
    [self.navigationController pushViewController:r animated:YES];
    
    
    return;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserListItem *item = [self.userListObj.userList objectAtIndex:indexPath.row];
    
    RequestGetUserDetail *requestDetail = [[RequestGetUserDetail alloc] init];
    [requestDetail setUserIdWithSId:item.login];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
//        [requestDetail startRequestWithBlock:^(NSObject *json) {
//            if (json != nil) {
//                [weakSelf pushToUserDetail:(ResponseGetUserDetail*)json];
//            }
//        } Fail:^(NSError *error) {
//            
//        }];
    });

}

-(void)pushToUserDetail:(ResponseGetUserDetail*)userdetail
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        UserDetailViewController *detailVC = [[UserDetailViewController alloc] initWithNibName:@"UserDetailViewController" bundle:nil];
        detailVC.userDetail = userdetail;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
