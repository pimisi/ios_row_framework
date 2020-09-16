//
//  APIResponseProtocol.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

protocol APICientResponseProtocol {}

extension APICientResponseProtocol {
    func processResponse<ResultType: Decodable>(data: Any?, error: Error?, response: HTTPURLResponse?, extectedStatusCode: Int, completion: @escaping (_ result: Result<ResultType, Failure>) -> Void) {
        
        if response == nil || error != nil {
            let failure: Failure?
            
            if let response = response {
                failure = Failure(error: error, responseStatusCode: response.statusCode)
            } else {
                failure = Failure(error: error)
            }
            
            return completion(.failure(failure))
            
        } else if let response = response {
            guard response.statusCode == extectedStatusCode else {
                let reason = FailureReason(rawValue: response.statusCode)
                return completion(.failure(Failure(error: reason)))
            }
            
            if let data = data as? Data {
                do {
                    let configuration = try JSONDecoder().decode(ResultType.self, from: data)
                    return completion(.success(payload: configuration))
                } catch let error {
                    debugLog(String(describing: Self.self), message: "Error decoding data into `\(ResultType.self)`: \(error.localizedDescription)")
                }
            } else {
                debugLog(String(describing: Self.self), message: "The payload is not of expected type `Data`.")
            }
            return completion(.failure(Failure(error: FailureReason.invalidResponse)))
        }
    }
}
