import UIKit

//MARK: - indicator animation for viewcontrollers

protocol LoadableView {
    var loader: UIActivityIndicatorView { get }
    func loader(isLoading: Bool)
    func setupLoader()
}

//MARK: - extansion for LoadableView protocol to insert default function in view which conforms to this protocol

extension LoadableView {
    func loader(isLoading: Bool) {
        loader.color = .systemIndigo
        loader.isHidden = !isLoading
        isLoading ? loader.startAnimating() : loader.stopAnimating()
    }
}

