//
//  ViewController.swift
//  Example
//
//  Created by 赵一超 on 2018/12/20.
//  Copyright © 2018年 melody. All rights reserved.
//

import UIKit
import YSMediator
import YSMediator_ModuleA

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionTargetA() {
        if let vc = YSMediator.shareInstance.ModuleA_FirstViewController(callBack: nil) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}

