//
//  MainViewController.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/10.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return UIRectEdge.bottom
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()     
    }
}
