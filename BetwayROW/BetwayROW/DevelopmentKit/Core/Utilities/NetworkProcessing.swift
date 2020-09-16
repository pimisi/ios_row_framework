//
//  NetworkProcessing.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/15.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

class NetworkProcessing {
    
    enum ProcessType {
        case loading, completion
    }
    
    var processes: [NetworkProcess] = []
    
    var updated: ((ProcessType) -> Void)?
    
    func set(loading: Bool, for process: String = #function) {
        if let index = processes.firstIndex(where: { $0.identifier == process }) {
            processes[index].loading = loading
        } else {
            processes.append(NetworkProcess(identifier: process, loading: loading))
        }
        updated?(.loading)
    }
    
    func set(success: Bool, for process: String = #function) {
        if let index = processes.firstIndex(where: { $0.identifier == process }) {
            processes[index].success = success
        } else {
            processes.append(NetworkProcess(identifier: process, success: success))
        }
        
        updated?(.completion)
    }
}
