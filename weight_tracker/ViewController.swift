import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var weights : [Weight] = []
    
    // creating color
    let morningColor = UIColor(displayP3Red: 128/255, green: 212/255, blue: 255/255, alpha: 1)
    let noonColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 153/255, alpha: 1)
    let eveningColor = UIColor(displayP3Red: 191/255, green: 191/255, blue: 191/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "addweight") as! AddWeightViewController
        self.navigationController?.pushViewController(secondViewController, animated: false)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // get data from core data
        getData()
        
        // reload tableview
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return weights.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //showing latest first
        let weight = weights[weights.count - (indexPath.row+1)]
        
        let weightTrue = String(round(Double((weight.currentweight!))! * 10)/10)
        cell.textweight.text = weightTrue + " Kg"
        cell.textdate.text = weight.datestamp
        cell.textemoji.text = allocateEmoji(DayTime: weight.daytime!)
        
        //changing cell color according to daytime
        if weight.daytime! == "Morning" {
            cell.contentView.backgroundColor = morningColor
        } else if weight.daytime! == "Noon" {
            cell.contentView.backgroundColor = noonColor
        }else {
            cell.contentView.backgroundColor = eveningColor
        }
        
        return cell
        
    }
    
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            weights = try context.fetch(Weight.fetchRequest())
        }
        catch{
            print ("Fetching Error")
        }
    }
    
    func allocateEmoji(DayTime day:String) -> String {
        
        if day == "Morning" { return "🌝"}
        else if day == "Noon" { return "🌞"}
        else { return "🌚"}
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let weight = weights[weights.count - (indexPath.row+1)]
            context.delete(weight)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                weights = try context.fetch(Weight.fetchRequest())
            }
            catch{
                print("Fetching error")
            }
            
            tableView.reloadData()
            
        }
    }

    
    
}

