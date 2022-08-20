import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class UserDetailsViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var UserImageImage: UIImageView!
    
    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var UserSurnameLbl: UILabel!
    @IBOutlet weak var UserEmailLbl: UILabel!
    @IBOutlet weak var UserUidLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            
            let db = Firestore.firestore()
            let usersRef = db.collection("users").document("\(auth.currentUser?.email ?? "")")
            
            usersRef.getDocument { document, error in
                if let document = document {
                    let data = document.data()
                    print(data!)
                    self.UserNameLbl.text = data!["Name"] as? String
                    self.UserSurnameLbl.text = data!["Surname"] as? String
                    self.UserEmailLbl.text = data!["Email"] as? String
                    self.UserUidLbl.text = data!["Uid"] as? String
                } else {
                    print("Document does'n exists \(error?.localizedDescription ?? "")")
                }
            }
         

            print("addStateDidChangeListener - MainCarsListViewController")
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        print("removeStateDidChangeListener - MainCarsListViewController")
    }
    
}
