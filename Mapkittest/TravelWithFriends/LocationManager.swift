import MapKit
import CoreLocation

class LocationManager {

  static func makeSearchRegion() -> MKCoordinateRegion {

    let vilniusCenter = CLLocation(latitude: 54.689040, longitude: 25.268674)
    let region = MKCoordinateRegion(
      center: vilniusCenter.coordinate,
      latitudinalMeters: 5000,
      longitudinalMeters: 5000)

    return region
  }

//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    guard let firstLocation = locations.first else {
//      return
//    }
//
//    let commonDelta: CLLocationDegrees = 25 / 111 // 1/111 = 1 latitude km
//    let span = MKCoordinateSpan(latitudeDelta: commonDelta, longitudeDelta: commonDelta)
//    let region = MKCoordinateRegion(center: firstLocation.coordinate, span: span)
//
//    currentRegion = region
//    completer.region = region
//
//    CLGeocoder().reverseGeocodeLocation(firstLocation) { places, _ in
//      guard let firstPlace = places?.first, self.originTextField.contents == nil else {
//        return
//      }
//
//      self.currentPlace = firstPlace
//      self.originTextField.text = firstPlace.abbreviation
//    }
//  }
//
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    bowlingButton.addTarget(self, action: #selector(bowlingClicked), for: .touchUpInside)
//    cinemaButton.addTarget(self, action: #selector(cinemaClicked), for: .touchUpInside)
//    poolButton.addTarget(self, action: #selector(poolClicked), for: .touchUpInside)
//  //initialize()
//    // setinu initiallocationa
//   let initialLocation = CLLocation(latitude: 54.702593, longitude: 25.288330)
//    mapView.centerToLocation(initialLocation)
//
//    let vilniusCenter = CLLocation(latitude: 54.689040, longitude: 25.268674)
//    let region = MKCoordinateRegion(
//      center: vilniusCenter.coordinate,
//      latitudinalMeters: 50000,
//      longitudinalMeters: 60000)
//    mapView.setCameraBoundary(
//      MKMapView.CameraBoundary(coordinateRegion: region),
//      animated: true)
//
//    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
//    mapView.setCameraZoomRange(zoomRange, animated: true)
//
//    mapView.delegate = self
//
//    mapView.register(
//      LocationMarkerView.self,
//      forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//
//   // mapView.addAnnotations(objectLocations)
//  }

}
