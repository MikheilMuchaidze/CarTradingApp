extension LoginScreenViewController {
    
    enum LoginEmailPredicates {
        static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    enum LoginValidationTitles {
        static let fieldsEmpty = "Field(s) empty."
        static let incorrectEmail = "Incorrect Email"
        static let authFailed = "Sign in failed"
    }
    
    enum LoginValidationMessages {
        static let fieldsEmptyMassage = "All fields must be completed."
        static let incorrectEmailMassage = "Incorrect email format..."
    }
    
    enum LoginValidationOkTitles {
        static let okTitle = "Ok."
        static let tryAgainTitle = "Try again."
    }
    
}
