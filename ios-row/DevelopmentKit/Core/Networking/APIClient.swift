//
//  APIClient.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

class APIClient: APIClientProtocol {
    
    private var session: URLSession?
    
    let url: URL
    let options = APIOption()
    let defaultHeaders: HashableKeyDictionary = Constant.API.Headers.ContentType.json
    
    private init(withURL url: URL) {
        self.url = url
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = URLSessionConfiguration.defaultHeaders
        
        session = URLSession(configuration: configuration)
    }
    
    private static func prepare(urlString: String) -> APIClientProtocol? {
        guard let url = URL(string: urlString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) else {
            return nil
        }
        return APIClient(withURL: url)
    }
    
    static func client(withURL url: String) -> APIClientProtocol? {
        return prepare(urlString: url)
    }
    
    /// Creates and resumes a data task with the instance's session.
    ///
    /// - Parameters:
    ///   - forRelativePath: The relative path for which to make the call. This should be inform or a URI `user/login` rather than a URL `https://somedomain.com/user/login` as this would be appended to the base URL.
    ///   - options: The options to include with the call. If nil, the call will be made using default options as set in the `APIOption` struct.
    ///   - urlParams: the params to include with the call. These key-value pairs in this dictionary, if provided, would eventually be passed on to the URLRequest where they'd be constructed into url parameters.
    ///   - completion: The completion handle to call when the call is completed.
    func dataTask(forRelativePath path: String?, options: APIOption? = nil, urlParams params: StringKeyDictionary? = nil, completion: @escaping (Data?, Error?, HTTPURLResponse?) -> Void) {
        
        let url: URL = self.url.appendingPathComponent(path ?? "")
        let options = options ?? APIOption()
        
        let request = URLRequest(url: url, params: params, method: options.method ?? .get, options: options)
        
        session?.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                return completion(nil, error, response as? HTTPURLResponse)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                if let debugMessage = ResponseErrorConstant.Unexpected.ResposeType.message.debug?.replaceOccurrencies(of: [ResponseErrorConstant.Unexpected.Placeholder.function, ResponseErrorConstant.Unexpected.Placeholder.expected, ResponseErrorConstant.Unexpected.Placeholder.returned], with: ["\(#function)", "HTTPURLResponse", "\(type(of: response))"]) {
                    debugLog(String(describing: Self.self), message: debugMessage)
                }
                
                return completion(nil, NSError(domain: Constant.API.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: ResponseErrorConstant.Unexpected.ResposeType.message]), nil)
            }
            
            if let expectedStatusCode = options.expectedStatusCode, httpResponse.statusCode != expectedStatusCode {
                
                var error: Error?
                let decoder = JSONDecoder()
                
                if let data = data {
                    do {
                        error = try decoder.decode(APIError.self, from: data)
                    } catch let error {
                        debugLog(String(describing: Self.self), message: "Error decoding results: \(error)")
                    }
                    // TODO: Log to splunk
                } else {
                    error = NSError(domain: Constant.API.errorDomain, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: ResponseErrorConstant.Unexpected.Code.message])
                    
                    if let debugMessage = ResponseErrorConstant.Unexpected.ResposeType.message.debug?.replaceOccurrencies(of: [ResponseErrorConstant.Unexpected.Placeholder.function, ResponseErrorConstant.Unexpected.Placeholder.returned], with: ["\(#function)", String(describing: data?.dictionary)]) {
                        debugLog(String(describing: Self.self), message: debugMessage)
                    }
                }
                
                return completion(nil, error, httpResponse)
                
            }
            
            guard let responseData = data else {
                let error = NSError(domain: Constant.API.errorDomain, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: ResponseErrorConstant.zeroDataLength])
                return completion(nil, error, httpResponse)
            }
            
            completion(responseData, nil, httpResponse)
        })
        
    }
}
