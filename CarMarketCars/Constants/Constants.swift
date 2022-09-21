//MARK: - validation popup messages constants

enum AuthValidationAndAlert {
    
    //main popup model
    struct AlertPopupModel {
        let title: String
        let message: String
        let okTitle: String
    }
    
    enum ValidationTitles {
        static let fieldsEmpty = "Field(s) empty."
        static let incorrectEmail = "Incorrect Email"
        static let signInFailed = "Sign in failed"
        static let incorrectPassword = "Incorrect Password"
        static let passwordsNotMatch = "Passwords do not match."
        static let registerFailed = "Registration failed"
        static let registerFailedInDatabase = "Registration failed"
        static let successfulRegistration = "Congratulations"
        static let successfulLogin = "Congratulations, you logged in!"
        static let imageUrlError = "Url Error"
        static let noImage = "No Image"
        static let loggedOutFail = "Fail to log out"
        static let fetchingCarsError = "Fetching car error"
        static let fetchingImageError = "Fetching image error"
        static let fetchingCarsByEmailError = "Fetching error (Email)"
        static let addCarTodatabase = "Faled to add car"
        static let addImageToStorage = "Image uploading error"
        static let updateCarTodatabase = "Faled to update car"
        static let carRemoveFromDatabaseFail = "Faled to remove car"
        static let carRemoveFromDatabaseSuccess = "Success!"
        static let imageRemoveFromDatabaseFail = "Faled to image"
    }
    
    enum ValidationMassages {
        static let fieldsEmptyMassage = "All fields must be completed."
        static let incorrectEmailMassage = "Incorrect email format..."
        static let oneUppercaseErrorMassage = "Least one uppercase"
        static let oneDigitErrorMassage = "Least one digit"
        static let oneLowercaseErrorMassage = "Least one lowercase"
        static let minEightSymbolsErrorMassage = "Minimum 8 characters total"
        static let passwordsNotMatchMassage = "Password must be a match! Try again."
        static let successfulRegistrationMassage = "Your user created!"
        static let imageUrlErrorMassage = "Incorrect or empty url in field, please input correct link"
        static let noImageMassage = "Please add image of the car"
        static let carRemoveFromDatabaseSuccessMassage = "Succesfuly removed car from list"
    }
    
    enum ValidationOkTitles {
        static let ok = "Ok."
        static let tryAgain = "Try again."
        static let logInAfterRegister = "Log In"
    }
    
    enum AuthEmailPredicate {
        static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    enum AuthPasswordPredicate {
        static let passwordUppercase = ".*[A-Z]+.*"
        static let passwordDigit = ".*[0-9]+.*"
        static let passwordLowercase = ".*[a-z]+.*"
        static let passwordLength = 8
    }

}

//MARK: - Predefined error types for using from all types

enum PredefinedAlerMessages {
    
    //emty field error
    static let ifEmptyError = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.fieldsEmpty, message: AuthValidationAndAlert.ValidationMassages.fieldsEmptyMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
    
    //incorrect email error
    static let incorrectEmailError = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.incorrectEmail, message: AuthValidationAndAlert.ValidationMassages.incorrectEmailMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
    
    //password mismatch error
    static let ifPasswrdMatch = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.passwordsNotMatch, message: AuthValidationAndAlert.ValidationMassages.passwordsNotMatchMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
    
    //incorrect password length
    static let incorrectPasswordLength = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.incorrectPassword, message: AuthValidationAndAlert.ValidationMassages.minEightSymbolsErrorMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
    
    //incorrect password least one digit
    static let incorrectPasswordOneDigit = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.incorrectPassword, message: AuthValidationAndAlert.ValidationMassages.oneDigitErrorMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
    
    //incorrect password least one uppercase
    static let incorrectPasswordOneUppercase = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.incorrectPassword, message: AuthValidationAndAlert.ValidationMassages.oneUppercaseErrorMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
    
    //incorrect password least one lowercase
    static let incorrectPasswordOneLowercase = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.incorrectPassword, message: AuthValidationAndAlert.ValidationMassages.oneLowercaseErrorMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
    
    //password do not match
    static let passwordMismatch = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.passwordsNotMatch, message: AuthValidationAndAlert.ValidationMassages.passwordsNotMatchMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
    
    //succesfull registration
    static let registerSuccess = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.successfulRegistration, message: AuthValidationAndAlert.ValidationMassages.successfulRegistrationMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.logInAfterRegister)
    
    //image url error
    static let imageUrlError = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.imageUrlError, message: AuthValidationAndAlert.ValidationMassages.imageUrlErrorMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
    
    //no image error
    static let noImageError = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.noImage, message: AuthValidationAndAlert.ValidationMassages.noImageMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
    
    //succesful remove of car from database
    static let carRemoveFromDbSucces = AuthValidationAndAlert.AlertPopupModel(title: AuthValidationAndAlert.ValidationTitles.carRemoveFromDatabaseSuccess, message: AuthValidationAndAlert.ValidationMassages.carRemoveFromDatabaseSuccessMassage, okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
    
}
