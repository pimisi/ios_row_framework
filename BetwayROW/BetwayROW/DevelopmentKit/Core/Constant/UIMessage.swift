//
//  UIMessage.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension Constant {
    struct UIMessage {
        var title: String
        var detail: String
        var buttonTitle: String
        
        init(title: String, detail: String, buttonTitle: String? = nil) {
            self.title = title
            self.detail = detail
            self.buttonTitle = buttonTitle ?? ""
        }
    }
}
