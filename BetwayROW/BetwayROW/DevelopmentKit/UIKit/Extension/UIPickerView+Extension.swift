//
//  UIPickerView+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/23.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

extension UIPickerView {
    
    convenience init(for viewController: UIPickerViewDelegate & UIPickerViewDataSource) {
        self.init()
        delegate = viewController
        dataSource = viewController
    }
}
