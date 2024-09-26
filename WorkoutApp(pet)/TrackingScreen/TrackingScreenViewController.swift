//
//  TrackingScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 26.09.2024.
//

import Foundation
import UIKit

final class TrackingScreenViewController: UIViewController {
    //MARK: - Variables
    private let viewModel: TrackingViewModel
    private let router: Router
    
    
    //MARK: - Lifecycle
    init(viewModel: TrackingViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayoout()
        addNavigationBarSeparator()
        addTabBarSeparator()
    }
}

private extension TrackingScreenViewController {
    func setupUI() {
        view.backgroundColor = ColorResources.white
        
        navBarSettingsWith(title: Const.tracking)
    }
    
    func setupLayoout() {
        
    }
}
