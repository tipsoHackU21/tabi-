import UIKit
import Foundation
import FirebaseAuth
import MapKit
import FirebaseDatabase

class recruit_map: UIViewController,MKMapViewDelegate {
    
    var ref: DatabaseReference!
    fileprivate var _refHandle: DatabaseHandle!
    var messages: [DataSnapshot] = []
    var PinsData : [Dictionary<String, AnyObject>] = []
    var button_array:[UIButton] = []
    var latitude : Float = 0.0
    var longitude : Float = 0.0

    var annotationlist = Array<MKPointAnnotation>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        japan_map.delegate = self
        
    }

    @IBOutlet weak var japan_map: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //リスナーをアタッチ
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // ...
        }
        
    }
    
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        //リスナーをデタッチ
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }
    
    @IBAction func LongPress(_ sender: UILongPressGestureRecognizer) {
            guard sender.state == UIGestureRecognizer.State.ended else {
                return
            }
    
            let presspoint = sender.location(in: japan_map)
            let pressCoordinate = japan_map.convert(presspoint, toCoordinateFrom: japan_map)
    
            let annotation = MKPointAnnotation()
            annotation.coordinate = pressCoordinate
            annotation.title = "ここ!"
    
    
            print("どこだい(annotation.coordinate.latitude)")
            print("どこだい(annotation.coordinate.longitude)")
    
            annotationlist.append(annotation)
            japan_map.addAnnotation(annotation)
        
        self.latitude = Float(annotation.coordinate.latitude)
        self.longitude = Float(annotation.coordinate.longitude)
    
            self.addPlace(_lat: annotation.coordinate.latitude, _long: annotation.coordinate.longitude)
        }
    

    //    ピンの中のiマークを押したときの処理
    @objc func buttonEvent(_ sender: UIButton) {
            /*let storyboard: UIStoryboard = self.storyboard!
                   // ②遷移先ViewControllerのインスタンス取得
                   let nextView = storyboard.instantiateViewController(withIdentifier: "account_2") as! account_2
                   // ③画面遷移
                   self.present(nextView, animated: true, completion: nil)*/
//            if(annotationlist[0].coordinate.latitude==888){
//                print(annotationlist[0].coordinate.latitude)
//            }
        var i=0;
        while(i<button_array.count){
        if(sender == button_array[i]){
            print("neko")
            print(button_array[i].currentTitle)
            print(annotationlist[i].title)
            //print(button_array[i].currentTitle ?? "ないねー")
        }
            i=i+1;
        }
            
            let defaults = UserDefaults.standard
            defaults.set(annotationlist[annotationlist.count-1].coordinate.latitude, forKey: "last_latitude")
            
            let second = storyboard?.instantiateViewController(withIdentifier: "account_2") as! account_2
            
            self.navigationController?.pushViewController(second, animated: true)


        }
    

    @IBAction func removeLastPin(_ sender: Any) {
        if(annotationlist.count>0){
            let lastPin = annotationlist.removeLast()
            japan_map.removeAnnotation(lastPin)
        }
    }
    
    
    //場所追加する時
    func addPlace(_lat : Double, _long : Double) -> Void {
        ref = Database.database().reference()
//        guard let userID = Auth.auth().currentUser?.uid else { return }

        self.ref.child("/Plans/Plan1/Places/latitude").setValue(_lat)
        self.ref.child("/Plans/Plan1/Places/longitude").setValue(_long)
        
    }
    
    @IBAction func Decide(_ sender: Any) {
        //recruit2に座標を伝える
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isDecidePlace")
        defaults.set(self.latitude, forKey: "lat")
        defaults.set(self.longitude, forKey: "long")
    }
    
}
