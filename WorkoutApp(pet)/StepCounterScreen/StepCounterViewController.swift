//
//  StepCounterViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit
import Charts
import DGCharts

class StepCounterViewController: UIViewController {
    //MARK: - Variables
    
    private let viewModel: StepCounterViewModel
    private let router: Router
    
    
    init(viewModel: StepCounterViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

private extension StepCounterViewController {

}
