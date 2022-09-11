import UIKit

enum FirebaseCollectionNames: String {
    case users
    case cars
}

enum StoryboardName {
    static let starting = "StartingScreen"
    static let mainTabBar = "StartingTabBarController"
    static let login = "LoginScreenViewController"
    static let register = "RegisterScreenViewController"
    static let main = "MainCarsListViewController"
    static let newCar = "NewCarUploadViewController"
    static let userDetails = "UserDetailsViewController"
}

enum CellName {
    static let CarTableViewCell = "CarTableViewCell"
    static let UserDetailsTableViewCell = "UserDetailsTableViewCell"
}

extension LoginScreenViewController {
    
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

extension RegisterScreenViewController {
    
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

extension NewCarUploadViewController {
    
    enum NewCarValidationTitles {
        static let imageUrlError = "Url Error"
    }
    
    enum NewCarValidationMessages {
        static let imageUrlErrorMassage = "Incorrect or empty url in field, please input correct link"
    }
    
    enum NewCarValidationOkTitles {
        static let okTitle = "Ok."
    }
}



