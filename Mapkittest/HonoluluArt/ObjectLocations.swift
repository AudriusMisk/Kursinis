import Foundation
import MapKit
import Contacts

class ObjectLocations: NSObject, MKAnnotation {
  
  override var description: String{
    return title ?? "0"
  }
  
  enum LocationType: String {
    case starting = "Starting"
    case person = "Person"
    case activity = "Activity"
    
  }
  
  let title: String?
  let locationType: LocationType
  let coordinate: CLLocationCoordinate2D
  
  init(
    title: String?,
    locationType: LocationType,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationType = locationType
    self.coordinate = coordinate
    
    super.init()
  }
  
//  init?(feature: MKGeoJSONFeature) {
//    // 1
//    guard
//      let point = feature.geometry.first as? MKPointAnnotation,
//      // 2
//      let propertiesData = feature.properties,
//      let json = try? JSONSerialization.jsonObject(with: propertiesData),
//      let properties = json as? [String: Any]
//      else {
//        return nil
//    }
//
//    // 3
//    title = properties["title"] as? String
//    locationName = properties["location"] as? String
//    discipline = properties["discipline"] as? String
//    coordinate = point.coordinate
//    super.init()
//  }
  
  var subtitle: String? {
    return locationType.rawValue
  }
  
  var mapItem: MKMapItem? {
//    guard let location = locationName else {
//      return nil
//    }
    
//    let addressDict = [CNPostalAddressStreetKey: location]
    let placemark = MKPlacemark(
      coordinate: coordinate)
//      addressDictionary: addressDict)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    return mapItem
  }
  
  var markerTintColor: UIColor  {
    switch locationType{
    case .starting:
      return .red
    case .activity:
      return .yellow
    case .person:
      return .blue
//    default:
//      return .green
    }
  }
  
  var image: UIImage {
 //   guard let name = discipline else { return #imageLiteral(resourceName: "Flag") }
    
    switch locationType {
    case .starting:
      return #imageLiteral(resourceName: "Monument")
    case .person:
      return #imageLiteral(resourceName: "Sculpture")
    case .activity:
      return #imageLiteral(resourceName: "Plaque")
 //   default:
 //     return #imageLiteral(resourceName: "Flag")
    }
  }
}

