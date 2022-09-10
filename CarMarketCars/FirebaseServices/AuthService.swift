import UIKit
import Firebase
import FirebaseAuth

//MARK: - Authentication service

enum AuthServie {
    
    //MARK: - Login service
    
    static func loginUser(withEmail email: String, password: String, completion: @escaping ((AuthDataResult?, Error?) -> Void)) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    //MARK: - Register service
    
    static func registerUser(withEmail email: String, password: String, completion: @escaping ((AuthDataResult?, Error?) -> Void)) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
        
    }

    
    //MARK: - Log out service
    
    

    
    
    
    
    
}
