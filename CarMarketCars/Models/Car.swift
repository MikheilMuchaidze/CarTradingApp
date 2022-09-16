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

struct CaruForUpdate: Equatable {
    let mark: String
    let model: String
    let year: String
    let location: String
    let price: String
    let phone: String
    let sellable: Bool
    
    //MARK: - Init for update
    
    init(mark: String, model: String, year: String, location: String, price: String, phone: String, sellable: Bool) {
        self.mark = mark
        self.model = model
        self.year = year
        self.location = location
        self.price = price
        self.phone = phone
        self.sellable = sellable
    }
    
    //MARK: - Convert Car to database type for update
    
    func toDatabaseTypeUpdate() -> [String : Any] {
        [
            "Mark": mark,
            "Model": model,
            "Year": year,
            "Location": location,
            "Price": price,
            "Phone": phone,
            "Sellable": sellable
        ]
    }
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
    
    init(documentID: String,email: String, mark: String, model: String, year: String, location: String, price: String, phone: String, sellable: Bool) {
        self.documentID = documentID
        self.email = email
        self.mark = mark
        self.model = model
        self.year = year
        self.location = location
        self.price = price
        self.phone = phone
        self.sellable = sellable
    }
    
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
    
    //MARK: - Convert Car to database type for upload
    
    func toDatabaseType() -> [String : Any] {
        [
            "DocumentID": documentID,
            "Email": email,
            "Mark": mark,
            "Model": model,
            "Year": year,
            "Location": location,
            "Price": price,
            "Phone": phone,
            "Sellable": sellable
        ]
    }
}



