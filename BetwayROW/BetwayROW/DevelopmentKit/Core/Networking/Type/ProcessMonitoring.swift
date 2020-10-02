//
//  ProcessMonitoring.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/15.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

protocol ProcessMonitoring: class {
    var processing: NetworkProcessing { get set }
    var loading: ((_ loading: Bool) -> Void)? { get set }
    var complete: ((_ complete: Bool) -> Void)? { get set }
}

extension ProcessMonitoring {

    func monitor() -> NetworkProcessing {
        let processing = NetworkProcessing()

        processing.updated = { [weak self] type in
            switch type {
            case .loading:
                self?.loading?(self?.isLoading ?? false)
            case .completion:
                self?.complete?(self?.isComplete ?? false)
            }
        }
        return processing
    }
    
    var isLoading: Bool {
        return processing.processes.reduce(into: false, { $0 = $0 || $1.loading })
    }
    
    var isComplete: Bool {
        return processing.processes.reduce(into: true, { $0 = $0 && $1.success })
    }
}
