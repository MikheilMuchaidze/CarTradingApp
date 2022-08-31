import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class UserDetailsViewController: UIViewController {
    
    let carsdb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
    var carsList = [Car]()
    var searchingCarsList = [Car]()

    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var UserImageImage: UIImageView!
    
    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var UserSurnameLbl: UILabel!
    @IBOutlet weak var UserEmailLbl: UILabel!
    @IBOutlet weak var UserUidLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        
        searchBar.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {        
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            
            let db = Firestore.firestore()
            let usersRef = db.collection(FirebaseCollectionNames.users.rawValue).document("\(auth.currentUser?.email ?? "")")
                        
            usersRef.getDocument { document, error in
                if let document = document {
                    let data = document.data()
                    self.UserNameLbl.text = data!["Name"] as? String
                    self.UserSurnameLbl.text = data!["Surname"] as? String
                    self.UserEmailLbl.text = data!["Email"] as? String
                    self.UserUidLbl.text = data!["Uid"] as? String
                    let currentUser = data!["Email"] as? String
                    
                    self.carsdb.whereField("Email", isEqualTo: currentUser!).addSnapshotListener { snapshot, error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                        guard let snapshot = snapshot?.documents else { return }
                        
                        self.carsList.removeAll()
                        
                        snapshot.forEach { document in
                            self.carsList.append(Car(with: document.data()))
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                } else {
                    print("Document does'n exists \(error?.localizedDescription ?? "")")
                }
            }

            print("addStateDidChangeListener - UserDetailsViewController")
            
        })
            
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        print("removeStateDidChangeListener - UserDetailsViewController")
        
    }
    
}
