import UIKit

//MARK: - Car struct fields

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

//MARK: - Car struct fields for failed fetching data from firebase

fileprivate enum CarFieldsFailedFetch {
    static let documentID = "No document id"
    static let email = "No email"
    static let mark = "No mark"
    static let model = "No model"
    static let year = "No year"
    static let location = "No location"
    static let price = "No price"
    static let phone = "No phone"
    static let sellable = false
}

//MARK: - Struct for adding/updating car function to database with specific init and funcion

struct CarForUpdate {
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

//MARK: - Main car struct

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
        self.documentID = dictionary[CarFields.documentID] as? String ?? CarFieldsFailedFetch.documentID
        self.email = dictionary[CarFields.email] as? String ?? CarFieldsFailedFetch.email
        self.mark = dictionary[CarFields.mark] as? String ?? CarFieldsFailedFetch.mark
        self.model = dictionary[CarFields.model] as? String ?? CarFieldsFailedFetch.model
        self.year = dictionary[CarFields.year] as? String ?? CarFieldsFailedFetch.year
        self.location = dictionary[CarFields.location] as? String ?? CarFieldsFailedFetch.location
        self.price = dictionary[CarFields.price] as? String ?? CarFieldsFailedFetch.price
        self.phone = dictionary[CarFields.phone] as? String ?? CarFieldsFailedFetch.phone
        self.sellable = dictionary[CarFields.sellable] as? Bool ?? CarFieldsFailedFetch.sellable
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



