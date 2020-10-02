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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    @IBOutlet weak var otherIDView: UIView!
    @IBOutlet weak var identificationTypeTextField: UITextField!
    @IBOutlet weak var identificationNumberTextField: UITextField!
    @IBOutlet weak var dayOfIssueTextField: UITextField!
    @IBOutlet weak var monthOfIssueTextField: UITextField!
    @IBOutlet weak var yearOfIssueTextField: UITextField!
    
    // MARK: AccountAccess
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var checkUsernameAvalabilityButton: Button!
    @IBOutlet weak var checkUsernameActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var togglePasswordSecurityButton: Button!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var togglePasswordConfirmSecurityButton: Button!
    @IBOutlet weak var usernameSuggestionsTableView: UITableView!
    
    @IBOutlet weak var usernameSuggestionTableViewHeightConstraint: NSLayoutConstraint!
    // MARK: Welcom Offer
    
    @IBOutlet weak var offerRadioGroupButtonSport: UIButton!
    @IBOutlet weak var offerRadioGroupButtonCasino: UIButton!
    
    // MARK: Terms
    
    @IBOutlet weak var termsAgeCheckboxButton: UIButton!
    @IBOutlet weak var             termsPolicyCheckButton: UIButton!
    @IBOutlet weak var termsCheckButtonSubscription: UIButton!
    
    // MARK: Sign Up
    
    @IBOutlet weak var signUpButton: Button!
    
    static let storyBoard = UIStoryboard(name: Constant.Storyboard.registration, bundle: Bundle(for: RegistrationViewController.self))
    static let instance: RegistrationViewController = storyBoard.instantiateViewController(identifier: storyboardIdentifier)
    
    let viewModel = RegistrationViewModel()
    let identificationTypeSelection = Constant.Component.identificationList
    let usernameSuggestionsTableViewCellIdentifier = "suggestionsCellIdentifier"
    
    lazy var identificationTypePickerView = UIPickerView(for: self)
    lazy var cityPickerView = UIPickerView(for: self)
    lazy var countryPickerView = UIPickerView(for: self)
    lazy var nationalityPickerView = UIPickerView(for: self)
    lazy var currencyPickerView = UIPickerView(for: self)
    
    lazy var fields: [UITextField] = [
        firstNameTextField,
        surnameTextField,
        emailAddressTextField,
        mobileNumberTextField,
        dayTextField,
        dayOfIssueTextField,
        identificationTypeTextField,
        identificationNumberTextField,
        currencyTextField,
        addressTextField,
        cityTextField,
        countryTextField,
        postalCodeTextField,
        nationalityTextField,
        passwordTextField,
        passwordConfirmTextField
    ]
    
    lazy var fieldsWithException: [UITextField: [String: String]] = [
        identificationNumberTextField: [Selection.nationalityCode: "BGR"],
        identificationTypeTextField: [Selection.nationalityCode: "BGR"],
        dayOfIssueTextField: [Selection.nationalityCode: "BGR"]
    ]
    
    var usernameValidation: UsernameValidation?
    var nationalityList: Nationalities?
    var countryList: Countries?
    var currencyList: Currencies?
    
    var formIsValid = false
    
    struct Selection {
        static var genderIsMale = true
        static var gender = "Male"
        static var isDateIssued = false
        static var nationalityCode = ""
        static var country = 1
        static var usernameIsValid = false
        static var offerSelected = "Sport"
        static var offerSportSelection = true
        static var isOfAge = false
        static var termsAccepted = false
        static var subscribe = false
        static var errorsInFields = false
    }
    
    private enum ToolBarItem {
        case identificationType, nationality, country, currency, mobileNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        bindDataToPickers()
        attachPickerViewToParent()
        configureTableView()
        configureElementColors()
        setupKeyboardNotification()
    }
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func adjustForKeyboard(notification: Notification){
        Application.shared.keyboard.adjust(for: notification, scrollView: scrollView, view: view)
    }
    
    // MARK: - Events
    
    // MARK: UITextField Editing
    
    @IBAction func firstNameTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate(with: #selector(Application.shared.validation.validate(firstName:)))
    }
    
    @IBAction func surnameTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate(with: #selector(Application.shared.validation.validate(surname:)))
    }
    
    @IBAction func emailAddressTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate(with: #selector(Application.shared.validation.validate(email:)))
    }
    
    @IBAction func mobileTextFieldNumberEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate(with: #selector(Application.shared.validation.validate(mobileNumber:)), argument: (dialCodeTextField.text ?? "") + (mobileNumberTextField.text ?? ""))
    }
    
    @IBAction func currencyTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate(with: #selector(Application.shared.validation.validate(currency:)))
    }
    
    @IBAction func addressTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate()
    }
    
    @IBAction func cityTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = sender.validate()
    }
    
    @IBAction func countryTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate()
    }
    
    @IBAction func postalCodeTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate()
    }
    
    @IBAction func nationalityTextFieldEditingDidEnd(_ sender: UITextField) {
        // Selection.errorsInFields = sender.validate(with: #selector(Application.shared.validation.validate(firstName:)))
    }
    
    @IBAction func pinTextFieldEditingDidEnd(_ sender: UITextField) {
        // Selection.errorsInFields = sender.validate(with: #selector(Application.shared.validation.validate(firstName:)))
    }
    
    @IBAction func identificationTypeTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate()
    }
    
    @IBAction func identificationNumberTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = !sender.validate()
    }
    
    @IBAction func usernameTextFieldEditingDidEnd(_ sender: UITextField) {
        let isValid = sender.validate()
        Selection.errorsInFields = !isValid
        
        if isValid {
            validateUsername()
        }
        Selection.errorsInFields = !sender.validate(with: #selector(Application.shared.validation.validate(firstName:)))
    }
    
    @IBAction func passwordTextFieldEditingDidEnd(_ sender: UITextField) {
        Selection.errorsInFields = sender.validate()
    }
    
    @IBAction func passwordConfirmTextFieldEditingDidEnd(_ sender: UITextField) {
        let isValid = sender.validate()
        Selection.errorsInFields = !isValid
        
        if isValid {
            if passwordConfirmTextField.text == passwordTextField.text {
                Selection.errorsInFields = false
            } else {
                passwordConfirmTextField.bordered(width: 2, color: Colour.error)
                Selection.errorsInFields = true
                presentErrorAlert(message: "Passwords do not match")
                passwordConfirmTextField.becomeFirstResponder()
            }
        }
    }
    
    // MARK: Button Touches
    
    @IBAction func closeViewTouched(_ sender: UIButton) {
        view.removeFromSuperview()
    }
    
    @IBAction func loginTouched(_ sender: UIButton) {
    }
    
    @IBAction func dayIssued(_ sender: UIButton) {
    }
    
    @IBAction func monthIssued(_ sender: UIButton) {
    }
    
    @IBAction func yearIssued(_ sender: UIButton) {
    }
    
    @IBAction func signUp(_ sender: Button) {
        view.endEditing(true)
        validateForm()
    }
    
    private func presentErrorAlert(title: String? = nil, message: String?) {
        ErrorCoordinator.shared.error = Failure(error: nil, title: title ?? "Error", message: message, responseStatusCode: nil)
    }
}

