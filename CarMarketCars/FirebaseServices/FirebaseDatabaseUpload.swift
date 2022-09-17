import Firebase
import FirebaseFirestore
import FirebaseStorage

enum FirebaseDatabaseUpload {
    
    private static let imageStorage = Storage.storage().reference()
    private static let carsdb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
    private static let usersdb = Firestore.firestore().collection(FirebaseCollectionNames.users.rawValue)
    
    //MARK: - Add user in firebase firestore
    
    static func registerUserInDB(with user: User) {
        usersdb.document(user.email).setData(user.toDatabaseType())
    }
    
    //MARK: - Add car in firebase firestore
    
    static func addCarInDB(car: [String : Any], uid: String, completion: ((Error?) -> Void)?) {
        carsdb.document(uid).setData(car, completion: completion)
    }
    
    //MARK: - Upload data to database
    
    static func uploadCarInfo(id: String, data: [String : Any]) {
        carsdb.document(id).setData(data)
    }
    
    //MARK: - Image upload to storage functions
    
    static func imageUploader(image: Data, uid: String, completion: ((StorageMetadata?, Error?) -> Void)?) {
        imageStorage.child("\(FirebaseImageStorageName.carImages)\(uid)").putData(image, completion: completion)
    }
    
}
