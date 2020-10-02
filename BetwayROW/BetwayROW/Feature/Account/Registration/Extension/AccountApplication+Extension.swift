//
//  AccountApplication+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/10/01.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension Application.Validation {
    
    @objc func validate(firstName: String) -> Bool {
        let validFormat = "^[ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿŒœŠŽšžŸµƒªº¡¿A-Za-z\\s-`'']+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: firstName)
        
        return result
    }
    
    @objc func validate(surname: String) -> Bool {
        let validFormat = "^[ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿŒœŠŽšžŸµƒªº¡¿A-Za-z\\s-`'']+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: surname)
        
        return result
    }
    
    @objc func validate(email: String) -> Bool {
        let validFormat = "\\b[A-Za-z0-9._%+-]+@((?!\\.\\.)[A-Za-z0-9.-])+\\.[A-Za-z]{2,4}\\b$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: email)
        
        return result
    }
    
    @objc func validate(mobileNumber value: String) -> Bool {
        let mobileNumber = value.hasPrefix("0") ? String(value.dropFirst()) : value
        let validFormat = "^[+][\\d\\s]*$|^[\\d\\s]*$|^[0-9]+[-]{1}[0-9]*$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  phoneTest.evaluate(with: mobileNumber)
        
        return result
    }
    
    @objc func validate(currency: String) -> Bool {
        let validFormat = "^[A-Z]{3,3}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: currency)
        
        return result
    }
    
    @objc func validate(address: String) -> Bool {
        let validFormat = "^[\\w\\s-'-\\/-\\]*?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: address)
        
        return result
    }
    
    @objc func validate(countryCode: String) -> Bool {
        let validFormat = "^[A-Z]{3}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: countryCode)
        
        return result
    }
    
    @objc func validate(dialingCode: String) -> Bool {
        let validFormat = "^\\+[0-9]{1,3}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: dialingCode)
        
        return result
    }
    
    @objc func validate(username: String) -> Bool {
        let validFormat = "^\\+[0-9]{12,14}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: username)
        
        return result
    }
    
    @objc func validate(identificationNumber: String) -> Bool {
        let validFormat = "^[0-9]{12}[A-z]{1}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: identificationNumber)
        return result
    }
    
    @objc func validate(password: String) -> Bool {
        let validFormat = "^(?=.*[a-zA-Z].*)([A-Za-z_0-9`-~!@\\$%\\^\\*\\(\\)\\-\\=_\\+\\[\\]\\{\\}:;\",\\.\\/\\\\|]{8,20})+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: password)
        
        return result
    }
    
    @objc func validate(signUpCode: String) -> Bool {
        let validFormat = "^[A-z0-9]{1,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: signUpCode)
        
        return result
    }
    
    @objc func validate(referralCode: String) -> Bool {
        let validFormat = "^[A-z0-9]{1,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: referralCode)
        
        return result
    }
    
    @objc func validate(sessionToken: String) -> Bool {
        let validFormat = "(^([0-9A-Fa-f]{8}[-][0-9A-Fa-f]{4}[-][0-9A-Fa-f]{4}[-][0-9A-Fa-f]{4}[-][0-9A-Fa-f]{12})$)"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: sessionToken)
        
        return result
    }
    
    @objc func validate(masterToken: String) -> Bool {
        let validFormat = "(^([0-9A-Fa-f]{8}[-][0-9A-Fa-f]{4}[-][0-9A-Fa-f]{4}[-][0-9A-Fa-f]{4}[-][0-9A-Fa-f]{12})$)"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: masterToken)
        
        return result
    }
    
    @objc func validate(city: String) -> Bool {
        let validFormat = "^[^\\s.\\-\'][0-9ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿŒœŠŽšžŸµA-Za-z.\\-\'\\s-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: city)
        
        return result
    }
    
    @objc func validate(code: String) -> Bool {
        let validFormat = "^[^\\s\\W][0-9A-Za-z\\-\'\\s-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: code)
        
        return result
    }
    
    @objc func validate(state: String) -> Bool {
        let validFormat = "^[^\\s.\\-\'][0-9ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿŒœŠŽšžŸµA-Za-z.\\-\'\\s-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: state)
        
        return result
    }
    
    @objc func validate(country: String) -> Bool {
        let validFormat = "^[^\\s.\\-\'][0-9ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿŒœŠŽšžŸµA-Za-z.\\-\'\\s-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", validFormat)
        let result =  predicate.evaluate(with: country)
        
        return result
    }
}
