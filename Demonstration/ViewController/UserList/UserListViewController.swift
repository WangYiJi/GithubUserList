//
//  UserListViewController.swift
//  Demonstration
//
//  Created by wyj on 2018/5/24.
//  Copyright © 2018年 Alex. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainTableview: UITableView!
    
    var dataSource:ResponseGetUserList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserList()
        // Do any additional setup after loading the view.
    }
    
    func getUserList() -> Void {
        let requestObj:RequestGetUserList = RequestGetUserList()
        requestObj.sURL = "https://api.github.com/users"
        requestObj.startRequestWithBlock(successBlock: { [weak self] (jsonObj) in
            self?.dataSource = jsonObj as? ResponseGetUserList
            self?.mainTableview.reloadData()
            print(jsonObj)
        }) { (errorObj) in
            print(errorObj)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.userList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userItem:UserListItem = self.dataSource!.userList.object(at: indexPath.row) as! UserListItem
        let cell:UserItemCell = tableView.customdq("UserItemCell") as! UserItemCell
        cell.lblName.text = userItem.login
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userItem:UserListItem = self.dataSource?.userList.object(at: indexPath.row) as! UserListItem
        
        let userDetailVC:UserDetailViewController = UserDetailViewController(nibName: "UserDetailViewController", bundle: nil)
        userDetailVC.sLogin = userItem.login
        self.navigationController?.pushViewController(userDetailVC, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
