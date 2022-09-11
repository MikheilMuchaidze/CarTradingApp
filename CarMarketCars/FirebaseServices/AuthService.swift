import UIKit
import Firebase
import FirebaseAuth

//MARK: - Authentication service

enum AuthServie {
    
    private static let db = Firestore.firestore()
    private static var currentUser: String {
        Auth.auth().currentUser?.email ?? ""
    }
    private static let document = db.collection(FirebaseCollectionNames.users.rawValue).document(currentUser)
    
    //MARK: - Login service
    
    static func loginUser(withEmail email: String, password: String, completion: @escaping ((AuthDataResult?, Error?) -> Void)) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    //MARK: - Register service
    
    static func registerUser(withEmail email: String, password: String, completion: @escaping ((AuthDataResult?, Error?) -> Void)) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
        
    }
    
    //MARK: - Register user in firebase firestore
    
    static func registerUserInDB(with user: User) {
        document.setData(user.toDatabaseType())
    }
    

    //MARK: - Log out service
    
    

    
    
    
    
    
}
