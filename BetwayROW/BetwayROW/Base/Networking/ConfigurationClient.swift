//
//  ConfigurationClient.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

class ConfigurationClient: APICientResponseProtocol {
    
    typealias ChannelCompletionResult = Result<Channel, Failure>
    typealias ChannelsCompletion = (_ result: ChannelCompletionResult) -> Void
    
    typealias CountriesCompletionResult = Result<Countries, Failure>
    typealias CountriesCompletion = (_ result: CountriesCompletionResult) -> Void
    
    typealias NationalitiesCompletionResult = Result<Nationalities, Failure>
    typealias NationalitiesCompletion = (_ result: NationalitiesCompletionResult) -> Void
    
    typealias CurrenciesCompletionResult = Result<Currencies, Failure>
    typealias CurrenciesCompletion = (_ result: CurrenciesCompletionResult) -> Void
    
    private let client: APIClientProtocol
    
    var baseURL = APIEndpoint.Configuration.base
    
    init(withClient client: APIClientProtocol) {
        self.client = client
        self.client.setBaseURL(withString: baseURL)
    }
    
    func getChannels(completion: @escaping ChannelsCompletion) {
        
        guard let regionCode = Application.shared.regionCode else {
            return completion(.failure(Failure(error: nil, title: "Error", message: "The Region Code is not set")))
        }
        
        let path = APIEndpoint.Configuration.channels.appending(regionCode)
        
        client.get(dataFrom: path, urlParams: nil, options: nil, returnAsData: true) { (data, error, response) in
            self.processResponse(data: data, error: error, response: response, extectedStatusCode: 200, completion: completion)
        }
        
    }
    
    func getNationalities(completion: @escaping NationalitiesCompletion) {
        let path = APIEndpoint.Configuration.nationalities
        
        client.get(dataFrom: path, urlParams: nil, options: nil, returnAsData: true) { (data, error, response) in
            self.processResponse(data: data, error: error, response: response, extectedStatusCode: 200, completion: completion)
        }
    }
    
    func getCountries(completion: @escaping CountriesCompletion) {
        let path = APIEndpoint.Configuration.countries
        
        client.get(dataFrom: path, urlParams: nil, options: nil, returnAsData: true) { (data, error, response) in
            self.processResponse(data: data, error: error, response: response, extectedStatusCode: 200, completion: completion)
        }
    }
    
    func getCurrencies(completion: @escaping CurrenciesCompletion) {
        let path = APIEndpoint.Configuration.currencies
        
        client.get(dataFrom: path, urlParams: nil, options: nil, returnAsData: true) { (data, error, response) in
            self.processResponse(data: data, error: error, response: response, extectedStatusCode: 200, completion: completion)
        }
    }
}
