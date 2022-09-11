import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

//MARK: - Authentication service

enum AuthService {
    
    private static let db = Firestore.firestore()
    private static let carsdb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
    private static let usersdb = Firestore.firestore().collection(FirebaseCollectionNames.users.rawValue)
    private static var firestoreListener: ListenerRegistration?

    private static var currentUser: String {
        Auth.auth().currentUser?.email ?? ""
    }
    private static let userDocument = usersdb.document(currentUser)
    
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
        userDocument.setData(user.toDatabaseType())
    }
    

    //MARK: - Log out service
    
    static func logOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            //TODO: - No error handling?????
            print("eroooooor\(error.localizedDescription)")
        }
    }
    
    //MARK: - Current user info
    static func currentUserInfo(completion: ((User) -> Void)?) {
        firestoreListener?.remove()
        
        firestoreListener = userDocument.addSnapshotListener({ snapshot, error in
            guard let snapshot = snapshot?.data() else { return }
            
            let currentUser = User(with: snapshot)
            
            if let completion = completion {
                completion(currentUser)
            }
            
        })
    }
}
