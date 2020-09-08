//
//  API.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension Constant {
    class API: ConstantType {
        private static let bundle = Bundle(for: Constant.self)
        
        private class BundleKey: ConstantType {
            static let `protocol` = "BaseAPIURLProtocol"
            static let restOfWorld = "BaseROWURL"
        }
        
        class BaseURL: ConstantType {
            static let restOfWorld: String = {
                guard let `protocol` = Constant.infoDictionary?[BundleKey.protocol] as? String, let uri = Constant.infoDictionary?[BundleKey.restOfWorld] as? String else {
                    debugLog("The 'BaseURI' is not set because one or both of the service key(s) of '\(BundleKey.protocol)' and '\(BundleKey.restOfWorld)' is/are not present in the info dictionary")
                    return ""
                }
                
                return "\(`protocol`)://\(uri)"
            }()
        }
        
        static let errorDomain = "com.osiris.row"
        
        class Headers: ConstantType {
            class ContentType: ConstantType {
                static let key = "Content-Type"
                class Value: ConstantType {
                    static let json = "application/json"
                }
                static let json: GenericDictionary = [key: Value.json]
            }
            
            class Accept: ConstantType {
                static let key = "Accept"
                class Value: ConstantType {
                    static let json = "application/json"
                }
                static let json: GenericDictionary = [key: Value.json]
            }
        }
    }
}
