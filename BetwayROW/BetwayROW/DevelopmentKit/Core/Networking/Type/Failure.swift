//
//  Failure.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

struct Failure: Error {
    private var message: Any?
    
    let title: String?
    let error: FailureType?
    
    init(error: Error?, title: String? = nil, message: AnyObject? = nil, responseStatusCode: Int? = 1) {
        if let error = error as? APIError {
            self.error = error
        } else {
            self.error = FailureReason(error: error, responseStatusCode: responseStatusCode)
        }
        
        self.title = title
        self.message = message ?? self.error?.message
    }
    
    var description: String {
        if let messageObject = message as? [[String: Any]], let key = messageObject.first?.keys.first, key.lowercased() == "message", let message = messageObject.first?[key] as? String {
            return message
        } else if let message = message as? String {
            return message
        } else {
            return error?.message ?? FailureReason.unknown.message ?? "unknown"
        }
    }
    
    var code: Int {
        return error?.code ?? 1
    }
}
