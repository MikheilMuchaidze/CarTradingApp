import Firebase
import FirebaseAuth
import UIKit

extension UIViewController {
    
    //funcion for add back option to image
    func addTapToGoBackToImage(image: UIImageView) {
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToGoBack))
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapToGoBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //funcion for presenting view to image
    func addTapToGoToDetailsToImage(image: UIImageView) {
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToGoToDetails))
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapToGoToDetails() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController")
        guard let vc = vc else { return }
        self.present(vc, animated: true)
    }
}

//alert popup function for all UIViewControllers presented and created
extension UIViewController {
    func alertPopUp(title: String, message: String, okTitle: String) {
        let alertmassege = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okTitle, style: UIAlertAction.Style.default, handler: nil)
        alertmassege.addAction(okAction)
        self.present(alertmassege, animated: true)
    }
    
}
