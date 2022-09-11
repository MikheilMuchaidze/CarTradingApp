import UIKit

private let button = UIButton(type: .custom)

extension UITextField {

    func enablePasswordToggle() {
        let openEye = UIImage(named: "closed-eye")?.withTintColor(.blue)
        let closedEye = UIImage(named: "opened-eye")?.withTintColor(.blue)

        button.setImage(openEye, for: .normal)
        button.setImage(closedEye, for: .selected)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }

    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        button.isSelected.toggle()
    }

}
