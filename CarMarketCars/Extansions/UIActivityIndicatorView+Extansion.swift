import UIKit

//MARK: - indicator animation for viewcontrollers

protocol LoadableView {
    var loader: UIActivityIndicatorView { get }
    func loader(isLoading: Bool)
    func setupLoader()
}

extension LoadableView {
    func loader(isLoading: Bool) {
        loader.color = .systemIndigo
        loader.isHidden = !isLoading
        isLoading ? loader.startAnimating() : loader.stopAnimating()
    }
}

