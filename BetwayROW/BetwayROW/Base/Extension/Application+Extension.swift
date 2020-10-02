//
//  Application+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension Application {
    
    var regionCode: String? {
        return ApplicationConstant.regionCode
    }
    
    var defaultBTag: String? {
        return ApplicationConstant.defaultBTag
    }
    
    func set(siteMap: SiteMap) {
        data[DataKey.siteMap] = siteMap
    }
    
    func set(selectedProductForItem item: Int) {
        guard let siteMap = data.object(forKey: DataKey.siteMap) as? SiteMap,
              let mid = siteMap.sitemap[item]?.MID else {
            return
        }
        
        data[DataKey.selectedProduct] = mid
    }
}

extension Application.DataKey {
    static let siteMap: ApplicationDataKey = ApplicationConstant.Data.Key.siteMap
    static let selectedProduct: ApplicationDataKey = ApplicationConstant.Data.Key.selectedProduct
}
