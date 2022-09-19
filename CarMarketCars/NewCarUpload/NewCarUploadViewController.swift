import UIKit

final class NewCarUploadViewController: UIViewController, LoadableView {

    //MARK: - Fields

    var carUploadPageStatus: carUploadStatus?
    var editingCar: Car?
    var sellable: Bool = true
    let uuid = UUID().uuidString
    var loader = UIActivityIndicatorView()
    
    //MARK: - Outlets
    
    @IBOutlet weak var addCarToListBtnOutlet: UIButton!
    @IBOutlet weak var titleTextLbl: UILabel!
    @IBOutlet weak var updateCarToListBtnOutlet: UIButton!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet var addLinkView: UIView!
    @IBOutlet weak var insertedLinkTxt: UITextField!
    @IBOutlet weak var carMarkTxt: UITextField!
    @IBOutlet weak var carModelTxt: UITextField!
    @IBOutlet weak var carYearTxt: UITextField!
    @IBOutlet weak var carLocationTxt: UITextField!
    @IBOutlet weak var carPriceTxt: UITextField!
    @IBOutlet weak var carPhoneTxt: UITextField!
    @IBOutlet weak var sellableStatusOutlet: UISwitch!
    @IBOutlet weak var addCarImageWithUrl: UIButton!
    @IBOutlet weak var addCarImageFromGallery: UIButton!
    @IBOutlet weak var removeCarImage: UIButton!
    @IBOutlet weak var sellNowText: UILabel!
    @IBOutlet weak var resetTxtFieldsOutlet: UIButton!

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cleanAllFields()
    }
    
    //MARK: - Setup
    
    private func setup() {
        setupLoader()
        carImage.layer.cornerRadius = 10
        carImage.layer.borderColor = UIColor.systemBlue.cgColor
        carImage.layer.borderWidth = 2
        carImage.backgroundColor = .clear
        //set width = 300, height = 140
        addLinkView.bounds = CGRect(x: 0, y: 0, width: 300, height: 140)
        //editing mode choose
        guard let carUploadPageStatus = carUploadPageStatus else { return }
        carUpload(page: carUploadPageStatus)
    }
    
    private func setupLoader() {
        carImage.addSubview(loader)
        loader.center(inView: carImage)
    }
    
    //MARK: - Methods
    
    private func cleanAllFields() {
        [carMarkTxt, carModelTxt, carYearTxt, carLocationTxt, carPriceTxt, carPhoneTxt].clearFields()
    }
    
    //MARK: - Actions
    
    @IBAction func addCarImageWithUrlBtn(_ sender: Any) {
        animateIn(desiredView: addLinkView)
    }
    
    @IBAction func addCarImageFromGalleryBtn(_ sender: Any) {
        showImagePickerController()
        loader(isLoading: false)
    }
    
    @IBAction func linkLoadToImageBtn(_ sender: Any) {
        
        guard let imageUrl = insertedLinkTxt.text else { return }
        if imageUrl == "" {
            alertPopUpWithModel(errorPopUpModel: PredefinedAlerMessages.imageUrlError)
            carImage.image = nil
        } else {
            guard let url = URL(string: imageUrl) else { return }
            carImage.loadImageFrom(url: url)
            insertedLinkTxt.text = nil
            animateOut(desiredView: addLinkView)
        }
        
    }
    
    @IBAction func addLinkViewExit(_ sender: Any) {
        insertedLinkTxt.text = nil
        animateOut(desiredView: addLinkView)
    }
    
    @IBAction func removeCarImageBtn(_ sender: Any) {
        carImage.image = nil
        loader(isLoading: true)
    }
    
    @IBAction func sellableStatusAction(_ sender: UISwitch) {
        sellable = sender.isOn
    }

    @IBAction func addCarToListBtn(_ sender: Any) {
        
        let ifEmptyValidation = [carMarkTxt, carModelTxt, carYearTxt, carLocationTxt, carPriceTxt, carPhoneTxt]
                
        if validateIfEmpty(for: ifEmptyValidation, errorPopUpModel: PredefinedAlerMessages.ifEmptyError) && ifImageIsEmpty(for: carImage) {
            FirebaseDatabaseDownload.currentUserInfo(remove: false) { [weak self] user in
                guard
                    let uuid = self?.uuid,
                    let mark = self?.carMarkTxt.text,
                    let model = self?.carModelTxt.text,
                    let year = self?.carYearTxt.text,
                    let location = self?.carLocationTxt.text,
                    let price = self?.carPriceTxt.text,
                    let phone = self?.carPhoneTxt.text,
                    let sellable = self?.sellable
                else { return }
                let addingCar = Car(documentID: uuid, email: user.email, mark: mark, model: model, year: year, location: location, price: price, phone: phone, sellable: sellable)
                FirebaseDatabaseUpload.addCarInDB(car: addingCar.toDatabaseType(), uid: uuid) { error in
                    if let error = error {
                        self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.addCarTodatabase, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
                    }
                }
                if let imageData = self?.carImage.image?.jpegData(compressionQuality: 0.5) {
                    FirebaseDatabaseUpload.imageUploader(image: imageData, uid: uuid) { metadata, error in
                        if let error = error {
                            self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.addImageToStorage, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
                        }
                    }
                }
                self?.dismiss(animated: true)
            }
        }
        
    }
    
    @IBAction func resetTxtFields(_ sender: Any) {
        cleanAllFields()
    }
    
    @IBAction func updateCarToListBtn(_ sender: Any) {
        
        let ifEmptyValidation = [carMarkTxt, carModelTxt, carYearTxt, carLocationTxt, carPriceTxt, carPhoneTxt]
        
        if validateIfEmpty(for: ifEmptyValidation, errorPopUpModel: PredefinedAlerMessages.ifEmptyError) && ifImageIsEmpty(for: carImage) {
            guard
                let editingCar = editingCar,
                let mark = self.carMarkTxt.text,
                let model = self.carModelTxt.text,
                let year = self.carYearTxt.text,
                let location = self.carLocationTxt.text,
                let price = self.carPriceTxt.text,
                let phone = self.carPhoneTxt.text
            else { return }
            let updates = CarForUpdate(mark: mark, model: model, year: year, location: location, price: price, phone: phone, sellable: sellable)
            FirebaseDatabaseEdit.updateCarInDB(car: updates.toDatabaseTypeUpdate(), uid: editingCar.documentID) { error in
                if let error = error {
                    self.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.updateCarTodatabase, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
                }
            }
            if let imageData = carImage.image?.jpegData(compressionQuality: 0.5) {
                FirebaseDatabaseUpload.imageUploader(image: imageData, uid: editingCar.documentID) { metadata, error in
                    if let error = error {
                        self.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.addImageToStorage, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
                    }
                }
            }
            dismiss(animated: true)
        }
    }
    
}




