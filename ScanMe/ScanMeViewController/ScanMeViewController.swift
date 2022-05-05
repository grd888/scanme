//
//  ScanMeViewController.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/4/22.
//

import UIKit

class ScanMeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var inputTitleLabel: UILabel!
    @IBOutlet weak var inputValueLabel: UILabel!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultValueLabel: UILabel!
    
    @IBOutlet weak var inputImageView: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    
    var appSettings: AppSettings = AppSettings.instance
    var viewModel: ScanMeViewModel = ScanMeViewModel(imageService: ImageService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTheme()
    }

    private func setupTheme() {
        let primaryColor = UIColor(hex: appSettings.theme.primaryColor)
        resultsView.backgroundColor = primaryColor
        addButton.backgroundColor = primaryColor
    }
    
    @IBAction func handleAddInput(_ sender: Any) {
        viewModel.getInputImage()
    }
}

