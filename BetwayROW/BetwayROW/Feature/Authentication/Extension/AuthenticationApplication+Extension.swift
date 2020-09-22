//
//  Application+Extension.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/22.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

extension Application.DataKey {
    static let userLoggedIn = ApplicationConstant.Data.Key.userLoggedIn
}

extension Application {
    
    func set(userLoggedIn loggedIn: Bool) {
        data.set(value: loggedIn, for: DataKey.userLoggedIn)
    }
}
