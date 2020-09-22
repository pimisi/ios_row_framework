//
//  Application.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

typealias ApplicationDataKey = String

class Application {
    
    private init() {}
    
    static var shared = Application()
    
    // swiftlint:disable identifier_name
    let ui = UIApplication.shared
    var data: [String: Any] = [:]
    
    class DataKey {
        static let productID: ApplicationDataKey = ApplicationConstant.Data.Key.productID
    }
    
    var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func incrementAppOpenCount() {
        let appOpenCount: Int = (defaults.value(forKey: Constant.Defaults.appOpenCount) as? Int ?? 0) + 1
        
        defaults.set(appOpenCount, forKey: Constant.Defaults.appOpenCount)
    }
    
    func set(productID: Int) {
        data[DataKey.productID] = productID
    }
    
    func get(valuefor key: ApplicationDataKey) -> String {
        return data.string(forKey: key)
    }
    
    func updateUI(_ execute: @escaping () -> Void) {
        DispatchQueue.main.async {
            execute()
        }
    }
}
