//
//  APIClientProtocol.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
    var options: APIOption { get }
    var defaultHeaders: HashableKeyDictionary { get }
    
    static func client(withURL url: String?) -> APIClientProtocol
    
    func setBaseURL(withString urlString: String)
    
    func get(dataFrom relativePath: String?, urlParams params: StringKeyDictionary?, options: APIOption?, returnAsData: Bool, callback: @escaping (Any?, Error?, HTTPURLResponse?) -> Void)
    
    func post(data json: GenericDictionary?, to relativePath: String?, options: APIOption?, returnAsData: Bool, callback: @escaping (Any?, Error?, HTTPURLResponse?) -> Void)
}
