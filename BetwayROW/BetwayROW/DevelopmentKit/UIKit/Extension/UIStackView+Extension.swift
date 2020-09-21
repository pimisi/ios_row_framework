//
//  UIStackView+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/18.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

extension UIStackView {
    var arrangedSubviewsSize: Int { return arrangedSubviews.count }
    
    func insertArrangedSubView(_ view: UIView, after viewSibling: UIView) {
        guard viewSibling.isInStack(self) else { return }
        
        if let index = arrangedSubviews.firstIndex(of: viewSibling) {
            insertArrangedSubview(view, at: index + 1)
        }
        
    }
    
    func removeAllArrangedSubviews() {
        for view in arrangedSubviews {
            view.removeFromStackIfStacked()
        }
    }
}
