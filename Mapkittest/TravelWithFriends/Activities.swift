import Foundation

import UIKit
import CoreLocation

class Activities {

  static var bowlings:[ObjectLocations] = initializeBowling()

  static var cinemas:[ObjectLocations] = initializeCinema()

  static var pools:[ObjectLocations] = initializePool()

  static func initializeBowling() -> [ObjectLocations] {
      let activityOne = ObjectLocations(
          title: "Boulingas Zirmunu",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.718300, longitude: 25.303018)
      )

      let activityTwo = ObjectLocations(
          title: "Boulingas Apollo",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.709838, longitude: 25.263310)
      )

      let activityThree = ObjectLocations(
          title: "Boulingas Amerigo",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.708014, longitude: 25.227058)
      )

      return [activityOne, activityTwo, activityThree]
  }

  static func initializeCinema() -> [ObjectLocations] {
      let activityOne = ObjectLocations(
          title: "Multikino",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.714477, longitude: 25.276945)
      )

      let activityTwo = ObjectLocations(
          title: "Pasaka",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.682785, longitude: 25.281301)
      )

      let activityThree = ObjectLocations(
          title: "Forum Cinemas",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.678441, longitude: 25.256302)
      )

      return [activityOne, activityTwo, activityThree]
  }

  static func initializePool() -> [ObjectLocations] {
      let activityOne = ObjectLocations(
          title: "Piramide",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.676423, longitude: 25.265149)
      )

      let activityTwo = ObjectLocations(
          title: "FUKSAS",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.687822, longitude: 25.275592)
      )

      let activityThree = ObjectLocations(
          title: "Cue",
          locationType: .activity,
          coordinate: CLLocationCoordinate2D(latitude: 54.696943, longitude: 25.298553)
      )

      return [activityOne, activityTwo, activityThree]
  }

  static func addBowling(name: String, coordinate: CLLocationCoordinate2D) {
    let person = ObjectLocations(title: name, locationType: .activity, coordinate: coordinate)
    bowlings.append(person)
  }

  static func addCinema(name: String, coordinate: CLLocationCoordinate2D) {
    let person = ObjectLocations(title: name, locationType: .activity, coordinate: coordinate)
    cinemas.append(person)
  }

  static func addPool(name: String, coordinate: CLLocationCoordinate2D) {
    let person = ObjectLocations(title: name, locationType: .activity, coordinate: coordinate)
    pools.append(person)
  }
}