extension RegistrationViewController {
    
    private func bindDataToPickers() {
        bindNationalities()
        bindCountries()
        bindCurrencies()
    }
    
    private func attachPickerViewToParent() {
        identificationTypeTextField.inputAccessoryView = setToolbar(type: .identificationType)
        identificationTypeTextField.inputView = identificationTypePickerView
        
        nationalityTextField.inputAccessoryView = setToolbar(type: .nationality)
        nationalityTextField.inputView = nationalityPickerView
        
        countryTextField.inputAccessoryView = setToolbar(type: .country)
        countryTextField.inputView = countryPickerView
        
        currencyTextField.inputAccessoryView = setToolbar(type: .currency)
        currencyTextField.inputView = currencyPickerView
        
        mobileNumberTextField.inputAccessoryView = setToolbar(type: .mobileNumber)
    }
    
    private func configureTableView() {
        usernameSuggestionsTableView.delegate = self
        usernameSuggestionsTableView.dataSource = self
    }
    
    private func configureElementColors() {
        loginButton.setTitleColor(Colour.primary, for: .normal)
        signUpButton.backgroundColor = Colour.primary
        checkUsernameActivityIndicator.color = Colour.primary
        checkUsernameAvalabilityButton.tintColor = Colour.primary
    }
    
    private func setToolbar(type: ToolBarItem?) -> UIToolbar{
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colour.white
        toolBar.sizeToFit()
        
        var doneButtonTitle = "Done"
        var doneButtonSelector: Selector
        
        switch type {
        case .identificationType:
            doneButtonSelector = #selector(identificationTypeDone)
        case .nationality:
            doneButtonSelector = #selector(nationalityDone)
        case .currency:
            doneButtonSelector = #selector(currencyDone)
        case .country:
            doneButtonSelector = #selector(countryDone)
        case .mobileNumber:
            doneButtonTitle = "Next"
            doneButtonSelector = #selector(mobileNumberDone)
        default:
            doneButtonSelector = #selector(cancel)
        }
        
        let doneButton = UIBarButtonItem(title: doneButtonTitle, style: .plain, target: self, action: doneButtonSelector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc func cancel() {
        view.endEditing(true)
    }
    
    @objc func identificationTypeDone() {
        if identificationTypeTextField.text?.isEmpty == true {
            identificationTypeTextField.text = identificationTypeSelection[0]
        }
        
        identificationTypeTextField.resignFirstResponder()
        identificationNumberTextField.becomeFirstResponder()
    }
    
    @objc func nationalityDone() {
        if nationalityTextField.text?.isEmpty == true {
            nationalityTextField.text = nationalityList?[0].name
        }
        
        nationalityTextField.resignFirstResponder()
        pinTextField.becomeFirstResponder()
    }
    
    @objc func countryDone() {
        if countryTextField.text?.isEmpty == true {
            countryTextField.text = countryList?[0].name
        }
        
        countryTextField.resignFirstResponder()
        postalCodeTextField.becomeFirstResponder()
    }
    
    @objc func currencyDone() {
        if currencyTextField.text?.isEmpty == true{
            currencyTextField.text = currencyList?[0].currencyCode
        }
        
        currencyTextField.resignFirstResponder()
        addressTextField.becomeFirstResponder()
    }
    
    @objc func mobileNumberDone() {
        mobileNumberTextField.resignFirstResponder()
    }
}

extension RegistrationViewController {
    
    fileprivate enum FieldErrorType {
        case required, limitUnsatisfied
    }
    
    enum ValidationState: Equatable {
        case valid
        case invalid(String)
    }
    
    private func validateForm() {
        formIsValid = validateFormFields() == .valid
        
        guard formIsValid else {
            presentErrorAlert(message: "Please make sure all fields are completed.")
            return
        }
        
        completeSignUp()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if usernameValidation?.suggestions?.count ?? 0 > 0 {
            usernameSuggestionTableViewHeightConstraint.constant = Layout.Size.size40 * CGFloat((usernameValidation?.suggestions?.count ?? 0))
            passwordTextField.resignFirstResponder()
            usernameTextField.bordered(width: 2, color: Colour.error)
            usernameTextField.borderWidth = 2
            
            formIsValid = true
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        } else {
            usernameSuggestionTableViewHeightConstraint.constant = 0
            // usernameSuggestionTableViewHeightConstraint.constant = CGFloat(0)
        }
    }
    
    private func validateUsername() {
        
        checkUsernameAvalabilityButton.isHidden = true
        checkUsernameActivityIndicator.startAnimating()
        
        viewModel.validateUsername(usernameTextField.text, completion: { [weak self] validation in
            Application.shared.updateUI {
                self?.checkUsernameActivityIndicator.stopAnimating()
                
                if let validation = validation {
                    self?.usernameSuggestionTableViewHeightConstraint.constant = 0
                    self?.usernameValidation = validation
                    
                    if validation.exists == true || validation.suggestions?.count ?? 0 > 0 {
                        self?.usernameSuggestionsTableView.reloadData()
                        self?.updateViewConstraints()
                        
                        self?.checkUsernameAvalabilityButton.isHidden = true
                        Selection.usernameIsValid = false
                    } else {
                        self?.checkUsernameAvalabilityButton.isHidden = false
                        Selection.usernameIsValid = true
                    }
                }
            }
        })
    }
    
    private func validateFormFields() -> ValidationState {
        
        let emptyFields = fields.filter { fieldsWithException.keys.contains($0) ? fieldsWithException[$0]?.keys.first != fieldsWithException[$0]?.values.first && $0.isEmpty : $0.isEmpty
        }
        
        emptyFields.forEach {
            $0.bordered(width: 2.0, color: Colour.error)
            
            switch $0 {
            case dayTextField:
                monthTextField.bordered(width: 2.0, color: Colour.error)
                yearTextField.bordered(width: 2.0, color: Colour.error)
            case dayOfIssueTextField:
                monthOfIssueTextField.bordered(width: 2.0, color: Colour.error)
                yearOfIssueTextField.bordered(width: 2.0, color: Colour.error)
            case nationalityTextField:
                pinTextField.bordered(width: 2.0, color: Colour.error)
            default: break
            }
        }
        
        if !Selection.usernameIsValid {
            usernameTextField.bordered(width: 2.0, color: Colour.error)
        }
        
        if !Selection.isOfAge {
            termsAgeCheckboxButton.bordered(width: 2.0, color: Colour.error)
        }
        
        if !Selection.termsAccepted {
            termsPolicyCheckButton.bordered(width: 2.0, color: Colour.error)
        }
        
        if emptyFields.count > 1 || Selection.nationalityCode == "BGR" && pinTextField.isEmpty || !Selection.isOfAge || !Selection.termsAccepted  {
            return .invalid("Please make sure all fields are completed.")
        } else if Selection.nationalityCode == "BGR" && pinTextField.isEmpty {
            return .invalid("Please make sure all fields are completed.")
        }
        
        return .valid
    }
    
    private func completeSignUp() {
    }
}

extension RegistrationViewController {
    func bindViewModel() {
        viewModel.loading = { _ in /* configure if needed */ }
        viewModel.complete = { _ in /* configure if needed */ }
    }
    
    private func bindNationalities() {
        viewModel.getNationalities { [weak self] nationalities in
            Application.shared.updateUI { self?.nationalityList = nationalities }
        }
    }
    
    private func bindCountries() {
        viewModel.getCountries { [weak self] countries in
            Application.shared.updateUI { self?.countryList = countries }
        }
    }
    
    private func bindCurrencies() {
        viewModel.getCurrencies { [weak self] currencies in
            Application.shared.updateUI { self?.currencyList = currencies }
        }
    }
}

extension RegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernameValidation?.suggestions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: usernameSuggestionsTableViewCellIdentifier, for: indexPath)
        
