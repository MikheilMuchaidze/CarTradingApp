import UIKit

//MARK: - User struct fields

enum UserFields {
    static let name = "Name"
    static let surname = "Surname"
    static let password = "Password"
    static let email = "Email"
    static let uid = "Uid"
}

//MARK: - User struct fields for failed fetching data from firebase

fileprivate enum UserFieldsFailedFetch {
    static let name = "No name"
    static let surname = "No surname"
    static let password = "No password"
    static let email = "No email"
    static let uid = "No uid"
}

//MARK: - Struct for adding/updating user function to database with specific init and funcion

struct User {
    let name: String
    let surname: String
    let password: String
    let email: String
    let uid: String
    
    init(name: String, surname: String, password: String, email: String, uid: String) {
        self.name = name
        self.surname = surname
        self.password = password
        self.email = email
        self.uid = uid
    }
    
    //MARK: - Init for download from firebase
    
    init(with dictionary: Dictionary<String, Any>) {
        self.name = dictionary[UserFields.name] as? String ?? UserFieldsFailedFetch.name
        self.surname = dictionary[UserFields.surname] as? String ?? UserFieldsFailedFetch.surname
        self.password = dictionary[UserFields.password] as? String ?? UserFieldsFailedFetch.password
        self.email = dictionary[UserFields.email] as? String ?? UserFieldsFailedFetch.email
        self.uid = dictionary[UserFields.uid] as? String ?? UserFieldsFailedFetch.uid
    }
    
    //MARK: - Convert User to database type for upload
    
    func toDatabaseType() -> [String : Any] {
        [
            UserFields.name: name,
            UserFields.surname: surname,
            UserFields.password: password,
            UserFields.email: email,
            UserFields.uid: uid
        ]
    }
}
