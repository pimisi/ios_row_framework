//
//  ApplicationConstant.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

extension Constant.Application {
    static var regionCode: String? = {
        guard let regionCode = Constant.infoDictionary?.string(forKey: "RegionCode") else {
            debugLog("Constant.Application", message: "RegionCode is not set in the info.plist file.")
            return nil
        }
        return regionCode
    }()
    
    static var defaultBTag: String? = {
        guard let regionCode = Constant.infoDictionary?.string(forKey: "BTag") else {
            debugLog("Constant.Application", message: "BTag is not set in the info.plist file.")
            return nil
        }
        return regionCode
    }()
}
