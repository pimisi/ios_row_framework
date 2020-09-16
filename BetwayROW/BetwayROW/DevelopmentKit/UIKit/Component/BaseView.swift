//
//  BaseView.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/16.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

public class  BaseView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colour.white
        self.configureView()
    }
    
    public func configureView() {
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
