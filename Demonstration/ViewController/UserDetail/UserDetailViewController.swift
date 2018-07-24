//
//  UserDetailViewController.swift
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var userDetail:ResponseGetUserDetail?
    var sLogin:String!
    
    @IBOutlet weak var mainTableview: UITableView!
    
    @IBOutlet var cellAvatar: UITableViewCell!
    @IBOutlet weak var imgAvatarImage: UIImageView!
    
    @IBOutlet var cellLoginName: UITableViewCell!
    @IBOutlet weak var lblLoginName: UILabel!
    
    @IBOutlet var cellLocation: UITableViewCell!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet var cellFollowers: UITableViewCell!
    @IBOutlet weak var lblFollowers: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUserDetail()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView() -> Void {
        self.title = "User Detail";
        self.mainTableview.allowsSelection = false
        
        let leftBar:UIBarButtonItem = UIBarButtonItem.init(title: "Back", style: .done, target: self, action: #selector(UserDetailViewController.didPressedBack(_:)));
        
        self.navigationItem.leftBarButtonItem = leftBar;
    }
    
    func didPressedBack(_ sender:Any) -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getUserDetail() -> Void {
        let request:RequestGetUserDetail = RequestGetUserDetail()
        request.setUserId(sId: self.sLogin)
        request.startRequestWithBlock(successBlock: {[weak self] (responseObj) in
            self?.userDetail = responseObj as? ResponseGetUserDetail
            self?.setupUserInfo()
        }) { (error) in
            
        }
    }
    
    func setupUserInfo() -> Void {
        
        self.imgAvatarImage.sd_setImage(with: URL(string: self.userDetail?.avatar_url ?? ""), placeholderImage: UIImage(named: "default_pic.png"))
        self.lblLocation.text = self.userDetail?.location;
        self.lblLoginName.text = self.userDetail?.name;
        self.lblFollowers.text = self.userDetail?.followers.stringValue
        self.mainTableview.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.cellAvatar
        case 1:
            return self.cellLoginName
        case 2:
            return self.cellLocation
        case 3:
            return self.cellFollowers
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100.0;
        case 1:
            return 44.0;
        case 2:
            return 44.0;
        case 3:
            return 44.0;
        default:
            return 0.0;
        }
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
