import UIKit

struct Car: Equatable {
    let documentID: String
    let email: String
    let mark: String
    let model: String
    let year: String
    let location: String
    let price: String
    let sellable: Bool
    
    init(with dictionary: Dictionary<String, Any>) {
        self.documentID = dictionary["DocumentID"] as? String ?? ""
        self.email = dictionary["Email"] as? String ?? ""
        self.mark = dictionary["Mark"] as? String ?? ""
        self.model = dictionary["Model"] as? String ?? ""
        self.year = dictionary["Year"] as? String ?? ""
        self.location = dictionary["Location"] as? String ?? ""
        self.price = dictionary["Price"] as? String ?? ""
        self.sellable = dictionary["Sellable"] as? Bool ?? false
    }
    
    
}
