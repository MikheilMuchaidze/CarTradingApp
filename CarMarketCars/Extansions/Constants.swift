import UIKit

enum FirebaseCollectionNames: String {
    case users
    case cars
}

enum ViewControllerName {
    static let starting = "StartingScreen"
    static let mainTabBar = "StartingTabBarController"
    static let login = "Login"
    static let register = "Register"
    static let main = "MainPage"
    static let newCar = "CarEdit_Upload_View"
    static let userDetails = "UserDetails"
}

enum StoryboardNames {
    static let main = "Main"
    static let starting = "Starting"
    static let login = "Login"
    static let register = "Register"
    static let mainPage = "MainPage"
    static let userDetails = "UserDetails"
    static let newCar = "CarEdit_Upload_View"
}

enum CellName {
    static let CarTableViewCell = "CarTableViewCell"
    static let UserDetailsTableViewCell = "UserDetailsTableViewCell"
}

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

extension NewCarUploadViewController {
    
    enum NewCarValidationTitles {
        static let imageUrlError = "Url Error"
        static let fieldsEmpty = "Field(s) empty."
        static let noImage = "No Image"
    }
    
    enum NewCarValidationMessages {
        static let imageUrlErrorMassage = "Incorrect or empty url in field, please input correct link"
        static let fieldsEmptyMassage = "All fields must be completed."
        static let noImageMassage = "Please add image of the car"
    }
    
    enum NewCarValidationOkTitles {
        static let okTitle = "Ok."
    }
}



