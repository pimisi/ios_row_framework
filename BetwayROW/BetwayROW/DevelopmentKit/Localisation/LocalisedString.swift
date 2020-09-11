//
//  LocalisedString.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

public enum StringsFile: String {
    case betwayStrings = "Localisable"
}

protocol LocalisableProtocol: Localisable {
    static func localized(key: String, in file: StringsFile) -> String
}

class Localisable: LocalisableProtocol {
    class func localized(key: String, in file: StringsFile = .betwayStrings) -> String {
        return NSLocalizedString(key,
                                 tableName: file.rawValue,
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
}
