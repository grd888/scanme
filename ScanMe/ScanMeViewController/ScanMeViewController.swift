//
//  ScanMeViewController.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/4/22.
//

import UIKit
import Combine
import UniformTypeIdentifiers

class ScanMeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var inputTitleLabel: UILabel!
    @IBOutlet weak var inputValueLabel: UILabel!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultValueLabel: UILabel!
    
    @IBOutlet weak var inputImageView: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    var appSettings: AppSettings = AppSettings.instance
    var subscriptions = Set<AnyCancellable>()
    
    var viewModel: ScanMeViewModel = ScanMeViewModel(imageService: ImageService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTheme()
        setupBindings()
    }

    private func setupTheme() {
        let primaryColor = UIColor(hex: appSettings.theme.primaryColor)
        resultsView.backgroundColor = primaryColor
        addButton.backgroundColor = primaryColor
    }
  
    private func setupBindings() {
        viewModel.imagePublisher.sink { [weak self] in
            self?.inputImageView.image = $0
        }
        .store(in: &subscriptions)
    }
    
    @IBAction func handleAddInput(_ sender: Any) {
        switch appSettings.imageSource {
        case .fileSystem:
            getImageFromFiles()
        case .camera:
            getImageFromCamera()
        case .cameraRoll:
            getImageFromCaneraRoll()
        }
    }
}

extension ScanMeViewController {
    private func getImageFromFiles() {
        let documentsPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.image])
        documentsPicker.delegate = self
        documentsPicker.allowsMultipleSelection = false
        documentsPicker.modalPresentationStyle = .fullScreen
        self.present(documentsPicker, animated: true, completion: nil)
    }
    
    private func getImageFromCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(title: "Error", message: "Your device does not seem to have a camera.")
            return
        }
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    private func getImageFromCaneraRoll() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    private func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        present(alert, animated: true)
    }
}

extension ScanMeViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            viewModel.processImage(image)
        }
        picker.dismiss(animated: true)
    }
}

extension ScanMeViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
        guard let image = UIImage(contentsOfFile: url.path) else {
            showAlert(title: "Error", message: "Could not read image.")
            return
        }
        viewModel.processImage(image)
    }
}

