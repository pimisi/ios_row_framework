//
//  URLRequest+Extension.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension URLRequest {
    init(url: URL, params: StringKeyDictionary? = nil, method: HTTPMethod, options: APIOption? = nil, body: Data? = nil) {
        
        // swiftlint:disable implicitly_unwrapped_optional
        var requestUrl: URL!
        
        if let params = params {
            let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
            if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                components.queryItems = queryItems
                if let componentURL = components.url {
                    requestUrl = componentURL
                }
            }
            
            if requestUrl == nil {
                requestUrl = url
                debugLog("Failed to append the urlParameters `\(params)` to the url: \(url.absoluteString). Using the plain url instead.")
            }
        } else {
            requestUrl = url
        }
        
        self.init(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: options?.requestTimeout ?? 60.0)
        httpMethod = method.asString
        
        let headers = options?.httpHeaders ?? [:].merging(URLSessionConfiguration.defaultHeaders) { $1 }
        
        for (header, value) in headers {
            setValue(value, forHTTPHeaderField: header)
        }
        
        httpBody = body
    }
}
