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
    
    private var url: URL?
    let options = APIOption()
    let defaultHeaders: HashableKeyDictionary = Constant.API.Headers.ContentType.json
    
    private init(withURL url: URL? = nil) {
        self.url = url
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = URLSessionConfiguration.defaultHeaders
        
        session = URLSession(configuration: configuration)
    }
    
    private static func prepare(urlString: String?) -> APIClientProtocol {
        return APIClient(withURL: urlFromString(urlString))
    }
    
    /// Call this to initialize and prepare the client
    ///
    /// - parameter url: The base `url` to initialize the `client` with. The `url` should include the protocol. e.g. `https://rowapi.gmgamingsystems.com`
    static func client(withURL url: String?) -> APIClientProtocol {
        return prepare(urlString: url)
    }
    
    private static func urlFromString(_ urlString: String?) -> URL? {
        
        guard let urlString = urlString, let url = URL(string: urlString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) else {
            return nil
        }
        
        return url
    }
    
    func setBaseURL(withString urlString: String) {
        self.url = APIClient.urlFromString(urlString)
    }
    
    /// Creates and resumes a data task with the instance's session.
    ///
    /// - Parameters:
    ///   - forRelativePath: The relative path for which to make the call. This should be inform or a URI `/api/v1/Authentication/Login/10` rather than a URL `https://rowapi.gmgamingsystems.com/api/v1/Authentication/Login/10` as this would be appended to the base URL.
    ///   - options: The options to include with the call. If nil, the call will be made using default options as set in the `APIOption` struct.
    ///   - urlParams: the params to include with the call. These key-value pairs in this dictionary, if provided, would eventually be passed on to the URLRequest where they'd be constructed into url parameters.
    ///   - completion: The completion handle to call when the call is completed.
    func dataTask(forRelativePath path: String?, options: APIOption? = nil, urlParams params: StringKeyDictionary? = nil, payload: Data? = nil, completion: @escaping (Data?, Error?, HTTPURLResponse?) -> Void) {
        
        guard let url: URL = self.url?.appendingPathComponent(path ?? "") else {
            return completion(nil, NSError(domain: Constant.API.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: ResponseErrorConstant.noBaseURL]), nil)
        }
        
        let options = options ?? APIOption()
        
        let request = URLRequest(url: url, params: params, method: options.method ?? .get, options: options)
        
        // swiftlint:disable closure_body_length
        session?.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return completion(nil, error, response as? HTTPURLResponse)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                if let debugMessage = ResponseErrorConstant.Unexpected.ResposeType.message.debug?.replaceOccurrencies(of: [ResponseErrorConstant.Unexpected.Placeholder.function, ResponseErrorConstant.Unexpected.Placeholder.expected, ResponseErrorConstant.Unexpected.Placeholder.returned], with: ["\(#function)", "HTTPURLResponse", "\(type(of: response))"]) {
                    debugLog(String(describing: Self.self), message: debugMessage)
                }
                
                return completion(nil, NSError(domain: Constant.API.errorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: ResponseErrorConstant.Unexpected.ResposeType.message]), nil)
            }
            
            if let expectedStatusCode = options.expectedStatusCode, httpResponse.statusCode != expectedStatusCode || (options.expectedStatusCode == nil && httpResponse.statusCode >= options.minimumAcceptanceSuccessStatusCode) {
                
                var error: Error?
                let decoder = JSONDecoder()
                
                if let data = data {
                    do {
                        error = try decoder.decode(APIError.self, from: data)
                    } catch let error {
                        debugLog(String(describing: Self.self), message: "Error decoding response data: \(error.localizedDescription)")
                    }
                }
                
                if error == nil {
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
        }.resume()
    }
    
    fileprivate func object(for data: Data?, returnAsData: Bool) -> Any? {
        var result: Any?
        
        if let array = data?.array, !returnAsData {
            result = array
        } else if let dictionary = data?.dictionary, !returnAsData {
            result = dictionary
        } else {
            result = data
        }
        
        return result
    }
    
    /// Gets data by doing a `GET` API call to the provided relative path
    ///
    ///  - parameter dataFrom: The relative path to use for makign the api call. This is a uri and not the full url. The left path of the url will be prepended with the url property value of the instance
    ///  - parameter urlParams: the params to include with the call. These key-value pairs in this dictionary, if provided, would eventually be passed on to the URLRequest
    ///  - parameter options: The options to include with the call. If nil, the call will be made using default options as set in the `APIOption` struct. Any key-value pairs options will override the equivalent key-value pair found already contained in the method.
    ///
    ///         if let client: APIClientProtocol = APIClient.client(withURL: Constant.API.BaseURL.restOfWorld) {
    ///             let path = "/api/v1/Authentication/Login/10"
    ///
    ///             var options = APIOption(authorizationType: .basic, authorizationValue: "EBester06:esport120".toBase64())
    ///             options.expectedStatusCode = 200
    ///             options.httpHeaders = [APIHeaders.Key.productID: "31615"]
    ///
    ///             client.get(dataFrom: path, options: options) { (object, error, response) in
    ///                 print("\(String(describing: object))")
    ///                 print("\(String(describing: response))")
    ///                 print("\(String(describing: error))")
    ///             }
    ///         }
    ///
    ///  - parameter completion: The completion handle to call when the call is completed.
    func get(dataFrom relativePath: String?, urlParams params: StringKeyDictionary? = nil, options: APIOption? = nil, returnAsData: Bool = true, callback: @escaping (Any?, Error?, HTTPURLResponse?) -> Void) {
        
        var mutableOptions = options ?? self.options
        mutableOptions.method = .get
        mutableOptions.expectedStatusCode = mutableOptions.expectedStatusCode ?? 200
        mutableOptions.httpHeaders = [
            APIHeaders.Key.productID: Application.shared.get(valuefor: Application.DataKey.productID),
            APIHeaders.Key.referer: APIHeaders.Value.referer
            ].merging(mutableOptions.httpHeaders ?? [:]) { $1 }
        
        dataTask(forRelativePath: relativePath, options: mutableOptions, urlParams: params) { data, error, response in
            
            callback(self.object(for: data, returnAsData: returnAsData), error, response)
        }
    }
    
    /// Sends data by doing a `POST` API call to the provided relative path
    ///
    ///  - parameter data: The data to post for the call
    ///  - parameter to: The relative path to use for makign the api call. This is a uri and not the full url. The left path of the url will be prepended with the url property value of the instance
    ///  - parameter options: The options to include with the call. If nil, the call will be made using default options as set in the `APIOption` struct. Any key-value pairs options will override the equivalent key-value pair found already contained in the method.
    ///
    ///         if let client: APIClientProtocol = APIClient.client(withURL: Constant.API.BaseURL.restOfWorld) {
    ///             let path = "/api/v1/Authentication/Login/10"
    ///
    ///             var options = APIOption(authorizationType: .basic, authorizationValue: "EBester06:esport120".toBase64())
    ///             options.expectedStatusCode = 200
    ///             options.httpHeaders = [APIHeaders.Key.productID: "31615"]
    ///
    ///             client.post(data: nil, to: path, options: options) { (object, error, response) in
    ///                 print("\(String(describing: object))")
    ///                 print("\(String(describing: response))")
    ///                 print("\(String(describing: error))")
    ///             }
    ///         }
    ///
    /// - parameter completion: The completion handle to call when the call is completed.
    func post(data json: GenericDictionary?, to relativePath: String?, options: APIOption? = nil, returnAsData: Bool = true, callback: @escaping (Any?, Error?, HTTPURLResponse?) -> Void) {
        
        var mutableOptions = options ?? self.options
        mutableOptions.method = .post
        mutableOptions.expectedStatusCode = mutableOptions.expectedStatusCode ?? 200
        mutableOptions.httpHeaders = [
            APIHeaders.Key.productID: Application.shared.get(valuefor: Application.DataKey.productID),
            APIHeaders.Key.regionCode: APIHeaders.Value.regionCode,
            APIHeaders.Key.referer: APIHeaders.Value.referer
            ].merging(mutableOptions.httpHeaders ?? [:]) { $1 }
        
        let payload = json?.data
        
        dataTask(forRelativePath: relativePath, options: mutableOptions, payload: payload) { data, error, response in
            
            callback(self.object(for: data, returnAsData: returnAsData), error, response)
        }
        
    }
}
