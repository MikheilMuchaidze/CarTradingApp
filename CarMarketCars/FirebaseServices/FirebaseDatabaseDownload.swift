import Firebase
import FirebaseFirestore
import FirebaseStorage

enum FirebaseDatabaseDownload {
    
    private static let imageStorage = Storage.storage().reference()
    private static let carsdb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
    private static let usersdb = Firestore.firestore().collection(FirebaseCollectionNames.users.rawValue)
    private static var firestoreListener: ListenerRegistration?
    private static var currentUser: String {
        Auth.auth().currentUser?.email ?? ""
    }
    private static let userDocument = usersdb.document(currentUser)
    
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

}
