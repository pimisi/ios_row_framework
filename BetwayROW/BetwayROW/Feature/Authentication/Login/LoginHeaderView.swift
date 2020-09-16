//
//  LoginHeaderView.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/16.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

extension LoginHeaderView {
    var closeButtonImage: UIImage { UIImage(named: "ic-close") ?? UIImage() }
}

final class LoginHeaderView: BaseView {
    
    var handleCloseButtonTapped: (() -> Void)?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(closeButtonImage, for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func configureView() {
        backgroundColor = Colours.shared.dark
        
        addSubview(closeButton)
        closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Layout.spacing16).isActive = true
        closeButton.centerYAnchor ->> centerYAnchor
        closeButton.height(Layout.spacing24)
        closeButton.width(Layout.spacing24)
    }
    
    @objc private func didTapClose() {
        handleCloseButtonTapped?()
    }
    
}
