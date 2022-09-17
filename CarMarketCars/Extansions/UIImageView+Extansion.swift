import UIKit

extension UIViewController {
    
    //MARK: - Tap fucntionality for sign out and profile pics
    
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
        let toDetailsVC = UIStoryboard(name: StoryboardNames.userDetails, bundle: nil)
        guard let toDetailsVC = toDetailsVC.instantiateViewController(withIdentifier: ViewControllerName.userDetails) as? UserDetailsViewController else { return }
        self.present(toDetailsVC, animated: true)
    }
    
    //MARK: - Alert massege funcion
    
    func alertPopUp(title: String, message: String, okTitle: String) {
        let alertmassege = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okTitle, style: UIAlertAction.Style.default, handler: nil)
        alertmassege.addAction(okAction)
        self.present(alertmassege, animated: true)
    }
    
}

//MARK: - Imageview load image from url

extension UIImageView {
    
    //load image from url
    func loadImageFrom(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
