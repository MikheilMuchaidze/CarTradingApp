import UIKit

//MARK: - Indicator animation for viewcontrollers

protocol LoadableView {
    var loader: UIActivityIndicatorView { get }
    func loader(isLoading: Bool)
}

//MARK: - Extansion for LoadableView protocol to insert default function in view which conforms to this protocol

extension LoadableView {
    func loader(isLoading: Bool) {
        loader.color = .systemIndigo
        loader.isHidden = !isLoading
        isLoading ? loader.startAnimating() : loader.stopAnimating()
    }
}

