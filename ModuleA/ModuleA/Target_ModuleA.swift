//
//  Target_ModuleA.swift
//  ModuleA
//
//  Created by 赵一超 on 2018/12/20.
//

import UIKit

class Target_ModuleA: NSObject {
    
    @objc func Action_FirstViewController() -> UIViewController {
//        if let callback = params["callback"] as? (String) -> Void {
//            callback("success")
//        }
        
        let firstViewController = FirstViewController()
        return firstViewController
    }
}
