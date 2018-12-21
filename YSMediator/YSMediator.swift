//
//  YSMediator.swift
//  YSMediator
//
//  Created by 赵一超 on 2018/12/20.
//  Copyright © 2018年 melody. All rights reserved.
//

import UIKit

public let kYSMediatorParamsKeySwiftTargetModuleName = "kCTMediatorParamsKeySwiftTargetModuleName"

/// 组件化中间件基类
open class YSMediator {
    public static let shareInstance: YSMediator = YSMediator()
    fileprivate var cachedTarget: [String: AnyObject] = [String: NSObject]()
}

public typealias YSMeiatorCallBack = ((_ result: [String: AnyObject]?) -> Void)?

extension YSMediator {
    
    /// 外部调用方法 (url scheme)
    /// scheme://[nameSpace].[target]/[action]?[params]
    public func perform(url actionUrl: URL, completion: YSMeiatorCallBack) -> AnyObject? {
        let components = URLComponents.init(string: actionUrl.absoluteString)
        
        guard let host = components?.host else { return nil }
        
        let nameSpaceAndTraget = host.components(separatedBy: CharacterSet.init(charactersIn: "."))
        guard nameSpaceAndTraget.count == 2 else { return nil }
        
        let nameSpace = nameSpaceAndTraget[0]
        let target = nameSpaceAndTraget[1]
        guard let action = components?.path.replacingOccurrences(of: "_", with: ":").replacingOccurrences(of: "/", with: "") else { return nil }
        
        // 在这里添加 外部禁止的逻辑
        // 判断 action 或 target , 入不允许 则返回
        
        var params: [String: AnyObject]?
        if let queryItems = components?.queryItems {
            params = [String: AnyObject]()
            for queryItem in queryItems {
                if queryItem.value != nil {
                    params?[queryItem.name] = queryItem.value as AnyObject
                }
            }
        }
        
        let result = self.perform(nameSpace: nameSpace, target: target, action: action, params: params, shouldCacheTarge: false)
        if completion != nil {
            if let result = result {
                completion?(["result": result])
            }else {
                completion?(nil)
            }
        }
        return result
    }
    
    /// 内部调用方法
    /// - Returns: 返回成功或者失败, 对象, nil
    public func perform(nameSpace space: String, target targetName: String, action actionName: String, params: [String: AnyObject]?, shouldCacheTarge: Bool = false) -> AnyObject? {
        
        var targetObj: AnyObject?
        let className = "\(space).Target_\(targetName)"
        if shouldCacheTarge {
            targetObj = cachedTarget[className]
        }
        
        if targetObj == nil {
            let targetClass = NSClassFromString(className) as? NSObject.Type
            guard let targetType = targetClass else { return nil }
            targetObj = targetType.init()
            if shouldCacheTarge, targetObj != nil {
                cachedTarget[className] = targetObj!
            }
            let actionSelector = Selector("Action_\(actionName)")
            
            guard let targetObj = targetObj, targetObj.responds(to: actionSelector) else { return nil }
            
            let result = targetObj.perform(actionSelector, with: params)
            
            return result?.takeUnretainedValue()
        }
        
        return nil
    }
    
    func removeCache(with targetName:String) {
        let targetClassName = "Target_\(targetName)"
        self.cachedTarget.removeValue(forKey: targetClassName)
    }
}

