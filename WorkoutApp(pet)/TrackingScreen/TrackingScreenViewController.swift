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
    private let bikeButton = SideBottomButton(type: .bike)
    private let runningButton = SideBottomButton(type: .running)
    private let startButton = SideBottomButton(type: .start)
    
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
        setupActions()
        addTabBarSeparator()
    }
}

private extension TrackingScreenViewController {
    func setupUI() {
        view.backgroundColor = ColorResources.white
        navBarSettingsWith(title: Const.tracking)
        
//        view.addSubview(topView)
//        topView.translatesAutoresizingMaskIntoConstraints = false
        setupViews(topView, bikeButton, runningButton, startButton)
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
            topView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 7),
            
            bikeButton.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 16),
            bikeButton.widthAnchor.constraint(equalTo: bikeButton.heightAnchor),
            bikeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: self.view.bounds.width / 20),
            bikeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -self.view.bounds.width / 16),
            
            runningButton.heightAnchor.constraint(equalTo: bikeButton.heightAnchor),
            runningButton.widthAnchor.constraint(equalTo: bikeButton.widthAnchor),
            runningButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -self.view.bounds.width / 20),
            runningButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -self.view.bounds.width / 16),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.centerYAnchor.constraint(equalTo: bikeButton.centerYAnchor)
        ])
    }
    
    func setupMapView() {
        mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
    }
    
    func setupActions() {
        bikeButton.addTarget(self, action: #selector(bikeTapped), for: .touchUpInside)
        runningButton.addTarget(self, action: #selector(reunTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }
    
    @objc func bikeTapped() {
        print("bike")
    }
    
    @objc func reunTapped() {
        print("run")
    }
    
    @objc func startTapped() {
        print("start")
    }
}
