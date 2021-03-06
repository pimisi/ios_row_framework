//
//  API.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

typealias APIHeaders = Constant.API.Headers
typealias ResponseErrorConstant = Constant.API.Response.Error
typealias APIEndpoint = Constant.API.Endpoint
typealias URLParams = Constant.API.URLParams

extension Constant.BundleKey {
    static let `protocol` = "BaseAPIURLProtocol"
    static let restOfWorld = "BaseROWURL"
    static let version = "BaseROWURLVersion"
}

extension Constant {
    // swiftlint:disable nesting
    class API: ConstantType {
        private static let bundle = Bundle(for: Constant.self)
        
        private class BundleKey: ConstantType {
            static let `protocol` = "BaseAPIURLProtocol"
            static let restOfWorld = "BaseROWURL"
            static let gamingSystems = "GamingSystemsBaseURL"
            static let version = "BaseROWURLVersion"
        }
        
        class BaseURL: ConstantType {
            static let restOfWorld: String = {
                guard let `protocol` = Constant.infoDictionary?[BundleKey.protocol] as? String,
                    let uri = Constant.infoDictionary?[BundleKey.restOfWorld] as? String,
                    let version = Constant.infoDictionary?[BundleKey.version] as? String else {
                    debugLog("The 'BaseURI' is not set because one or both of the service key(s) of '\(BundleKey.protocol)' and '\(BundleKey.restOfWorld)' is/are not present in the info dictionary")
                    return ""
                }
                
                return "\(`protocol`)://\(uri)/\(version)/"
            }()
            
            static let gamingSystem: String = {
                guard let `protocol` = Constant.infoDictionary?[BundleKey.protocol] as? String,
                    let uri = Constant.infoDictionary?[BundleKey.gamingSystems] as? String,
                    let version = Constant.infoDictionary?[BundleKey.version] as? String else {
                    debugLog("The 'BaseURI' is not set because one or both of the service key(s) of '\(BundleKey.protocol)' and '\(BundleKey.gamingSystems)' is/are not present in the info dictionary")
                    return ""
                }
                
                return "\(`protocol`)://\(uri)/"
            }()
        }
        
        static let errorDomain = "com.osiris.row"
        
        class Headers: ConstantType {
            
            enum AuthorizationType {
                case bearer, basic
            }
            class Authorization: ConstantType {
                public static let key = "authorization"
                
                class Bearer {
                    public static func value(accessToken: String) -> String {
                        return "Bearer " + accessToken
                    }
                }
                
                class Basic {
                    public static func value(encoded: String) -> String {
                        return "Basic " + encoded
                    }
                }
                
                public static func pairs(withValue value: String, type: AuthorizationType = .bearer) -> StringKeyDictionary {
                    switch type {
                    case .basic: return [key: Basic.value(encoded: value)]
                    default: return [key: Bearer.value(accessToken: value)]
                    }
                }
            }
            
            class ContentType: ConstantType {
                static let key = "Content-Type"
                class Value: ConstantType {
                    static let json = "application/json"
                }
                static let json: StringKeyDictionary = [key: Value.json]
            }
            
            class Accept: ConstantType {
                static let key = "Accept"
                class Value: ConstantType {
                    static let json = "application/json"
                }
                static let json: StringKeyDictionary = [key: Value.json]
            }
            
            class Key: ConstantType {
                static let productID = "X-ProductId"
                static let regionCode = "X-Region-Code"
                static let referer = "Referer"
            }
            
            class Value: ConstantType {
                static let regionCode = "BBG"
                static let referer = "Betway_Bulgaria_IOS"
            }
        }
        
        class Endpoint: ConstantType {}
        class URLParams: ConstantType {
            class Key: ConstantType {}
            class Value: ConstantType {}
        }
    }
}

extension Constant.API  {
    typealias UIMessage = Constant.UIMessage
    typealias Message = Constant.Message
}

extension Constant.API {
    class Response: ConstantType {
        class Error: ConstantType {
            static let unknown = Message(debug: "An error occurred. Please try again later.")
            static let ssl = Message(display: UIMessage(title: "Connection error", detail: "A connection could not be made."), debug: "SSL Error")
            static let internalServer = Message(display: UIMessage(title: "Server error", detail: "An error occured on the server. It might be under maintenance at the moment. Please try again later."), debug: "Internal Server Error")
            static let noBaseURL = Message(display: UIMessage(title: "Service Error", detail: "The URL is malformed"), debug: "The baseURL is not set for the API call")
            
            class Unexpected: ConstantType {
                class Placeholder: ConstantType {
                    static let function = "::function"
                    static let expected = "::expected"
                    static let returned = "::returned"
                }
                
                class ResposeType: ConstantType {
                    static let message = Message(display: UIMessage(title: "Error", detail: "The response is not of the expected type"), debug: "\(Placeholder.function) The response is not of the expected type. Got `\(Placeholder.returned)` rather than `\(Placeholder.expected)`")
                }
                
                class Code: ConstantType {
                    static let message = Message(display: UIMessage(title: "Error", detail: "Could not match expected status code."), debug: "\(Placeholder.function) failure with result: `\(Placeholder.returned)`")
                }
            }
            static let zeroDataLength = Message(display: UIMessage(title: "Data error", detail: "Data length is zero"), debug: "Data length is zero")
        }
    }
}

extension Constant.API  {
    class Network: ConstantType {
        class Error: ConstantType {
            static let noInternetConnection = UIMessage(title: "Internet connection unavailable", detail: "You are not connected to the internet.\n\nPlease connect and try again.")
            static let offline = UIMessage(title: "Network offline", detail: "The network is currently offline.\n\nPlease check your connection and try again.")
        }
        
        public class Status {
            public static let online = "NetowrkOnline"
            public static let unknown = "NetowrkUnknown"
            static let offline = "NetowrkOffline"
        }
    }
}
