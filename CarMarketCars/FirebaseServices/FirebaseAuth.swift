import FirebaseAuth
import UIKit

enum FirebaseAuth {
    
    //MARK: - Login service
    
    static func loginUser(withEmail email: String, password: String, completion: @escaping ((AuthDataResult?, Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    //MARK: - Register service
    
    static func registerUser(withEmail email: String, password: String, completion: @escaping ((AuthDataResult?, Error?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    //MARK: - Log out service
    
    static func logOutUser(completion: (_ errorOccured: Bool, _ error: Error) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            completion(true, error)
        }
    }
    
}
