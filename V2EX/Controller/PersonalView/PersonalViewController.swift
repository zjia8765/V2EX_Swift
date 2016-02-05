//
//  PersonalViewController.swift
//  V2EX
//
//  Created by zhangjia on 15/11/30.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class PersonalViewController: BaseViewController {

    override func awakeFromNib(){
        super.awakeFromNib()
        self.title = "个人"
        let item:UITabBarItem = UITabBarItem.init(title: "个人", image: UIImage(named: "tab_personal_normal"), selectedImage: UIImage(named: "tab_personal_highlight"))
        self.tabBarItem = item;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
