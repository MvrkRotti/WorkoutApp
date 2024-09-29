//
//  TrackingScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 26.09.2024.
//

import Foundation
import UIKit
import MapKit

final class TrackingScreenViewController: UIViewController, MKMapViewDelegate {
    //MARK: - Variables
    private let viewModel: TrackingViewModel
    private let router: Router
    
    private var mapView: MKMapView!
    private let topView = TopView()
    
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
        setupMapView()
        setupUI()
        setupLayoout()
        addTabBarSeparator()
    }
}

private extension TrackingScreenViewController {
    func setupUI() {
        view.backgroundColor = ColorResources.white
        navBarSettingsWith(title: Const.tracking)
        
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayoout() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 7)
        ])
    }
    
    func setupMapView() {
        mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
    }
}
