import Foundation
import UIKit

class account_2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        print("どうかな\(defaults.string(forKey: "last_latitude"))")
        
    }
    
   
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    
    @IBAction func propose(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "account_3") as! account_3
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    

}
