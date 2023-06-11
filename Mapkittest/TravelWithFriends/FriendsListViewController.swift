import UIKit

class FriendsListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  let people = People.initializePersons()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    // Do any additional setup after loading the view.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows you want to display
    return people.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "People", for: indexPath) as! FriendTableViewCell
    cell.friendName?.text = people[indexPath.row].title
    cell.friendLocation?.text = people[indexPath.row].coordinate.longitude.description + " " + people[indexPath.row].coordinate.latitude.description
    return cell
  }
  
  // MARK: - UITableViewDelegate methods
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Handle row selection
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
