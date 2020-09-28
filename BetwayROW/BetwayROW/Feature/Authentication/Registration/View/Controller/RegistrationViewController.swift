//
//  RegistrationViewController.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/22.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    static let storyboardIdentifier = "RegistrationViewController"
    
    // MARK: - Referencing Outlets
    
    // MARK: Personal Details
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var dialCodeTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    
    // MARK: Address Details
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var nationalityTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    
    // MARK: AccountAccess
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var checkUsernameAvalabilityButton: Button!
    @IBOutlet weak var checkUsernameActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var togglePasswordSecurityButton: Button!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var togglePasswordConfirmSecurityButton: Button!
    @IBOutlet weak var usernameSuggectionsTableView: UITableView!
    
    // MARK: Welcom Offer
    
    @IBOutlet weak var offerRadioGroupButtonSport: UIButton!
    @IBOutlet weak var offerRadioGroupButtonCasino: UIButton!
    
    // MARK: Terms
    
    @IBOutlet weak var termsCheckButtonAge: UIButton!
    @IBOutlet weak var termsCheckButtonPolicy: UIButton!
    @IBOutlet weak var termsCheckButtonSubscription: UIButton!
    
    // MARK: Sign Up
    
    @IBOutlet weak var signUpButton: Button!
    
    lazy var selectorPickerView = UIPickerView(for: self)
    lazy var cityPickerView = UIPickerView(for: self)
    lazy var countryPickerView = UIPickerView(for: self)
    lazy var nationalityPickerView = UIPickerView(for: self)
    lazy var currencyPickerView = UIPickerView(for: self)
    
    // MARK: - Events
    
    @IBAction func closeViewTouched(_ sender: UIButton) {
        view.removeFromSuperview()
    }
    
    @IBAction func loginTouched(_ sender: UIButton) {
    }
    
    static let storyBoard = UIStoryboard(name: Constant.Storyboard.registration, bundle: Bundle(for: RegistrationViewController.self))
    static let instance: RegistrationViewController = storyBoard.instantiateViewController(identifier: storyboardIdentifier)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindDataToPickers() {
        bindNationalities()
        bindCountries()
        bindCurrencies()
    }
}

extension RegistrationViewController {
    private func bindNationalities() {
        
    }
    
    private func bindCountries() {
        
    }
    
    private func bindCurrencies() {
        
    }
}

extension RegistrationViewController: UIPickerViewDelegate {}

extension RegistrationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
}
