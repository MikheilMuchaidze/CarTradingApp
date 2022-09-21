import UIKit

protocol LoginScreenBusinessLogic {
    func validateUser(request: LoginScreen.UserValidation.Request)
}

final class LoginScreenInteractor {
    
    //MARK: - Clean Components
    
    var presenter: LoginScreenPresentationLogic?
    var worker: LoginScreenWorker?
    
    //MARK: - Methods
    
    //validate email form
    private func validateEmailForm(for emailString: String?) -> Bool {
        guard let emailValue = emailString else { return false }
        let emailRegEx = AuthValidationAndAlert.AuthEmailPredicate.emailRegEx
        if (!NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: emailValue)) {
            return false
        } else {
            return true
        }
    }
    
    //validation of text fields
    private func validateIfEmpty(for fields: [String?]) -> Bool {
        for text in fields {
            if text?.isEmpty == true {
                return false
            }
        }
        return true
    }
    
}

//MARK: - extansion for display logic protocol

extension LoginScreenInteractor: LoginScreenBusinessLogic {
    
    func validateUser(request: LoginScreen.UserValidation.Request) {
        guard let email = request.email,
              let password = request.password
        else { return }
        let checkEmptyFields = [email, password]
        
        if !validateIfEmpty(for: checkEmptyFields) {
            presenter?.userValidationOutcome(response: LoginScreen.UserValidation.Response(outcome: AuthValidationAndAlert.ValidationTitles.fieldsEmpty, isError: true))
        } else if !validateEmailForm(for: email) {
            presenter?.userValidationOutcome(response: LoginScreen.UserValidation.Response(outcome: AuthValidationAndAlert.ValidationTitles.incorrectEmail, isError: true))
        } else {
            worker?.loginUser(email: email, password: password, completion: { [weak self] (outcome, isError) in
                let response = LoginScreen.UserValidation.Response(outcome: outcome, isError: isError)
                self?.presenter?.userValidationOutcome(response: response)
            })
        }
    }
    
}
