import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class MainCarsListViewController: UIViewController {
    
    let carsdb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
    var carsList = [Dictionary<String, Any>]()
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var activeUserLbl: UILabel!
    
    @IBOutlet weak var goBackActionImage: UIImageView!
    @IBOutlet weak var userDetailsImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //flipped
        goBackActionImage.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        addTapToGoBackToImage(image: goBackActionImage)
        addTapToGoToDetailsToImage(image: userDetailsImage)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        carsList.removeAll()
        
        carsdb.whereField("Sellable", isEqualTo: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let snapshot = snapshot?.documents else { return }
            self.carsList.removeAll()
            
            for document in snapshot {
                let data = document.data()
                DispatchQueue.main.async {
                    self.carsList.append(data)
                    self.tableView.reloadData()
                }
            }
        }
        

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
    
    @IBAction func uploadCarBtn(_ sender: Any) {
        let carUploadPage = storyboard?.instantiateViewController(withIdentifier: "newCarUploadViewController") as! newCarUploadViewController
        self.present(carUploadPage, animated: true)
    }
    
    
    

}

