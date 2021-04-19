
import UIKit

class SearchRestaurantViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var selectedRestaurant: Restaurant!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CustomTableViewCell
        cell.restName.text = Restaurants[indexPath.row].nameRestaurant
        cell.restDesc.text = Restaurants[indexPath.row].descriptionRestaurant
        cell.star.rating = Double(Restaurants[indexPath.row].rate)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurant = Restaurants[indexPath.row]
        self.performSegue(withIdentifier: "searchToRestaurantDetailSegue", sender: self)
    }
    
    var searchText = ""
    var db:DBHelper = DBHelper()
    var Restaurants : [Restaurant] = []
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        self.Restaurants = db.read()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(tapGestureRecognizer:)))
       view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.Restaurants = db.read()
        tableview.reloadData()
    }
    @objc func tapped(tapGestureRecognizer: UITapGestureRecognizer) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        let point = tapGestureRecognizer.location(in: self.tableview)
        let indexPath = tableview.indexPathForRow(at: point)
        
        if indexPath != nil {
            tableView(self.tableview, didSelectRowAt: indexPath!)
        } else {
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToRestaurantDetailSegue" {
            if segue.destination is RestaurantDetailViewController {
                (segue.destination as! RestaurantDetailViewController).restaurant = selectedRestaurant
            }
        }
    }
}
extension SearchRestaurantViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
  
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        //  searchQuestion = questions.filter({$0.text == searchText})
        self.searchText =  searchText
        if searchText.count >= 2
        {
           
            Restaurants = Restaurants.filter { $0.tagsRestaurant.localizedCaseInsensitiveContains(searchText) || $0.tagsRestaurant.contains(searchText) || $0.nameRestaurant.localizedCaseInsensitiveContains(searchText) || $0.nameRestaurant.contains(searchText)
            }
            
            tableview.reloadData()
                   
                  
                
                           
                     
        }else{
            Restaurants = listRestaurants
            tableview.reloadData()
        }
                       
                   
        

    }
   
}
