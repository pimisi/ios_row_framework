//
//  DebugLog.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

/**
 Used for logging messages while in debug mode
 */
func debugLog(_ message: String) {
    #if DEBUG
        print(message)
    #endif
}

/**
Used for logging messages and the originating class while in debug mode
*/
func debugLog(_ className: String, message: String) {
    #if DEBUG
        print(className + " | " + message)
    #endif
}
