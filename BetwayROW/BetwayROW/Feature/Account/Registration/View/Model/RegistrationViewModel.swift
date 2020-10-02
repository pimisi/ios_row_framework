//
//  RegistrationViewModel.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/28.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

class RegistrationViewModel: ProcessMonitoringWithActivityAwareness {
    
    let configurationClient = ConfigurationClient(withClient: APIClient.client(withURL: nil))
    let accountClient = AccountClient(withClient: APIClient.client(withURL: nil))
    
    lazy var processing: NetworkProcessing = monitor()
    
    var loading: ((Bool) -> Void)?
    var complete: ((Bool) -> Void)?
    
    func getNationalities(completion: @escaping (Nationalities) -> Void) {
        
        if !isLoading {
            networkActivityStarted()
        }
        
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
            
            if self?.isLoading == false && self?.isComplete == true {
                self?.networkActivityComplete()
            }
        }
    }
    
    func getCountries(completion: @escaping (Countries) -> Void) {
        
        if !isLoading {
            networkActivityStarted()
        }
        
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
            
            if self?.isLoading == false && self?.isComplete == true {
                self?.networkActivityComplete()
            }
        }
    }
    
    func getCurrencies(completion: @escaping (Currencies) -> Void) {
        
        if !isLoading {
            networkActivityStarted()
        }
        
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
            
            if self?.isLoading == false && self?.isComplete == true {
                self?.networkActivityComplete()
            }
        }
    }
    
    func validateUsername(_ username: String?, completion: @escaping (_ validation: UsernameValidation?) -> Void) {
        guard let username = username else {
            debugLog("Username is nil. Username should not be nil or empty.")
            return completion(nil)
        }
        
        accountClient.validateUsername(username, completion: { [weak self] result in
            switch result {
            case .success(let validation):
                completion(validation)
            case .failure(let failure):
                debugLog(String(describing: self), message: "Error validating username \(username): \(String(describing: failure?.description))")
                ErrorCoordinator.shared.error = failure
            }
        })
    }
}
