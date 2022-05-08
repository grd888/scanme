//
//  ScanMeViewControllerTests.swift
//  ScanMeViewControllerTests
//
//  Created by Greg Delgado III on 5/4/22.
//

import XCTest
import UIKit
@testable import ScanMe

class ScanMeViewControllerTests: XCTestCase {
    func testViewControllerRedTheme() {
        let appSettings = getAppSettings(color: .red)
        let sut = makeSUT(appSettings: appSettings)
        
        XCTAssertEqual(sut.resultsView.backgroundColor, UIColor(hex: appSettings.theme.primaryColor))
    }
    
    func testViewControllerGreenTheme() {
        let appSettings = getAppSettings(color: .green)
        let sut = makeSUT(appSettings: appSettings)
        
        XCTAssertEqual(sut.resultsView.backgroundColor, UIColor(hex: appSettings.theme.primaryColor))
    }
    
    // MARK: Helpers
    
    func makeSUT(appSettings: AppSettings = AppSettings.instance) -> ScanMeViewController {
        let viewModel = ScanMeViewModel(textExtractor: VisionKitService(), parser: ExpressionParserService())
        let storyboard = UIStoryboard(name: "ScanMeViewController", bundle: nil)
        let sut = storyboard.instantiateInitialViewController() as! ScanMeViewController
        
        sut.appSettings = appSettings
        sut.viewModel = viewModel
        
        sut.loadViewIfNeeded()
        
        return sut
    }
    
    func getAppSettings(color: Theme = .red,
                        source: ImageSource = .cameraRoll) -> AppSettings {
        let appSettings = AppSettings.instance
        appSettings.theme = color
        appSettings.imageSource = source
        
        return appSettings
    }
}
