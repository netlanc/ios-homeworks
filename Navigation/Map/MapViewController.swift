//
//  MapViewController.swift
//  Navigation
//
//  Created by netlanc on 07.03.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var destinationCoordinate: CLLocationCoordinate2D?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemBlue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var userTrackingButton: MKUserTrackingButton = {
        let button = MKUserTrackingButton(mapView: mapView)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["Standard", "Satellite", "Hybrid"]
        let segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var cityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поиск города", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(selectCity), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить метки", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(clearAnnotations), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
//        locationManager.stopUpdatingLocation()
        locationManager.delegate = self
        
        view.addSubview(mapView)
        view.addSubview(cityButton)
        view.addSubview(clearButton)
        view.addSubview(segmentedControl)
        
        mapView.addSubview(userTrackingButton)
        mapView.delegate = self
        
        setupConstraints()
        setupCenterMap()
    }
    
    private func setupCenterMap() {
        // перемещаем центр экрана к метке
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            userTrackingButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            userTrackingButton.centerYAnchor.constraint(equalTo: mapView.centerYAnchor),
            
            cityButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            cityButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            
            clearButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            clearButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    
    @objc private func clearAnnotations() {
        //удаляем метки
        mapView.removeAnnotations(mapView.annotations)
        // Удаляем все маршруты с карты
        mapView.removeOverlays(mapView.overlays)
    }
    
    @objc private func selectCity() {
        
        // лень допиливать рашширение, по этому делаю алерт
        let alertController = UIAlertController(title: "Введите город", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Город"
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Найти", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let cityName = textField.text {
                // Показываем индикатор загрузки
                self?.showActivityIndicator()
                // Выполняем геокодирование
                self?.geocode(cityName: cityName)
            }
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
    
    
    private func geocode(cityName: String) {
        let geocoder = CLGeocoder()
        let _self = self
        geocoder.geocodeAddressString(cityName) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                // Обработка ошибки
                _self.runAlert(textAlert: "Не удалось найти местоположение для указанного города")
                // Скрываем индикатор загрузки в случае ошибки
                self?.hideActivityIndicator()
                return
            }
            
            // Установка координат для пина
            self?.destinationCoordinate = location.coordinate
            
            // Добавление пина на карту
            self?.addAnnotationToMap(coordinate: location.coordinate)
            
            // Построение маршрута
            self?.showRoute()
        }
    }
    
    private func showActivityIndicator() {
        // Добавляем индикатор загрузки на view и активируем его
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        // Скрываем и удаляем индикатор загрузки
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    private func addAnnotationToMap(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    private func showRoute() {
        let _self = self
        guard let destinationCoordinate = destinationCoordinate else {
            self.runAlert(textAlert: "Координаты пункта назначения отсутствуют")
            return
        }
        
        let sourcePlacemark = MKPlacemark(coordinate: mapView.userLocation.coordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { [weak self] response, error in
            
            guard let response = response, let route = response.routes.first else {
                
                _self.runAlert(textAlert: "Ошибка при построении маршрута: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                return
            }
            
            // Удаление существующих маршрутов с карты
            self?.mapView.removeOverlays(self?.mapView.overlays ?? [])
            
            // Добавление маршрута на карту
            self?.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            // Отображение маршрута на экране
            let rect = route.polyline.boundingMapRect
            self?.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            
            // Скрываем индикатор загрузки после завершения запроса
            self?.hideActivityIndicator()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // рисует маршрут
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 4.0
        return renderer
    }
}


extension MapViewController: CLLocationManagerDelegate {
    
    // обработка запроса разрешение на использование местоположения
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            // Ok
            locationManager.startUpdatingLocation()
            setupCenterMap()
            break
        case .denied, .restricted:
            // Отмена или нет разрешения
            break
        case .authorizedAlways:
            // Разрешено всегда
            break
        case .notDetermined:
            // Неопределено
            break
        @unknown default:
            break
        }
    }
}
