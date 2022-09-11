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
        self.name = dictionary["Name"] as? String ?? "No name"
        self.surname = dictionary["Surname"] as? String ?? "No surname"
        self.password = dictionary["Password"] as? String ?? "No password"
        self.email = dictionary["Email"] as? String ?? "No email"
        self.uid = dictionary["Uid"] as? String ?? "No uid"
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
