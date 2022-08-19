import UIKit
import Firebase
import FirebaseAuth

class MainCarsListViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var activeUserLbl: UILabel!
    
    @IBOutlet weak var goBackActionImage: UIImageView!
    @IBOutlet weak var userDetailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapToGoBackToImage(image: goBackActionImage)
        addTapToGoToDetailsToImage(image: userDetailsImage)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil {
                print("no user please sign in or register")
            } else {
                self.activeUserLbl.text = user?.email
            }
            print("addStateDidChangeListener - MainCarsListViewController")
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print(signOutError.localizedDescription)
        }
        
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        print("removeStateDidChangeListener - MainCarsListViewController")
    }
    
    
    

}





