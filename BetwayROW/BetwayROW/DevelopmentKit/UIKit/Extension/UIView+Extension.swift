//
//  UIView+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(withRoundedCorners radius: CGFloat) {
        self.init()
        rounded(radius: radius)
    }
    
    func rounded(radius: CGFloat = 6) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func bordered(width: CGFloat = 0.0, cornerRadius: CGFloat = 0.0, color: UIColor?) {
        self.layer.borderWidth = width
        
        if let color = color {
            self.layer.borderColor = color.cgColor
        }
        
        self.layer.cornerRadius = cornerRadius
    }
    
    func pad(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        self.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func tap(_ target: Any?, _ action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
}

// MARK: - Constraints

extension UIView {
    enum Axis {
        case vertical, horizontal, both
    }
    
    private func translatesAutoresizingMaskIntoConstraints(_ translate: Bool) {
        if translatesAutoresizingMaskIntoConstraints == !translate {
            translatesAutoresizingMaskIntoConstraints = translate
        }
    }
    
    func fit(to view: UIView, leading: CGFloat? = nil, top: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil, priority: Float? = nil) {
        if (self.superview != view) {
            view.addSubview(self)
        }
        
        translatesAutoresizingMaskIntoConstraints(false)
        
        if let leading = leading {
            let leadingConstraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading)
            if let priority = priority {
                leadingConstraint.priority = UILayoutPriority(priority)
            }
            leadingConstraint.isActive = true
        }
        
        if let top = top {
            let topConstraint = topAnchor.constraint(equalTo: view.topAnchor, constant: top)
            if let priority = priority {
                topConstraint.priority = UILayoutPriority(priority)
            }
            topConstraint.isActive = true
        }
        
        if let trailing = trailing {
            let trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing > 0 ? -trailing : trailing)
            if let priority = priority {
                trailingConstraint.priority = UILayoutPriority(priority)
            }
            trailingConstraint.isActive = true
        }
        
        if let bottom = bottom {
            let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom > 0 ? -bottom : bottom)
            if let priority = priority {
                bottomConstraint.priority = UILayoutPriority(priority)
            }
            bottomConstraint.isActive = true
        }
    }
    
    func fit(inside view: UIView, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        fit(to: view, leading: leading, top: top, trailing: trailing, bottom: bottom)
    }
    
    func fit(inside view: UIView, horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        fit(inside: view, leading: horizontal, top: vertical, trailing: horizontal, bottom: vertical)
    }
    
    func fit(inside view: UIView, padding: CGFloat = 0) {
        fit(to: view, leading: padding, top: padding, trailing: padding, bottom: padding)
    }
    
    func adjustPadding(leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        for constraint in positionConstraints {
            switch constraint.firstAttribute {
            case .leading: constraint.constant = leading
            case .top: constraint.constant = top
            case .trailing: constraint.constant = trailing == 0 ? trailing : -trailing
            case .bottom: constraint.constant = bottom == 0 ? bottom : -bottom
            default: break
            }
        }
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
        
        for constraint in positionConstraints {
            if constraint.firstAttribute.isHorizontal && (axis == .horizontal || axis == .both) || constraint.firstAttribute.isVertical && (axis == .vertical || axis == .both) {
                view.removeConstraint(constraint)
            }
        }
        
        if axis == .vertical || axis == .both {
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        if axis == .horizontal || axis == .both {
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
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
    
    func add(to view: UIView, translateFrameToConstraints: Bool = false) {
        view.addSubview(self)
        
        if translateFrameToConstraints {
            self.translateFrameToConstraints()
        }
    }
}

// MARK: - Border

extension UIView {
    static let borderIdentifier = "border"
    
    enum Position: String {
        case top, right, bottom, left
    }
    
    typealias BorderPosition = Position
    
    enum BorderProperty: String {
        case position, thickness, length, color, offset, centered
        case margin // Implies centered = true
    }
    
    struct ViewBorder {
        let position: BorderPosition
        let color: UIColor
        let thickness: CGFloat
        let offset: CGFloat
        let length: CGFloat
        let centered: Bool
        let bounds: CGRect
        
        var margin: CGFloat = 0
        
        init?(properties: [BorderProperty: Any], bounds: CGRect) {
            
            guard properties.keys.contains(.position), let position = properties[.position] as? BorderPosition else {
                print("Border must have a position and it must cannot be nil")
                return nil
            }
            
            self.position = position
            self.bounds = bounds
            
            color = properties[.color] as? UIColor ?? UIColor.lightGray
            // Setting the marging automatically cancels centering
            centered = (properties[.centered] as? Bool) ?? false
            thickness = CGFloat.from(value: properties[.thickness], default: 1)
            length = CGFloat.from(value: properties[.length], default: [.top, .bottom].contains(position) ? self.bounds.width : self.bounds.height) - (centered ? (margin * 2) : 0)
            
            offset = CGFloat.from(value: properties[.offset], default: 0)
            
            self.margin = 0
            
            self.margin = CGFloat.from(value: properties[.margin]) { () -> CGFloat in
                var rMargin: CGFloat
                if [.top, .bottom].contains(position) {
                    if bounds.width == 0 {
                        rMargin = UIView().systemLayoutSizeFitting(CGSize(width: UIView.layoutFittingCompressedSize.width, height: bounds.height)).width
                    } else {
                        rMargin = bounds.width
                    }
                } else {
                    if bounds.height == 0 {
                        rMargin = UIView().systemLayoutSizeFitting(CGSize(width: bounds.width, height: UIView.layoutFittingCompressedSize.height)).height
                    } else {
                        rMargin = bounds.height
                    }
                }
                
                return max(rMargin - length, 0)
            }
        }
    }
    
    func addBorder(_ properties: [BorderProperty: Any], autoResizeWithView: Bool = false) {
        guard let viewBorder = ViewBorder(properties: properties, bounds: bounds) else {
            return debugLog("ViewBorder is nil")
        }
        
        var borderView: UIView?
        let identifier = "\(UIView.borderIdentifier).\(viewBorder.position)"
        
        for view in subviews where view.accessibilityIdentifier == identifier  {
            borderView = view
            borderView?.removeAllConstraints()
            break
        }
        
        if borderView == nil {
            borderView = UIView.init(frame: CGRect.zero)
            borderView?.accessibilityIdentifier = "\(UIView.borderIdentifier).\(viewBorder.position)"
            borderView?.add(to: self)
            borderView?.translatesAutoresizingMaskIntoConstraints(false)
        }
        
        guard let borderViewInstance = borderView else {
            return debugLog("BorderView is nil")
        }
        
        borderViewInstance.backgroundColor = viewBorder.color
        let inferredMargin = max(frame.width - viewBorder.length, 0) / 2
        
        let leftAndTopMargin = viewBorder.centered ? viewBorder.margin + inferredMargin: 0
        let rightAndBottomMargin = viewBorder.centered ? viewBorder.margin + inferredMargin : viewBorder.margin * 2
        
        switch viewBorder.position {
        case .top, .bottom:
            if viewBorder.position == .top {
                borderViewInstance.topAnchor.constraint(equalTo: topAnchor, constant: viewBorder.offset).isActive = true
            } else {
                borderViewInstance.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -viewBorder.offset).isActive = true
            }
            
            borderViewInstance.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftAndTopMargin).isActive = true
            borderViewInstance.height(viewBorder.thickness)
            
            if autoResizeWithView {
                borderView?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -rightAndBottomMargin).isActive = true
            } else {
                borderView?.width(viewBorder.length)
            }
            
        case .left, .right:
            if viewBorder.position == .left {
                borderViewInstance.leadingAnchor.constraint(equalTo: leadingAnchor, constant: viewBorder.offset).isActive = true
            } else {
                borderViewInstance.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -viewBorder.offset).isActive = true
            }
            
            borderViewInstance.topAnchor.constraint(equalTo: topAnchor, constant: leftAndTopMargin).isActive = true
            borderViewInstance.width(viewBorder.thickness)
            
            if autoResizeWithView {
                borderViewInstance.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -rightAndBottomMargin).isActive = true
            } else {
                borderViewInstance.height(viewBorder.length)
            }
        }
    }
}

