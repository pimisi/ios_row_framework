//
//  FailureType.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

protocol FailureType: Error {
    var message: String? { get }
    var value: Int { get }
}

extension FailureType {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}
