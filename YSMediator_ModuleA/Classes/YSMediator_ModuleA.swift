//
//  YSMediator_ModuleA.swift
//  ModuleA
//
//  Created by 赵一超 on 2018/12/21.
//

import UIKit
import YSMediator

fileprivate let nameSpace = "ModuleA"

extension YSMediator {
    
    public func ModuleA_FirstViewController(callBack: YSMeiatorCallBack?) -> UIViewController? {
        let params = [
            "callback": callBack
        ] as [String: AnyObject]

        let result = self.perform(nameSpace: nameSpace, target: "ModuleA", action: "FirstViewController", params: params)
        return result as? UIViewController
    }
}
