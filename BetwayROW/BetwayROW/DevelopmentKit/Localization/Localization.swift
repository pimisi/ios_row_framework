//
//  LocalisedString.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

protocol LocalizationProtocol: Localization {
    static func localized(key: String, in file: StringsFile) -> String
}

class Localization: LocalizationProtocol {
    class func localized(key: String, in file: StringsFile = .betway) -> String {
        return NSLocalizedString(key,
                                 tableName: file.rawValue,
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
}
