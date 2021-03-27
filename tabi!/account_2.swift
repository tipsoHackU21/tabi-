import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

class account_2: UIViewController {
    
    @IBOutlet weak var PlanTitle: UILabel!
    @IBOutlet weak var Recruiter: UILabel!
    @IBOutlet weak var Where: UILabel!
    @IBOutlet weak var HowLong: UILabel!
    var ref: DatabaseReference!
    fileprivate var _refHandle: DatabaseHandle!
//    var storageRef: StorageReference! = Storage.storage().reference()
//    var profile = ["Comment" : "0", "PlanUser" : "0", "Plantheme" : "0", "Schedule" : "0", "When" : "0", "Plannners" : "0"]
    var profile = ["Comment" : "0"]
    
    var PlanID : String = "なし"
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("どうかな\(defaults.string(forKey: "last_latitude")!)")
        print("どうかな\(defaults.string(forKey: "last_longtitude")!)")
        print("どうかな\(defaults.string(forKey: "suggestPlanID")!)")
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.PlanID = defaults.string(forKey: "suggestPlanID")!
        self.PlanSet(_planid : self.PlanID)
        print("埼玉\(self.profile)")
        print("埼玉\(self.profile)")
        print("埼玉\(self.profile)")
        print("埼玉\(self.profile)")
    }
    
   
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    
    @IBAction func propose(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "account_3") as! account_3
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //planIDから　タイトル,募集者,目的地,何泊かをセット
    func PlanSet(_planid : String){
        ref = Database.database().reference()
        print("kyanokoです")
        
        _refHandle = self.ref.child("Plans/\(_planid)").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
//                print("汚物1\(snapshot)")
//                print("汚物2\(type(of:snapshot.value))")
//                print("汚物3\(type(of:snapshot.value!))")
//                print("汚物3\(snapshot.ref)")
//                print("汚物3\(type(of:snapshot.ref))")
                print("汚物4\(snapshot.key)")
            self!.profile["\(snapshot.key)"] = "\(snapshot.value!)"
            self!.PlanTitle.text = self!.profile["Plantheme"]
            self!.Recruiter.text = self!.profile["PlanUser"]
//            self!.Where.text = self!.profile["Plantheme"]
            self!.Where.text = "北海道"
//            self!.HowLong.text = self!.profile["Schedule"]
            self!.HowLong.text = "1泊2日"
            let defaults = UserDefaults.standard

            defaults.setValue(self!.profile["PlanUser"], forKey: "Planuser")
                
        })
        
       
        _refHandle = self.ref.child("Users/\(self.profile["PlanUser"])").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
            print("ああああああえええ\(snapshot)")
        })
        
    }
}
    


