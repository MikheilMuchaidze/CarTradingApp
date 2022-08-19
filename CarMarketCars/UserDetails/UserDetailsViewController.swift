import UIKit
import Firebase
import FirebaseAuth

class UserDetailsViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var UserImageImage: UIImageView!
    
    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var UserSurnameLbl: UILabel!
    @IBOutlet weak var UserEmailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil {
                print("no user please sign in or register")
            } else {
                self.UserNameLbl.text = user?.displayName
                self.UserSurnameLbl.text = user?.displayName
                self.UserEmailLbl.text = user?.email
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
