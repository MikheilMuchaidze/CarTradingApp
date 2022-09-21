import UIKit

//MARK: - For clearing textfields

extension Array where Element: UITextField {
    
    func clearFields() {
        self.forEach { elem in
            elem.text?.removeAll()
        }
    }
    
}
