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
            CarFields.mark: mark,
            CarFields.model: model,
            CarFields.year: year,
            CarFields.location: location,
            CarFields.price: price,
            CarFields.phone: phone,
            CarFields.sellable: sellable
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
        self.documentID = dictionary[CarFields.documentID] as? String ?? "No document id"
        self.email = dictionary[CarFields.email] as? String ?? "No email"
        self.mark = dictionary[CarFields.mark] as? String ?? "No mark"
        self.model = dictionary[CarFields.model] as? String ?? "No model"
        self.year = dictionary[CarFields.year] as? String ?? "No year"
        self.location = dictionary[CarFields.location] as? String ?? "No location"
        self.price = dictionary[CarFields.price] as? String ?? "No price"
        self.phone = dictionary[CarFields.phone] as? String ?? "No phone"
        self.sellable = dictionary[CarFields.sellable] as? Bool ?? false
    }
    
    //MARK: - Convert Car to database type for upload
    
    func toDatabaseType() -> [String : Any] {
        [
            CarFields.documentID: documentID,
            CarFields.email: email,
            CarFields.mark: mark,
            CarFields.model: model,
            CarFields.year: year,
            CarFields.location: location,
            CarFields.price: price,
            CarFields.phone: phone,
            CarFields.sellable: sellable
        ]
    }
}



