//
//  Application.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

class Application {
    
    private init() {}
    
    static var shared = Application()
    
    let ui = UIApplication.shared
    var data: [String: Any] = [:]
    
    enum DataKey {
        case productID
        
        var stringValue: String {
            switch self {
            case .productID: return ApplicationConstant.Data.Key.productID
            }
        }
    }
    
    var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func incrementAppOpenCount() {
        let appOpenCount: Int = (defaults.value(forKey: Constant.Defaults.appOpenCount) as? Int ?? 0) + 1
        
        defaults.set(appOpenCount, forKey: Constant.Defaults.appOpenCount)
    }
    
    func set(productID: Int) {
        data[DataKey.productID.stringValue] = productID
    }
    
    func get(valuefor key: DataKey) -> String {
        return data.string(forKey: key.stringValue)
    }
    
    func updateUI(_ execute: @escaping () -> Void) {
        DispatchQueue.main.async {
            execute()
        }
    }
}
