import UIKit

protocol LoginWorkerLogic {
    func loginUser(email: String, password: String, completion: @escaping (String, Bool) -> ())
}

final class LoginScreenWorker: LoginWorkerLogic {
    
    func loginUser(email: String, password: String, completion: @escaping (String, Bool) -> ()) {
        FirebaseAuth.loginUser(withEmail: email, password: password) { result, error in
            error != nil ? completion(error?.localizedDescription ?? "", true) : completion(AuthValidationAndAlert.ValidationTitles.successfulLogin, false)
        }
    }
    
}
