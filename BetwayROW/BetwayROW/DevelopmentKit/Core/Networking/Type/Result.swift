//
//  Result.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(payload: T)
    case failure(U?)
}
