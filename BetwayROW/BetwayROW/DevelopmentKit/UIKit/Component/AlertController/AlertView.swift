//
//  AlertView.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/21.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    let contentView = UIView(withRoundedCorners: 6)
    let actionContainer = UIView()
    
    let titleHeight = Layout.Size.size40
    let buttonSize = Layout.Size.size56
    let titlePadding = UIEdgeInsets(top: Layout.spacing0, left: Layout.spacing8, bottom: Layout.spacing0, right: Layout.spacing8)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var mainContentStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = Layout.spacing18
        return stack
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colour.Background.pale
        view.height(titleHeight)
        view.addBorder([.position : UIView.BorderPosition.bottom, .color: Colour.Grey.dcd], autoResizeWithView: true)
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var actionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = Layout.spacing8
        return stack
    }()
    
    private lazy var dismissButton: UIView = {
        let view = UIView()
        
        let button = UIButton()
        button.setImage(Image.close.colored(with: Colour.black), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        button.center(in: view)
        button.square(ofSize: Layout.Size.size10)
        view.square(ofSize: min(titleHeight, buttonSize))
        view.backgroundColor = Colour.clear
        
        return view
    }()
    
    var actions: [AlertAction] = [] {
        didSet {
            actionStack.removeAllArrangedSubviews()
            actions.forEach { actionStack.addArrangedSubview($0.button) }
        }
    }
    
    var bodyView: UIView? {
        didSet {
            if let bodyView = bodyView {
                if !bodyView.isInStack(mainContentStack) {
                    mainContentStack.insertArrangedSubView(bodyView, after: messageLabel)
                }
            }
        }
    }
    
    var parent: UIView?
    var showDismissIcon: Bool = false {
        didSet {
            if showDismissIcon {
                attachDismissIcon()
            } else {
                if dismissButton.isInView(headerView) {
                    dismissButton.removeFromSuperview()
                    titleLabel.adjustPadding(leading: titlePadding.left, trailing: titlePadding.right)
                }
            }
            
        }
    }
    
    @objc var dismiss: ((Bool) -> Void)?
    
    init(parent: UIView) {
        self.parent = parent
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        self.parent = nil
        super.init(coder: coder)
    }
    
    func layout(title: String?, message: String?) {
        if let parent = parent {
            center(in: parent, axis: .vertical)
            fit(to: parent, leading: Layout.spacing32, top: Layout.spacing0, trailing: Layout.spacing32, bottom: Layout.spacing0)
        }
        titleLabel.text = title
        messageLabel.text = message
        
        if message != nil {
            messageLabel.margins(margin: Layout.spacing32)
            mainContentStack.spacing = Layout.spacing16
        } else {
            mainContentStack.spacing = Layout.spacing0
        }
        
        backgroundColor = .clear
        
        layoutActionContainer()
        layoutContenStack()
        configureContentView()
    }
    
    @objc private func dismissView() {
        dismiss?(true)
    }
    
    @objc private func action(_ sender: UIButton) {
        let action = actions[sender.tag]
        action.handler?(action)
        
        if action.style == .primary {
            dismiss?(true)
        }
    }
    
    private func attachDismissIcon() {
        dismissButton.fit(to: headerView, top: Layout.spacing0, trailing: Layout.spacing0)
        titleLabel.adjustPadding(leading: buttonSize + titlePadding.left, trailing: buttonSize + titlePadding.right)
    }
    
    private func layoutContenStack() {
        
        titleLabel.fit(inside: headerView, leading: titlePadding.left, trailing: titlePadding.right)
        
        if showDismissIcon {
            attachDismissIcon()
        }
        
        mainContentStack.addArrangedSubview(headerView)
        mainContentStack.addArrangedSubview(messageLabel)
        
        if let bodyView = bodyView {
            mainContentStack.addArrangedSubview(bodyView)
        }
        
        contentStack.addArrangedSubview(mainContentStack)
        contentStack.addArrangedSubview(actionContainer)
        contentStack.fit(inside: contentView)
    }
    
    private func configureContentView() {
        contentView.center(in: self)
        contentView.backgroundColor = Colour.white
        contentView.width(Layout.Size.size350, dimensionAmount: .atLeast)
    }
    
    private func layoutActionContainer() {
        actionStack.fit(inside: actionContainer, padding: Layout.spacing8)
        actionContainer.backgroundColor = Colour.white
    }
    
    func addAction(_ action: AlertAction) {
        action.button.setTitle(action.title, for: .normal)
        action.button.addTarget(self, action: #selector(action(_:)), for: .touchUpInside)
        action.button.tag = actions.count
        action.button.translateSizeToConstraints()
        
        actions.append(action)
    }
}
