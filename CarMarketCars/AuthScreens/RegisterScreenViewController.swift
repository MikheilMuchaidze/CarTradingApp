import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class RegisterScreenViewController: UIViewController {
        
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var UserRepeatPassTxt: UITextField!
    @IBOutlet weak var UserNameTxt: UITextField!
    @IBOutlet weak var UserSurnameTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let refDB = FirebaseDatabase.Database.database()

    }
    
    override func viewWillAppear(_ animated: Bool) {
            
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil {
                print("no user please register")
            } else {
                self.UserEmailTxt.text = nil
                self.UserPasswordTxt.text = nil
                self.UserRepeatPassTxt.text = nil
                self.UserNameTxt.text = nil
                self.UserSurnameTxt.text = nil
            }
            
            print("addStateDidChangeListener - RegisterPage")
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        UserEmailTxt.text = nil
        UserPasswordTxt.text = nil
        UserRepeatPassTxt.text = nil
        UserNameTxt.text = nil
        UserSurnameTxt.text = nil
        
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        print("removeStateDidChangeListener - RegisterPage")

    }
    
    //clear all fields
    @IBAction func resetAllFields(_ sender: Any) {
        let allTxtFields = [UserEmailTxt, UserPasswordTxt, UserRepeatPassTxt, UserNameTxt, UserSurnameTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
                
        if validateIfEmpty() == true && validateIfPasswordMatch() == true && validateIfPassword(str: UserPasswordTxt.text!) == true && validateIfEmailCorrectForm(str: UserEmailTxt.text!) {
            
            guard
                let email = UserEmailTxt.text,
                let password = UserPasswordTxt.text,
                !email.isEmpty,
                !password.isEmpty
            else { return }
            
            
            Auth.auth().createUser(withEmail: UserEmailTxt.text!, password: UserPasswordTxt.text!) { authResult, error in
                
                if error != nil {
                    self.alertPopUp(title: "Failure", message: "\(error!.localizedDescription)", okTitle: "Try again")
                    return
                }
                self.alertPopUp(title: "Congratulations", message: "Your user created!", okTitle: "Log In")
                print("Successful sign up")
                self.tabBarController?.selectedIndex = 0
            }
        }
        
        
    }
    
    
}

