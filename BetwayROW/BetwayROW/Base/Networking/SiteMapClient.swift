//
//  SiteMapClient.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

class SiteMapClient: APICientResponseProtocol {
    
    typealias SiteMapCompletionResult = Result<SiteMap, Failure>
    typealias SiteMapCompletion = (_ result: SiteMapCompletionResult) -> Void
    
    private let client: APIClientProtocol
    
    var baseURL = APIEndpoint.GamingSystems.base
    
    init(withClient client: APIClientProtocol) {
        self.client = client
        self.client.setBaseURL(withString: baseURL)
    }
    
    func getSiteMap(completion: @escaping SiteMapCompletion) {
        
        let path = APIEndpoint.GamingSystems.site
        
        let params: StringKeyDictionary = [
            URLParams.Key.host: URLParams.Value.host,
            URLParams.Key.userAgent: URLParams.Value.userAgent,
            URLParams.Key.app: URLParams.Value.app,
        ]
        
        client.get(dataFrom: path, urlParams: params, options: nil, returnAsData: true) { (data, error, response) in
            
            self.processResponse(data: data, error: error, response: response, extectedStatusCode: 200, completion: completion)
        }
        
    }
}
