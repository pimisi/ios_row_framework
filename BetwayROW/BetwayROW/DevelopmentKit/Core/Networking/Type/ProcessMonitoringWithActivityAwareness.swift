//
//  ProcessMonitoringWithActivityAwareness.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/29.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

protocol ProcessMonitoringWithActivityAwareness: ProcessMonitoring, NetworkActivityAware {}

extension ProcessMonitoringWithActivityAwareness {
    func processStarted() {
        if !isLoading {
            networkActivityStarted()
        }
        
        processing.set(loading: true)
    }
    
    func processCompleted() {
        processing.set(loading: false)
        
        if !isLoading && isComplete {
            networkActivityComplete()
        }
    }
}
