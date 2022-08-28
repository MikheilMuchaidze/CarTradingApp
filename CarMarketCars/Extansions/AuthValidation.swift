import Foundation
import UIKit
import FirebaseAuth

//car adding validation functions
extension NewCarUploadViewController {
    
    //validation of text fields
    func validateIfEmpty() -> Bool {
        if carMarkTxt.text!.isEmpty || carModelTxt.text!.isEmpty || carYearTxt.text!.isEmpty || carLocationTxt.text!.isEmpty || carPriceTxt.text!.isEmpty {
            alertPopUp(title: "Field(s) empty.", message: "All fields must be completed.", okTitle: "Ok.")
            return false
        } else {
            return true
        }
    }
    
    //validate image form
    func validateIfImageIsEmpty() -> Bool {
        
        //validation that an user added image for the car
        if carImage.image == nil {
            alertPopUp(title: "No Image", message: "Please add image of the car", okTitle: "Ok.")
            return false
        } else {
            return true
        }
    }
    
}

//login validation functions
extension LoginScreenViewController {
    
    //validation of text fields
    func validateIfEmpty() -> Bool {
        if UserEmailTxt.text!.isEmpty || UserPasswordTxt.text!.isEmpty {
            alertPopUp(title: "Field(s) empty.", message: "All fields must be completed.", okTitle: "Ok.")
            return false
        } else {
            return true
        }
    }
    
    //validate email form
    func validateIfEmailCorrectForm(str: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        if (!NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: str)) {
            let error = "Incorrect email format..."
            alertPopUp(title: "Incorrect Email", message: error, okTitle: "Try again.")
            return false
        } else {
            return true
        }
    }
    
}


//registration validation functions
extension RegisterScreenViewController {
    
    //validation of text fields
    func validateIfEmpty() -> Bool {
        if UserEmailTxt.text!.isEmpty || UserPasswordTxt.text!.isEmpty || UserRepeatPassTxt.text!.isEmpty {
            alertPopUp(title: "Field(s) empty.", message: "All fields must be completed.", okTitle: "Ok.")
            return false
        } else {
            return true
        }
    }
    
    //password validation
    func validateIfPassword(str: String) -> Bool {
        
        if (!NSPredicate(format:"SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: str)) {
            let error = "least one uppercase"
            alertPopUp(title: "Incorrect password", message: error, okTitle: "Try again.")
            return false
        }
        
        if (!NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: str)) {
            let error = "least one digit"
            alertPopUp(title: "Incorrect password", message: error, okTitle: "Try again.")
            return false
        }
        
        if (!NSPredicate(format:"SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: str)) {
            let error = "least one lowercase"
            alertPopUp(title: "Incorrect password", message: error, okTitle: "Try again.")
            return false
        }
        
        if (str.count < 8) {
            let error = "min 8 characters total"
            alertPopUp(title: "Incorrect password", message: error, okTitle: "Try again.")
            return false
        }
        
        return true
    }
    
    //validate password and repeat password similarity
    func validateIfPasswordMatch() -> Bool {
        if UserPasswordTxt.text != UserRepeatPassTxt.text {
            alertPopUp(title: "Passwords not match.", message: "Passwrods must be a match! Try again.", okTitle: "Ok")
            return false
        } else {
            return true
        }
    }
    
    //validate email form
    func validateIfEmailCorrectForm(str: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        if (!NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: str)) {
            let error = "Incorrect email format..."
            alertPopUp(title: "Incorrect Email", message: error, okTitle: "Try again.")
            return false
        } else {
            return true
        }
    }
    
}
