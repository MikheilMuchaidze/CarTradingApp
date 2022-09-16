import UIKit

//MARK: - New car adding validations

extension NewCarUploadViewController {
    
    //validation of text fields
    func validateIfEmpty() -> Bool {
        if carMarkTxt.text!.isEmpty || carModelTxt.text!.isEmpty || carYearTxt.text!.isEmpty || carLocationTxt.text!.isEmpty || carPriceTxt.text!.isEmpty || carPhoneTxt.text!.isEmpty {
            alertPopUp(title: NewCarValidationTitles.fieldsEmpty, message: NewCarValidationMessages.fieldsEmptyMassage, okTitle: NewCarValidationOkTitles.okTitle)
            return false
        } else {
            return true
        }
    }
    
    //validate image form
    func validateIfImageIsEmpty() -> Bool {
        //validation that an user added image for the car
        if carImage.image == nil {
            alertPopUp(title: NewCarValidationTitles.noImage, message: NewCarValidationMessages.noImageMassage, okTitle: NewCarValidationOkTitles.okTitle)
            return false
        } else {
            return true
        }
    }
    
}

//MARK: - Login view auth validations

extension LoginScreenViewController {
    
    //validation of text fields
    func validateIfEmpty() -> Bool {
        if UserEmailTxt.text!.isEmpty || UserPasswordTxt.text!.isEmpty {
            alertPopUp(title: LoginValidationTitles.fieldsEmpty, message: LoginValidationMessages.fieldsEmptyMassage, okTitle: LoginValidationOkTitles.okTitle)
            return false
        } else {
            return true
        }
    }
    
    //validate email form
    func validateIfEmailCorrectForm(str: String) -> Bool {
        let emailRegEx = LoginEmailPredicates.emailRegEx

        if (!NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: str)) {
            alertPopUp(title: LoginValidationTitles.incorrectEmail, message: LoginValidationMessages.incorrectEmailMassage, okTitle: LoginValidationOkTitles.tryAgainTitle)
            return false
        } else {
            return true
        }
    }
    
}

//MARK: - Register view auth validations

extension RegisterScreenViewController {
    
    //validation of text fields
    func validateIfEmpty() -> Bool {
        if UserEmailTxt.text!.isEmpty || UserPasswordTxt.text!.isEmpty || UserRepeatPassTxt.text!.isEmpty {
            alertPopUp(title: RegisterValidationTitles.fieldsEmpty, message: RegisterValidationMessages.fieldsEmptyMassage, okTitle: RegisterValidationOkTitles.okTitle)
            return false
        } else {
            return true
        }
    }
    
    //password validation
    func validateIfPassword(str: String) -> Bool {
        
        if (!NSPredicate(format:"SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: str)) {
            alertPopUp(title: RegisterValidationTitles.incorrectPassword, message: RegisterValidationMessages.oneUppercaseErrorMassage, okTitle: RegisterValidationOkTitles.tryAgainTitle)
            return false
        }
        
        if (!NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: str)) {
            alertPopUp(title: RegisterValidationTitles.incorrectPassword, message: RegisterValidationMessages.oneDigitErrorMassage, okTitle: RegisterValidationOkTitles.tryAgainTitle)
            return false
        }
        
        if (!NSPredicate(format:"SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: str)) {
            alertPopUp(title: RegisterValidationTitles.incorrectPassword, message: RegisterValidationMessages.oneLowercaseErrorMassage, okTitle: RegisterValidationOkTitles.tryAgainTitle)
            return false
        }
        
        if (str.count < 8) {
            alertPopUp(title: RegisterValidationTitles.incorrectPassword, message: RegisterValidationMessages.minEightSymbolsErrorMassage, okTitle: RegisterValidationOkTitles.tryAgainTitle)
            return false
        }
        return true
        
    }
    
    //validate password and repeat password similarity
    func validateIfPasswordMatch() -> Bool {
        if UserPasswordTxt.text != UserRepeatPassTxt.text {
            alertPopUp(title: RegisterValidationTitles.passwordsNotMatch, message: RegisterValidationMessages.passwordsNotMatchMassage, okTitle: RegisterValidationOkTitles.okTitle)
            return false
        } else {
            return true
        }
    }
    
    //validate email form
    func validateIfEmailCorrectForm(str: String) -> Bool {
        let emailRegEx = RegisterEmailPredicates.emailRegEx

        if (!NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: str)) {
            alertPopUp(title: RegisterValidationTitles.incorrectEmail, message: RegisterValidationMessages.incorrectEmailMassage, okTitle: RegisterValidationOkTitles.tryAgainTitle)
            return false
        } else {
            return true
        }
    }
    
}
