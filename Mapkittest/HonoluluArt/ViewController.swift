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
    
  }
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  initialize()
    // Set initial location in Vilnius
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
    
   // loadInitialData()
    mapView.addAnnotations(objectLocations)
  }
  
//  private func loadInitialData() {
//    // 1
//    guard
//      let fileName = Bundle.main.url(forResource: "PublicArt", withExtension: "geojson"),
//      let artworkData = try? Data(contentsOf: fileName)
//      else {
//        return
//    }
//
//    do {
//      // 2
//      let features = try MKGeoJSONDecoder()
//        .decode(artworkData)
//        .compactMap { $0 as? MKGeoJSONFeature }
//      // 3
//      let validWorks = features.compactMap(Artwork.init)
//      // 4
//      .append(contentsOf: validWorks)
//    } catch {
//      // 5
//      print("Unexpected error: \(error).")
//    }
//  }
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
