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
        setupMapView()
        setupLayoout()
//        addNavigationBarSeparator()
        addTabBarSeparator()
    }
}

private extension TrackingScreenViewController {
    func setupUI() {
        view.backgroundColor = ColorResources.white
        navBarSettingsWith(title: Const.tracking)
    }
    
    func setupLayoout() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
