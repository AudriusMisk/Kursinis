import UIKit

protocol ReloadDelegate: AnyObject {
    func reload()
}

class FriendsListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!

  var people: [ObjectLocations] {
    return People.people
  }

  let segueIdentifier = "PresentEditVC"

  var itemId: UUID?
  var item: ObjectLocations?

  var actionType: EditViewController.ActionType = .add

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    // Create a UIBarButtonItem for the dismiss or back button
    let dismissButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissButtonTapped))

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

    // Add the dismiss or back button to the left side of the navigation bar
    navigationItem.leftBarButtonItem = dismissButton

    navigationItem.rightBarButtonItem = addButton
  }

//  override func viewDidAppear(_ animated: Bool) {
//    tableView.reloadData()
//  }
//
//  override func viewWillAppear(_ animated: Bool) {
//    tableView.reloadData()
//  }

  @objc func dismissButtonTapped() {
      dismiss(animated: true, completion: nil)
  }

  @objc func addButtonTapped() {
    actionType = .add
    performSegue(withIdentifier: segueIdentifier, sender: self)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == segueIdentifier {

        if let navigationController = segue.destination as? UINavigationController,
           let destinationVC = navigationController.topViewController as? EditViewController {
            // Customize the destination view controller here
//          destinationVC.objectLocationIdentifier = itemId
          destinationVC.actionType = actionType
          destinationVC.editableObject = item
          destinationVC.reloadDelegate = self
        }
      }
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows you want to display
    return people.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "People", for: indexPath) as! FriendTableViewCell
    cell.friendName?.text = people[indexPath.row].title
    cell.friendLocation?.text = people[indexPath.row].coordinate.latitude.description + " " + people[indexPath.row].coordinate.longitude.description
    return cell
  }
  
  // MARK: - UITableViewDelegate methods
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = people[indexPath.row]
    self.item = item

//    let id = item.id
//    itemId = id

    actionType = .edit
    performSegue(withIdentifier: segueIdentifier, sender: self)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension FriendsListViewController: ReloadDelegate {
  func reload() {
    tableView.reloadData()
  }
}
