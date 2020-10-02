//
//  BaseViewModel.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

class BaseViewModel: ProcessMonitoring {
    
    let configurationClient = ConfigurationClient(withClient: APIClient.client(withURL: nil))
    let sitemapClient = SiteMapClient(withClient: APIClient.client(withURL: nil))
    
    lazy var processing: NetworkProcessing = monitor()
        
    var loading: ((_ loading: Bool) -> Void)?
    var complete: ((_ complete: Bool) -> Void)?
    
    func getChannels() {
        
        processing.set(loading: true)
        
        configurationClient.getChannels { result in
            switch result {
            case .success(let channels):
                Application.shared.set(productID: channels.ios ?? 31615)
                self.processing.set(success: true)
            case .failure(let failure):
                debugLog(String(describing: Self.self), message: "Error fetching channels: \(String(describing: failure?.description))")
                
                self.processing.set(success: false)
            }
            self.processing.set(loading: false)
        }
    }
    
    func getSiteMap() {
        
        processing.set(loading: true)
        
        sitemapClient.getSiteMap { result in
            switch result {
            case .success(let sitemap):
                self.processing.set(success: true)
                Application.shared.set(siteMap: sitemap)
            case .failure(let failure):
                debugLog(String(describing: Self.self), message: "Error fetching sitemap: \(String(describing: failure?.description))")
                
                self.processing.set(success: false)
            }
            self.processing.set(loading: false)
        }
        
    }
}
