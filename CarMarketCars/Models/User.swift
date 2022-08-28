import UIKit

struct User {
    let name: String
    let surname: String
    let password: String
    let email: String
    let Uid: String
    
    init(with dictionary: Dictionary<String, Any>) {
        self.name = dictionary["Name"] as? String ?? ""
        self.surname = dictionary["Surname"] as? String ?? ""
        self.password = dictionary["Password"] as? String ?? ""
        self.email = dictionary["Email"] as? String ?? ""
        self.Uid = dictionary["Uid"] as? String ?? ""
    }
    
}
