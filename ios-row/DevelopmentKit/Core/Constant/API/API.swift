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

typealias ResponseErrorConstant = Constant.API.Response.Error