// MARK: - Dimension

extension UIView {
    enum DimensionAmount { case atLeast, atMost }
    
    @discardableResult
    func width(_ width: CGFloat, dimensionAmount: DimensionAmount? = nil, priority: Float? = nil, breakingConstraint attribute: NSLayoutConstraint.Attribute? = nil) -> Self {
        if let attribute = attribute {
            for constraint in positionConstraints where constraint.firstAttribute == attribute {
                removeConstraint(constraint)
            }
        }
        
        let widthConstraint: NSLayoutConstraint
        
        if let dimensionAmount = dimensionAmount {
            if dimensionAmount == .atLeast {
                widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
            } else {
                widthConstraint = widthAnchor.constraint(lessThanOrEqualToConstant: width)
            }
        } else {
            widthConstraint = widthAnchor.constraint(equalToConstant: width)
        }
        
        if let priority = priority {
            widthConstraint.priority = UILayoutPriority(priority)
        }
        widthConstraint.isActive = true
        
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat, dimensionAmount: DimensionAmount? = nil, priority: Float? = nil, breakingConstraint attribute: NSLayoutConstraint.Attribute? = nil) -> Self {
        
        if let attribute = attribute {
            for constraint in positionConstraints where constraint.firstAttribute == attribute {
                removeConstraint(constraint)
            }
        }
        
        let heightConstraint: NSLayoutConstraint
        
        if let dimensionAmount = dimensionAmount {
            if dimensionAmount == .atLeast {
                heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
            } else {
                heightConstraint = heightAnchor.constraint(lessThanOrEqualToConstant: height)
            }
        } else {
            heightConstraint = heightAnchor.constraint(equalToConstant: height)
        }
        
        if let priority = priority {
            heightConstraint.priority = UILayoutPriority(priority)
        }
        heightConstraint.isActive = true
        
        return self
    }
    
