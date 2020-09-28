//
//  RegistrationViewModel.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/28.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

class RegistrationViewModel: ProcessMonitoring {
    
    let configurationClient = ConfigurationClient(withClient: APIClient.client(withURL: nil))
    
    lazy var processing: NetworkProcessing = monitor()
    
    var loading: ((Bool) -> Void)?
    var complete: ((Bool) -> Void)?
    
    func getNationalities(completion: @escaping (Nationalities) -> Void) {
        
        processing.set(loading: true)
        
        configurationClient.getNationalities { [weak self] result in
            switch result {
            case .success(let nationalities):
                self?.processing.set(success: true)
                completion(nationalities)
            case .failure(let failure):
                debugLog(String(describing: Self.self), message: "Error fetching nationalities: \(String(describing: failure?.description))")
                
                self?.processing.set(success: false)
            }
            self?.processing.set(loading: false)
        }
    }
    
    func getCountries(completion: @escaping (Countries) -> Void) {
        
        processing.set(loading: true)
        
        configurationClient.getCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.processing.set(success: true)
                completion(countries)
            case .failure(let failure):
                debugLog(String(describing: Self.self), message: "Error fetching countries: \(String(describing: failure?.description))")
                
                self?.processing.set(success: false)
            }
            self?.processing.set(loading: false)
        }
    }
    
    func getCurrencies(completion: @escaping (Currencies) -> Void) {
        
        processing.set(loading: true)
        
        configurationClient.getCurrencies { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.processing.set(success: true)
                completion(currencies)
            case .failure(let failure):
                debugLog(String(describing: Self.self), message: "Error fetching currencies: \(String(describing: failure?.description))")
                
                self?.processing.set(success: false)
            }
            self?.processing.set(loading: false)
        }
    }
}
