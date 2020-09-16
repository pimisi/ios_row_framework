//
//  UIView+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
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
    
    func fit(to view: UIView, leading: CGFloat? = nil, top: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) {
        if (self.superview != view) {
            view.addSubview(self)
        }
        
        translatesAutoresizingMaskIntoConstraints(false)
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        }
        
        if let top = top {
            topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing > 0 ? -trailing : trailing).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom > 0 ? -bottom : bottom).isActive = true
        }
    }
    
    func fit(inside view: UIView, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        fit(to: view, leading: leading, top: top, trailing: trailing, bottom: bottom)
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
        
        if !availableConstraints.contains(.width), let widthConstraint = constraint[.width] {
            let widthAnchor = self.widthAnchor.constraint(equalToConstant: widthConstraint)
            widthAnchor.priority = UILayoutPriority(priority)
            widthAnchor.isActive = true
        }
        
        if !availableConstraints.contains(.height), let heightConstraint = constraint[.height]  {
            let heightAnchor = self.heightAnchor.constraint(equalToConstant: heightConstraint)
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
        
        if !availableConstraints.contains(.top), let superview = self.superview, let topConstraint = constraint[.top] {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: topConstraint).isActive = true
        }
        
        if !availableConstraints.contains(.leading), let superview = self.superview, let leadingConstraint = constraint[.leading] {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingConstraint).isActive = true
        }
    }
    
    @discardableResult
    func width(_ width: CGFloat, breakingConstraint attribute: NSLayoutConstraint.Attribute? = nil) -> Self {
        if let superview = self.superview, superview.subviews.contains(self), let attribute = attribute {
            let positionConstraints = superview.constraints

            for positionConstraint in positionConstraints {
                if let firstItem = positionConstraint.firstItem as? UIView, firstItem == self, positionConstraint.firstAttribute == attribute {
                    removeConstraint(positionConstraint)
                }
            }
        }
        
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat, breakingConstraint attribute: NSLayoutConstraint.Attribute? = nil) -> Self {
        
        if let superview = self.superview, superview.subviews.contains(self), let attribute = attribute {
            let positionConstraints = superview.constraints

            for positionConstraint in positionConstraints {
                if let firstItem = positionConstraint.firstItem as? UIView, firstItem == self, positionConstraint.firstAttribute == attribute {
                    removeConstraint(positionConstraint)
                }
            }
        }
        
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
    
    func square(ofSize dimension: CGFloat) {
        height(dimension)
        width(dimension)
    }
    
    func attach(to view: UIView, targetPosition attribute: NSLayoutConstraint.Attribute) {
        
        guard let superview = self.superview, superview.subviews.contains(view) else {
            debugLog("The views are not siblings. To use this functionality both views must have the same direct parent")
            return
        }
        
        switch attribute {
        case .top: bottomAnchor ->> view.topAnchor
        case .right: leftAnchor ->> view.rightAnchor
        case .bottom: topAnchor ->> view.bottomAnchor
        case .left: rightAnchor ->> view.leftAnchor
        default: break
        }
    }
}
