import UIKit

final class MainCarsListViewController: UIViewController {
    
    //MARK: - Fields
    
    var carsList = [Car]()
    var searchingCarsList = [Car]()
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activeUserLbl: UILabel!
    @IBOutlet weak var goBackActionImage: UIImageView!
    @IBOutlet weak var userDetailsImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    
    private func setup() {
        //flipped
        goBackActionImage.transform = CGAffineTransform(scaleX: -1, y: 1)
        //add actions for images
        addTapToGoBackToImage(image: goBackActionImage)
        addTapToGoToDetailsToImage(image: userDetailsImage)
        //delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.delegate = self
        //downloading data for tableview
        FirebaseDatabaseDownload.fetchCars { [weak self] snapshot, error in
            if let error = error {
                self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.fetchingCarsError, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
            } else {
                guard let snapshot = snapshot?.documents else { return }
                self?.carsList.removeAll()
                snapshot.forEach { elem in
                    self?.carsList.append(Car(with: elem.data()))
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        tablePullToRefresh()
        FirebaseDatabaseDownload.currentUserInfo(remove: false) { [weak self] user in
            self?.activeUserLbl.text = user.email
        }
    }
    
    //MARK: - Actions
    
    @IBAction func uploadCarBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: StoryboardNames.newCar, bundle: nil)
        guard let carUploadPage = storyboard.instantiateViewController(withIdentifier: ViewControllerName.newCar) as? NewCarUploadViewController else { return }
        carUploadPage.carUploadPageStatus = .AddingCar
        self.present(carUploadPage, animated: true)
    }
    
}
