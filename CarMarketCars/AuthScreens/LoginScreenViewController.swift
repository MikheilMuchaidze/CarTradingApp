import UIKit
import Firebase
import FirebaseAuth

class LoginScreenViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
                

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil {
                print("no user please sign")
            } else {
                self.UserEmailTxt.text = nil
                self.UserPasswordTxt.text = nil
                
//                print("User \(user!.email ?? "") Successful sign in")
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainCarsListViewController") as! MainCarsListViewController
//                self.navigationController?.pushViewController(vc, animated: true)
            }
            print("addStateDidChangeListener - LoginPage")
        })
                                                       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        UserEmailTxt.text = nil
        UserPasswordTxt.text = nil
        
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        print("removeStateDidChangeListener - RegisterPage")
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        
        guard
            let email = UserEmailTxt.text,
            let password = UserPasswordTxt.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                self.alertPopUp(title: "Sign in failed", message: "\(error.localizedDescription)", okTitle: "Try again.")
            }
            
            print("User \(user?.user.email ?? "") Successful sign in")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainCarsListViewController") as! MainCarsListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
}
