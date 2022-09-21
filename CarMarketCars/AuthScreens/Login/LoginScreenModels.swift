import UIKit

enum LoginScreen {
    // MARK: - Use cases
    
    enum UserValidation {
        
        struct Request {
            let email: String?
            let password: String?
        }
        
        struct Response {
            let outcome: String
            let isError: Bool
        }
        
        struct ViewModel {
            let outcome: String
        }
        
    }
    
}

