//
//  UIView+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

extension UIView {
    
    enum Axis {
        case vertical, horizontal, both
    }
    
    private func translatesAutoresizingMaskIntoConstraints(_ translate: Bool) {
        if translatesAutoresizingMaskIntoConstraints == !translate {
            translatesAutoresizingMaskIntoConstraints = translate
        }
    }
    
    func fit(inside view: UIView, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        if (self.superview != view) {
            view.addSubview(self)
        }
        
        translatesAutoresizingMaskIntoConstraints(false)
        
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing > 0 ? -trailing : trailing).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom > 0 ? -bottom : bottom).isActive = true
    }
    
    func fit(inside view: UIView, horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        fit(inside: view, leading: horizontal, top: vertical, trailing: horizontal, bottom: vertical)
    }
    
    func center(in view: UIView, addToView: Bool = true, axis: Axis = .both, translateFrameToConstraints: Bool = true) {
        guard view.subviews.contains(self) || (!view.subviews.contains(self) && addToView) else { return }
        
        if (!view.subviews.contains(self) && addToView) {
            view.addSubview(self)
        }
        
        if translateFrameToConstraints && frame != .zero {
            self.translateFrameToConstraints()
        } else {
            translatesAutoresizingMaskIntoConstraints(false)
        }
        
        let positionConstraints = superview?.constraints
        
        if let positionConstraints = positionConstraints {
            for positionConstraint in positionConstraints {
                if let firstItem = positionConstraint.firstItem as? UIView, firstItem == self {
                    if positionConstraint.firstAttribute.isHorizontal && (axis == .horizontal || axis == .both) || positionConstraint.firstAttribute.isVertical && (axis == .vertical || axis == .both) {
                        view.removeConstraint(positionConstraint)
                    }
                }
            }
        }
        
        if axis == .vertical || axis == .both {
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        if axis == .horizontal || axis == .both {
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    func translateFrameToConstraints() {
        translateSizeToConstraints()
        translatePositionToConstraints()
    }
    
    func translateSizeToConstraints(priority: Float = 999) {
        guard frame != .zero else { return }
        
        translatesAutoresizingMaskIntoConstraints(false)
        
        let constraint: [NSLayoutConstraint.Attribute: CGFloat] = [
            .width: frame.width,
            .height: frame.height
        ]
        
        var availableConstraints: [NSLayoutConstraint.Attribute] = []
        
        for sizeConstraint in constraints {
            if let firstItem = sizeConstraint.firstItem as? UIView, let firstAttribute = constraint[sizeConstraint.firstAttribute], firstItem == self {
                sizeConstraint.constant = firstAttribute
                sizeConstraint.priority = UILayoutPriority(priority)
                availableConstraints.append(sizeConstraint.firstAttribute)
            }
        }
        
        if !availableConstraints.contains(.width) {
            let widthAnchor = self.widthAnchor.constraint(equalToConstant: constraint[.width]!)
            widthAnchor.priority = UILayoutPriority(priority)
            widthAnchor.isActive = true
        }
        
        if !availableConstraints.contains(.height) {
            let heightAnchor = self.heightAnchor.constraint(equalToConstant: constraint[.height]!)
            heightAnchor.priority = UILayoutPriority(priority)
            heightAnchor.isActive = true
        }
    }
    
    func translatePositionToConstraints() {
        guard superview != nil && frame != .zero else { return }
        
        translatesAutoresizingMaskIntoConstraints(false)
        
        let constraint: [NSLayoutConstraint.Attribute: CGFloat] = [
            .top: frame.minY,
            .leading: frame.minX
        ]
        
        var availableConstraints: [NSLayoutConstraint.Attribute] = []
        
        if let positionConstraints = superview?.constraints {
            for positionConstraint in positionConstraints {
                if let firstItem = positionConstraint.firstItem as? UIView, let firstAttribute = constraint[positionConstraint.firstAttribute], firstItem == self {
                    positionConstraint.constant = firstAttribute
                    availableConstraints.append(positionConstraint.firstAttribute)
                }
            }
        }
        
        if !availableConstraints.contains(.top) {
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: constraint[.top]!).isActive = true
        }
        
        if !availableConstraints.contains(.leading) {
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: constraint[.leading]!).isActive = true
        }
    }
}
