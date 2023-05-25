import UIKit
import MapKit
import Algorithms
import CoreLocation

class ViewController: UIViewController {
  @IBOutlet private var mapView: MKMapView!
  private var objectLocations: [ObjectLocations] = []
  
  func distance(from location1: CLLocation, to location2: CLLocation) -> CLLocationDistance {
    return location1.distance(from: location2)
  }
  func initialize() {
    let startLocation = ObjectLocations(
      title: "Me",
      locationType: .starting,
      coordinate: CLLocationCoordinate2D(latitude: 54.702593 , longitude: 25.288330 )
    )
    let personOne = ObjectLocations(title: "Jonas", locationType: .person, coordinate: CLLocationCoordinate2D(latitude: 54.717594, longitude: 25.284990))
    
    let personTwo = ObjectLocations(title: "Petras", locationType: .person, coordinate: CLLocationCoordinate2D(latitude: 54.712715, longitude: 25.303593))
    
    let personThree = ObjectLocations(title: "Rimas", locationType: .person, coordinate: CLLocationCoordinate2D(latitude: 54.728395, longitude: 25.296547))
    
    let activityOne = ObjectLocations(title: "Boulingas Zirmunu", locationType: .activity, coordinate: CLLocationCoordinate2D(latitude: 54.718300, longitude: 25.303018))
    
    let activityTwo = ObjectLocations(title: "Boulingas Apollo", locationType: .activity, coordinate: CLLocationCoordinate2D(latitude: 54.709838, longitude: 25.263310))
    
    let activityThree = ObjectLocations(title: "Boulingas Amerigo", locationType: .activity, coordinate: CLLocationCoordinate2D(latitude: 54.708014, longitude: 25.227058))
    
    let people = [personOne, personTwo, personThree]
    let activities:[ObjectLocations] =  [activityOne, activityTwo, activityThree]
    let locations: [ObjectLocations] = [startLocation] + people + activities
    
    objectLocations = locations
    
    
    let permutations = people.permutations(ofCount: people.count).map { Array($0) }
    var possibleRoutes = [[ObjectLocations]]()
    for a in activities {
      for p in permutations{
        let route:[ObjectLocations] = [startLocation] + p + [a]
        possibleRoutes.append(route)
      }
      
    }
    findRoute(routes: possibleRoutes)
  }
  
  
  
  func findRoute(routes:[[ObjectLocations]]) {
    var shortestRoute:[ObjectLocations] = []
    var shortestLength: Double = 0
    for route in routes{
      var length: Double = 0
      for i in 1..<route.count{
        let previousLocation = route[i-1]
        let currentLocation = route[i]
            
        let currentCLLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let previousCLLocation = CLLocation(latitude: previousLocation.coordinate.latitude, longitude: previousLocation.coordinate.longitude)
        
        let distanceBetweenLocations = distance(from: previousCLLocation, to: currentCLLocation)
        length = length + distanceBetweenLocations
      }
      if (shortestLength == 0 || shortestLength > length){
        shortestLength = length
        shortestRoute = route
        
      }
    }
    print("shortestlength:", shortestLength)
    print("shortest route:", shortestRoute)
    
    //kelio vaizdavimas
    if shortestRoute.count > 1 {
        for i in 0..<shortestRoute.count-1 {
            let sourcePlacemark = MKPlacemark(coordinate: shortestRoute[i].coordinate)
            let destinationPlacemark = MKPlacemark(coordinate: shortestRoute[i+1].coordinate)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionsRequest = MKDirections.Request()
            directionsRequest.source = sourceMapItem
            directionsRequest.destination = destinationMapItem
            directionsRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionsRequest)
            directions.calculate { response, error in
                guard let route = response?.routes.first else {
                    if let error = error {
                        print("Error calculating route:", error.localizedDescription)
                    }
                    return
                }
                // nubrezia route
                self.mapView.addOverlay(route.polyline)
            }
        }
    }

    
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let polylineOverlay = overlay as? MKPolyline {
          let renderer = MKPolylineRenderer(overlay: polylineOverlay)
          renderer.strokeColor = UIColor.red
          renderer.lineWidth = 3
          return renderer
      }
      
      return MKOverlayRenderer(overlay: overlay)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  initialize()
    // setinu initiallocationa
   let initialLocation = CLLocation(latitude: 54.702593, longitude: 25.288330)
    mapView.centerToLocation(initialLocation)
    
    let vilniusCenter = CLLocation(latitude: 54.689040, longitude: 25.268674)
    let region = MKCoordinateRegion(
      center: vilniusCenter.coordinate,
      latitudinalMeters: 50000,
      longitudinalMeters: 60000)
    mapView.setCameraBoundary(
      MKMapView.CameraBoundary(coordinateRegion: region),
      animated: true)
    
    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
    mapView.setCameraZoomRange(zoomRange, animated: true)
    
    mapView.delegate = self
    
    mapView.register(
      LocationMarkerView.self,
      forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    
    mapView.addAnnotations(objectLocations)
  }
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension ViewController: MKMapViewDelegate {
  func mapView(
    _ mapView: MKMapView,
    annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl
  ) {
    guard let location = view.annotation as? ObjectLocations else {
      return
    }
    
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    location.mapItem?.openInMaps(launchOptions: launchOptions)
  }
}