//
//  LoginViewModel.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/22.
//  Copyright © 2020 Betway. All rights reserved.
//

final class LoginViewModel: NetworkActivityAware {
    
    let client = LoginClient(withClient: APIClient.client(withURL: nil))
    
    func login(username: String, password: String) {
        networkActivityStarted()
        client.login(username: username, password: password) { [weak self] result in
            guard let self = self else { return }
            self.networkActivityComplete()
            switch result {
            case .success(payload: let data):
                Application.shared.set(userLoggedIn: true)
            case .failure(let failure):
                debugLog(String(describing: self), message: "Error Loging in: \(String(describing: failure?.description))")
                ErrorCoordinator.shared.error = failure
            }
        }
    }
    
}
