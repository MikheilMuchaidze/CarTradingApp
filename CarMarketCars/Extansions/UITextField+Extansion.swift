import UIKit

//MARK: - extansion with secure toggle function for textfields

private let button = UIButton(type: .custom)

fileprivate enum PasswordVisibilityStatus {
    static let visible = "opened-eye"
    static let notVisible = "closed-eye"
}

extension UITextField {
    
    func enablePasswordToggle() {
        self.isSecureTextEntry = true
        let openEye = UIImage(named: PasswordVisibilityStatus.notVisible)?.withTintColor(.blue)
        let closedEye = UIImage(named: PasswordVisibilityStatus.visible)?.withTintColor(.blue)

        button.setImage(closedEye, for: .selected)
        button.setImage(openEye, for: .normal)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .whileEditing
    }

    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        button.isSelected.toggle()
    }

}
