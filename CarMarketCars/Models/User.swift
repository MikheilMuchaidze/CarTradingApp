import UIKit

enum UserFields {
    static let name = "Name"
    static let surname = "Surname"
    static let password = "Password"
    static let email = "Email"
    static let uid = "Uid"
}

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
        self.name = dictionary["Name"] as? String ?? ""
        self.surname = dictionary["Surname"] as? String ?? ""
        self.password = dictionary["Password"] as? String ?? ""
        self.email = dictionary["Email"] as? String ?? ""
        self.uid = dictionary["Uid"] as? String ?? ""
    }
    
    //MARK: - Convert User to database type for upload
    
    func toDatabaseType() -> [String : Any] {
        [
            "Name": name,
            "Surname": surname,
            "Password": password,
            "Email": email,
            "Uid": uid
        ]
    }
    
    
    
}
