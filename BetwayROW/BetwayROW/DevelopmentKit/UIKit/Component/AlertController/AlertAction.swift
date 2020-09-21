//
//  AlertAction.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/21.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

class AlertAction {
    
    enum Style: Equatable {
        case primary
        case secondary
        case system(UIAlertAction.Style)
    }
    
    let title: String?
    let style: AlertAction.Style
    let handler: ((AlertAction) -> Void)?
    
    lazy var button: UIButton = {
        let type: Button.CustomType
        switch style {
        case .primary: type = .primary
        case .secondary: type = .secondary
        default: type = .default(type: .system)
        }
        
        return Button(type: type)
    }()

    var isEnabled: Bool
    
    init(title: String?, style: AlertAction.Style = .primary, handler: ((AlertAction) -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
        isEnabled = true
    }
}