    func square(ofSize dimension: CGFloat) {
        height(dimension)
        width(dimension)
    }
}

// MARK: - Translation

extension UIView {
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
    
    var positionConstraints: [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        if let positionConstraints = superview?.constraints {
            for constraint in positionConstraints {
                if let firstItem = constraint.firstItem as? UIView, firstItem == self, [.leading, .top, .trailing, .bottom].contains(constraint.firstAttribute) {
                    constraints.append(constraint)
                }
            }
        }
        
        return constraints
    }
    
    func translatePositionToConstraints() {
        guard superview != nil && frame != .zero else { return }
        
        translatesAutoresizingMaskIntoConstraints(false)
        
        let constraints: [NSLayoutConstraint.Attribute: CGFloat] = [
            .top: frame.minY,
            .leading: frame.minX
        ]
        
        var availableConstraints: [NSLayoutConstraint.Attribute] = []
        
        for constraint in positionConstraints {
            if let firstAttribute = constraints[constraint.firstAttribute] {
                constraint.constant = firstAttribute
                availableConstraints.append(constraint.firstAttribute)
            }
        }
        
        if !availableConstraints.contains(.top), let superview = self.superview, let topConstraint = constraints[.top] {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: topConstraint).isActive = true
        }
        
        if !availableConstraints.contains(.leading), let superview = self.superview, let leadingConstraint = constraints[.leading] {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingConstraint).isActive = true
        }
    }
    
    func removeAllConstraints() {
        removeConstraints(constraints)
        removeConstraints(positionConstraints)
    }
}

extension UIView {
    func isInView(_ view: UIView) -> Bool {
        return superview == view
    }
}

// MARK: Stacks

extension UIView {
    func removeFromStackIfStacked() {
        if let stack = superview as? UIStackView, isInStack(stack) {
            stack.removeArrangedSubview(self)
            removeFromSuperview()
        }
    }
    
    func isInStack(_ stack: UIStackView) -> Bool {
        return stack.arrangedSubviews.contains(self)
    }
    
    var isStacked: Bool {
        return superview is UIStackView
    }
    
    var isLastInStack: Bool {
        guard isStacked, let stack = superview as? UIStackView else { return false }
        return stack.arrangedSubviews.firstIndex(of: self) ?? 0 == (stack.arrangedSubviewsSize - 1)
    }
}
