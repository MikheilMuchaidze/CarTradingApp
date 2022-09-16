import Firebase
import FirebaseFirestore
import FirebaseStorage

enum FirebaseDatabaseEdit {
    
    private static let imageStorage = Storage.storage().reference()
    private static let carsdb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
    
    //MARK: - Update car in firebase firestore

    static func updateCarInDB(car: [String : Any], uid: String, completion: ((Error?) -> Void)?) {
        carsdb.document(uid).updateData(car, completion: completion)
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
