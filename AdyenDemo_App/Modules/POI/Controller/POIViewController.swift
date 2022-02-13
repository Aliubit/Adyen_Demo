//
//  ViewController.swift
//  AdyenDemo_App
//
//  Created by Ali on 11/02/22.
//

import UIKit
import MapKit

class POIViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var mapView : MKMapView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var radiusLabel : UILabel!
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var mapParentView : UIView!
    @IBOutlet weak var listParentView : UIView!
    @IBOutlet weak var sliderStackView : UIStackView!
    @IBOutlet weak var noResultsListView : UILabel!
    
    // MARK: - Variables
    var currentView : Int = CurrentPOIView.Map.rawValue
    var currentRadius : Double = Constants.radius
    var dataSource : [Result]?
    
    // MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        LocationManager.shared.delegate = self
        // ASK For location permission
        LocationManager.shared.startTracking()
        
    }
    
    // MARK: - UI functions
    
    func setupUI() {
        self.tableView.tableFooterView = UIView()
        self.activityIndicator.isHidden = true
        populateViewWithDataSource()
        setupSegmentControl()
        initializeSliderView()
    }
    
    func setupSegmentControl() {
        let segment: UISegmentedControl = UISegmentedControl(items: [Constants.MapView, Constants.ListView])
        segment.sizeToFit()
        if #available(iOS 13.0, *) {
            segment.selectedSegmentTintColor = UIColor.systemGray3
        } else {
            segment.tintColor = UIColor.systemGray3
        }
        segment.selectedSegmentIndex = CurrentPOIView.Map.rawValue
        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: Constants.defaultFont, size: 15)!], for: .normal)
        segment.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        segment.selectedSegmentIndex = currentView
        let barButtonItem = UIBarButtonItem(customView: segment)
        self.navigationItem.rightBarButtonItems = [barButtonItem]
    }
    
    func initializeSliderView() {
        slider.maximumValue = 1000
        slider.minimumValue = 100
        slider.value = Float(currentRadius)
        setRadiusLabel(withMeters: currentRadius)
    }
    
    func setRadiusLabel(withMeters radius : Double) {
        self.radiusLabel.text = "Radius (m) = " + String(format: "%.01f", radius)
    }
    
    func populateViewWithDataSource() {
        switch self.currentView {
        case CurrentPOIView.Map.rawValue:
            populateMapView()
            break
        case CurrentPOIView.List.rawValue:
            populateListView()
            break
        default:
            print("Unexpected")
            // CANNOT HAPPEN
        }
    }
    
    func populateMapView() {
        self.mapParentView.isHidden = false
        self.listParentView.isHidden = true

        let location = LocationManager.shared.location
        let region = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 500)!, longitudinalMeters: CLLocationDistance(exactly: 500)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        
        guard (self.dataSource?.count ?? 0) > 0 else {return}
        
        for result in self.dataSource! {
            let annotation = MapAnnotationView(title: result.poi?.name, phoneNumber: result.poi?.phone, address: result.address?.freeformAddress, coordinate: CLLocationCoordinate2D(latitude: result.position?.lat ?? 0.0, longitude: result.position?.lon ?? 0.0))
            mapView.addAnnotation(annotation)
        }
    }
    
    func populateListView() {
        self.mapParentView.isHidden = true
        self.listParentView.isHidden = false
        self.tableView.reloadData()
    }
    
    // MARK: - Api/Data functions
    
    func callPOIApi() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let requestModel = POIRequestModel(query: Constants.POIQuery, lat: LocationManager.shared.location.coordinate.latitude, lon: LocationManager.shared.location.coordinate.longitude, radius: currentRadius, apiKey: Constants.tomTomApiKey)
        POIRestHandler.getPOI(requestModel : requestModel, completion: {(response , errorMessage) in
            self.activityIndicator.isHidden = true
            guard let model = response , let results = model.results else {
                self.showAlert(title: Messages.defaultTitle, message: errorMessage ?? Messages.serviceResponseFailedMessage)
                return
            }
            self.dataSource = results
            self.populateViewWithDataSource()
        })
    }
    
    // MARK: - IBActions

    @objc func segmentSelected(sender: UISegmentedControl)
    {
        let index = sender.selectedSegmentIndex
        currentView = CurrentPOIView(rawValue: index)!.rawValue
        populateViewWithDataSource()
    }
    
    @IBAction func radiusChanged(_ sender: Any) {
        currentRadius = Double(slider.value)
        setRadiusLabel(withMeters: currentRadius)
        self.callPOIApi()
    }
}

// MARK: - Location Manager delegate functions

extension POIViewController : LocationManagerDelegate {
    func didGetLocation() {
        sliderStackView.isHidden = false
        callPOIApi()
    }
    
    func failToGetLocation() {
        self.showAlert(title: Messages.defaultTitle, message: Messages.enableLocationMessage)
        sliderStackView.isHidden = true
    }
}

// MARK: - TableView functions

extension POIViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifier.POITableViewCell.rawValue)! as! POITableViewCell
        let result = dataSource![indexPath.row]
        let annotation = MapAnnotationView(title: result.poi?.name, phoneNumber: result.poi?.phone, address: result.address?.freeformAddress, coordinate: CLLocationCoordinate2D(latitude: result.position?.lat ?? 0.0, longitude: result.position?.lon ?? 0.0),distance: CLLocation(latitude: result.position?.lat ?? 0.0, longitude: result.position?.lon ?? 0.0).distance(from: LocationManager.shared.location))
        cell.populateData(annotation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.dataSource?.count ?? 0) > 0 {
            self.noResultsListView.isHidden = true
        }
        else {
            self.noResultsListView.isHidden = false
        }
        return self.dataSource?.count ?? 0
    }
}

