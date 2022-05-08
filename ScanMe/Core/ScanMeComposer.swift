//
//  ScanMeComposer.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import UIKit

class ScanMeComposer {
    static var instance = ScanMeComposer()
    
    private init() {}
    
    func createScanMeViewController() -> ScanMeViewController {
        let storyboard = UIStoryboard(name: "ScanMeViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ScanMeViewController
        
        vc.viewModel = ScanMeViewModel(textExtractor: VisionKitService(),
                                       parser: ExpressionParserService())
        return vc
    }
}
