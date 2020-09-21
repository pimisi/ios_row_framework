//
//  Constraint+Overload.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/16.
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
