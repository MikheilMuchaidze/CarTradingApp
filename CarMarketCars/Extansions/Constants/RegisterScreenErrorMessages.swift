extension RegisterScreenViewController {
    
    enum RegisterEmailPredicates {
        static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    enum RegisterValidationTitles {
        static let fieldsEmpty = "Field(s) empty."
        static let incorrectPassword = "Incorrect Password"
        static let incorrectEmail = "Incorrect Email"
        static let passwordsNotMatch = "Passwords do not match."
        static let failedRegistration = "Registration failed"
        static let failedDatabaseRegistration = "Registration failed"
        static let successfulRegistration = "Congratulations"
    }
    
    enum RegisterValidationMessages {
        static let fieldsEmptyMassage = "All fields must be completed."
        static let oneUppercaseErrorMassage = "Least one uppercase"
        static let oneDigitErrorMassage = "Least one digit"
        static let oneLowercaseErrorMassage = "Least one lowercase"
        static let minEightSymbolsErrorMassage = "Minimum 8 characters total"
        static let passwordsNotMatchMassage = "Password must be a match! Try again."
        static let incorrectEmailMassage = "Incorrect email format..."
        static let successfulRegistrationMassage = "Your user created!"
    }
    
    enum RegisterValidationOkTitles {
        static let okTitle = "Ok."
        static let tryAgainTitle = "Try again."
        static let logInAfterRegistratoin = "Log In"
    }
    
}