        guard let cell = tableViewCell as? SuggestionTableViewCell else {
            return tableViewCell
        }
        
        cell.suggestionLabel.text = "     \(usernameValidation?.suggestions?[indexPath.row] ?? "---")"
        
        return cell
    }
}

extension RegistrationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        usernameTextField.text = usernameValidation?.suggestions?[indexPath.row] ?? ""
        usernameTextField.bordered(width: 1.0, color: Colour.Grey.light)
        usernameSuggestionTableViewHeightConstraint.constant = 0
        Selection.usernameIsValid = true
        checkUsernameAvalabilityButton.isHidden = false
        
        super.updateViewConstraints()
    }
}

extension RegistrationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case nationalityPickerView: return nationalityList?.count ?? 0
        case countryPickerView: return countryList?.count ?? 0
        case currencyPickerView: return currencyList?.count ?? 0
        case identificationTypePickerView: return identificationTypeSelection.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case nationalityPickerView: return nationalityList?[row].name
        case countryPickerView: return countryList?[row].name
        case currencyPickerView: return currencyList?[row].currencyCode
        case identificationTypePickerView: return identificationTypeSelection[row]
        default: return nil
        }
    }
}

extension RegistrationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case nationalityPickerView:
            nationalityTextField.text = nationalityList?[row].name
            Selection.nationalityCode = nationalityList?[row].code ?? ""
        case currencyPickerView:
            currencyTextField.text = currencyList?[row].currencyCode
        case countryPickerView:
            if row != Selection.country {
                Selection.country = row
                cityTextField.clear()
            }
            countryTextField.text = countryList?[row].name
        case identificationTypePickerView:
            identificationTypeTextField.text = identificationTypeSelection[row]
        default: break
        }
    }
}
