import UIKit

enum CarFields {
    static let documentID = "DocumentID"
    static let email = "Email"
    static let mark = "Mark"
    static let model = "Model"
    static let year = "Year"
    static let location = "Location"
    static let price = "Price"
    static let phone = "Phone"
    static let sellable = "Sellable"
}

struct Car: Equatable {
    let documentID: String
    let email: String
    let mark: String
    let model: String
    let year: String
    let location: String
    let price: String
    let phone: String
    let sellable: Bool
    
    //MARK: - Init for download from firebase
    
    init(with dictionary: Dictionary<String, Any>) {
        self.documentID = dictionary["DocumentID"] as? String ?? "No document id"
        self.email = dictionary["Email"] as? String ?? "No email"
        self.mark = dictionary["Mark"] as? String ?? "No mark"
        self.model = dictionary["Model"] as? String ?? "No model"
        self.year = dictionary["Year"] as? String ?? "No year"
        self.location = dictionary["Location"] as? String ?? "No location"
        self.price = dictionary["Price"] as? String ?? "No price"
        self.phone = dictionary["Phone"] as? String ?? "No phone"
        self.sellable = dictionary["Sellable"] as? Bool ?? false
    }
    
}

