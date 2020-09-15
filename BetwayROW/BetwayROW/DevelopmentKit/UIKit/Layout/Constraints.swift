//
//  Constraints.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/15.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

precedencegroup ConstraintPrecedence {
    associativity: left
    lowerThan: AdditionPrecedence
    higherThan: AssignmentPrecedence
}

infix operator ->> : ConstraintPrecedence

@discardableResult
public func ->> <T> (lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs)
    constraint.isActive = true
    return constraint
}

public extension UIView {

    func constrain(to thatView: UIView) {
        self.topAnchor.constraint(equalTo: thatView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: thatView.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: thatView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: thatView.trailingAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: thatView.centerXAnchor).isActive = true
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> Self {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    func pad(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        self.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func setBorderWidth(width: CGFloat, color: UIColor?, cornerRadius: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color?.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    func tap(_ target: Any?, _ action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }

}
