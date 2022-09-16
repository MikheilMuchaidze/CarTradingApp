import UIKit

//MARK: - For clearing textfields

extension Array where Element: UITextField {
    //clear all text from all textfields
    func clearFields() {
        self.forEach { elem in
            elem.text?.removeAll()
        }
    }
    
}
