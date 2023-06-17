import UIKit
import CoreLocation

class People {
  
  static var people:[ObjectLocations] = People.initializePersons()

//  init() {
//    people = People.initializePersons()
//  }

  static func initializePersons() -> [ObjectLocations] {
    let personOne = ObjectLocations(
      title: "Jonas",
      locationType: .person,
      coordinate: CLLocationCoordinate2D(latitude: 54.717594, longitude: 25.284990)
    )

    let personTwo = ObjectLocations(
      title: "Petras",
      locationType: .person,
      coordinate: CLLocationCoordinate2D(latitude: 54.712715, longitude: 25.303593)
    )

    let personThree = ObjectLocations(
      title: "Rimas",
      locationType: .person,
      coordinate: CLLocationCoordinate2D(latitude: 54.728395, longitude: 25.296547)
    )

    return [personOne, personTwo, personThree]
  }

  static func add(name: String, coordinate: CLLocationCoordinate2D) {
    let person = ObjectLocations(title: name, locationType: .person, coordinate: coordinate)
    people.append(person)
  }
}