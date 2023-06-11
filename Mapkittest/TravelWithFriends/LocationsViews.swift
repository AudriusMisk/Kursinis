import Foundation
import MapKit

class LocationMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let location = newValue as? ObjectLocations else {
        return
      }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

      // 2
      markerTintColor = location.markerTintColor
      glyphImage = location.image
    }
  }
}

//class LocationView: MKAnnotationView {
//  override var annotation: MKAnnotation? {
//    willSet {
//      guard let location = newValue as? ObjectLocations else {
//        return
//      }
//
//      canShowCallout = true
//      calloutOffset = CGPoint(x: -5, y: 5)
//      let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
//      mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
//      rightCalloutAccessoryView = mapsButton
//
//      image = location.image
//
//      let detailLabel = UILabel()
//      detailLabel.numberOfLines = 0
//      detailLabel.font = detailLabel.font.withSize(12)
//      detailLabel.text = location.subtitle
//      detailCalloutAccessoryView = detailLabel
//    }
//  }
//}

