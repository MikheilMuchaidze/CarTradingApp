import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

//MARK: - Authentication service

enum FirebaseService {
    
    private static let db = Firestore.firestore()
    private static let imageStorage = Storage.storage().reference()
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
    
    //MARK: - Add user in firebase firestore
    
    static func registerUserInDB(with user: User) {
        userDocument.setData(user.toDatabaseType())
    }
    
    //MARK: - Add car in firebase firestore
    
    static func addCarInDB(car: [String : Any], uid: String, completion: ((Error?) -> Void)?) {
        carsdb.document(uid).setData(car, completion: completion)
    }
    
    //MARK: - Update car in firebase firestore
    
    static func updateCarInDB(car: [String : Any], uid: String, completion: ((Error?) -> Void)?) {
        carsdb.document(uid).updateData(car, completion: completion)
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
    
    //MARK: - Fetch from database all selleble cars
    
    static func fetchCars(completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        carsdb.whereField(CarFields.sellable, isEqualTo: true).addSnapshotListener(completion)
    }
    
    //MARK: - Fetch from database by current email
    
    static func fetchCarsByEmail(email: String ,completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        carsdb.whereField(CarFields.email, isEqualTo: email).addSnapshotListener(completion)
    }
    
    //MARK: - load image from storage with parameter
    
    static func loadImage(image: String ,completion: @escaping (URL?, Error?) -> Void) {
        imageStorage.child("carImages/\(image)").downloadURL(completion: completion)
    }
    
    //MARK: - Upload data to database
    
    static func uploadCarInfo(id: String, data: [String : Any]) {
        carsdb.document(id).setData(data)
    }

    
    //MARK: - Image upload to storage functions
    
    static func imageUploader(image: Data, uid: String, completion: ((StorageMetadata?, Error?) -> Void)?) {
        imageStorage.child("carImages/\(uid)").putData(image, completion: completion)
    }
    
    //MARK: - delete image from firestore
    
    static func imageRemoverFromDb(image: String, completion: ((Error?) -> Void)?) {
        imageStorage.child("carImages/\(image)").delete(completion: completion)
    }
    
    //MARK: - delete car from firestore
    
    static func carRemoverFromDb(car: String, completion: ((Error?) -> Void)?) {
        carsdb.document(car).delete(completion: completion)
    }
    
    
    
}
