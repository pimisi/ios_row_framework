//
//  BaseViewController.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: Button!
    
    private class Segue {
        static let base = "base"
    }
    
    let viewModel = BaseViewModel()
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return UIRectEdge.bottom
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return false
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        getConfiguration()
        getSiteMap()
    }
    
    @IBAction func retry(_ sender: Any) {
        getConfiguration()
        getSiteMap()
    }
}

extension BaseViewController {
    
    func bindViewModel() {
        viewModel.loading = { loading in
            Application.shared.updateUI {
                if loading {
                    self.retryButton.isHidden = true
                    self.loadingActivityIndicator.startAnimating()
                } else {
                    self.loadingActivityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.complete = { success in
            Application.shared.updateUI {
                if success {
                   self.performSegue(withIdentifier: Segue.base, sender: nil)
                } else {
                    self.retryButton.isHidden = false
                }
            }
            
        }
    }
    
    func getConfiguration() {
        viewModel.getConfiguration()
    }
    
    func getSiteMap() {
        viewModel.getSiteMap()
    }
}
