//
//  NetworkActivityAware.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

/**
 This is used to add network activity awareness capability to it's implementing class.
 
 The extension of this protocol implements a few methods that can be called directly in the implementing class
 for when a network call is triggered and when it comed to a completion
 */
protocol NetworkActivityAware: class {}

extension NetworkActivityAware {
    
    /// Returns the name of the implementing class as a string.
    var className: String {
        return String(describing: Self.self)
    }
    
    /// Call this method to indicate a network call has been triggered.
    func networkActivityStarted() {
        networkActivityStatus = .started
    }
    
    /// Call this method for when a network call is complete
    func networkActivityComplete() {
        networkActivityStatus = .completed
    }
    
    /// This is used to explicity `get` or `set` the activity status of the network call
    /// This is used in the `networkActivityStarted` and `networkActivityComplete` methods.
    var networkActivityStatus: NetworkActivity.Status? {
        get { return NetworkActivity.shared.status(for: className) }
        set {
            NetworkActivity.shared.setStatus(newValue, for: className)
        }
    }
}
