//
//  Keyboard.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/30.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

class Keyboard {

    func adjust(for notification: Notification, scrollView: UIScrollView, view: UIView) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom+5, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}
