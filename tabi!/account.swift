import UIKit
import Foundation
import FirebaseAuth
import MapKit
import FirebaseDatabase

class account: UIViewController,MKMapViewDelegate {
    
    var ref: DatabaseReference!
    fileprivate var _refHandle: DatabaseHandle!
    var messages: [DataSnapshot] = []
    var PinsData : [Dictionary<String, AnyObject>] = []
    // wherePin["title_lat_long"] = planID
    var wherePin : [Dictionary <String, String>] = [["あああ" : "いいい"]]

    var annotationlist = Array<MKPointAnnotation>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        japan_map.delegate = self
    }
    @IBOutlet weak var japan_map: MKMapView!
    
    @IBAction func LongPress(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == UIGestureRecognizer.State.ended else {
            return
        }
        
        let presspoint = sender.location(in: japan_map)
        let pressCoordinate = japan_map.convert(presspoint, toCoordinateFrom: japan_map)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = pressCoordinate
        annotation.title = "ここ!"
        
        print("どこだい\(annotation.coordinate.latitude)")
        print("どこだい\(annotation.coordinate.longitude)")
        
        annotationlist.append(annotation)
        japan_map.addAnnotation(annotation)
        
        self.addPlace(_lat: annotation.coordinate.latitude, _long: annotation.coordinate.longitude)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //リスナーをアタッチ
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // ...
        }
        
        pins()
        print("ああああああああああ\(annotationlist )")
        print("どうかな")
    }
    
    
    // ピンをタップした際に呼ばれるdelegate
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // どのピンがタップされたかを取得
        let title = view.annotation?.title!
        let subtitle = view.annotation?.subtitle!
        let lat = view.annotation!.coordinate.latitude
        let long = view.annotation!.coordinate.longitude
        print("タップした_\(subtitle!)")
        print("タップした_\(lat)")
        print("タップした_\(long)")
        
        let defaults = UserDefaults.standard
        defaults.setValue(subtitle!, forKey: "suggestPlanID")
        
        
//        let ci = self.wherePin["あああ"]
//        print(ci)
//        if let point = title{
//            let place =  point!
//            print("title : ",  title)
//        }
    }
    
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        //リスナーをデタッチ
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }
    
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView?{
        let pinView = MKPinAnnotationView()
        pinView.canShowCallout = true
        
        //pinView.animatesDrop = true
        //pinView.isDraggable = true
        pinView.pinTintColor = UIColor.blue
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(buttonEvent(_:)),for:UIControl.Event.touchUpInside)
        //self.navigationItem.rightBarButtonItem = button
        pinView.rightCalloutAccessoryView = button
        //pinView.canShowCallout = true
        
        return pinView
    }
    
    //    ピンの中のiマークを押したときの処理
        @objc func buttonEvent(_ sender: UIButton) {
            /*let storyboard: UIStoryboard = self.storyboard!
                   // ②遷移先ViewControllerのインスタンス取得
                   let nextView = storyboard.instantiateViewController(withIdentifier: "account_2") as! account_2
                   // ③画面遷移
                   self.present(nextView, animated: true, completion: nil)*/
            
            let defaults = UserDefaults.standard
            defaults.set("x", forKey: "y")
            
            let second = storyboard?.instantiateViewController(withIdentifier: "account_2") as! account_2
            
            self.navigationController?.pushViewController(second, animated: true)


        }
    

    @IBAction func removeLastPin(_ sender: Any) {
        if(annotationlist.count>0){
            let lastPin = annotationlist.removeLast()
            japan_map.removeAnnotation(lastPin)
        }
    }
    
    //ピンを表示
    func pins(){
        ref = Database.database().reference()
        self.messages = []
        guard let userID = Auth.auth().currentUser?.uid else { return }
        //Destinationsから配列を作る
        _refHandle = self.ref.child("Destinations/").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
//                strongSelf.messages = []
                strongSelf.messages.append(snapshot)
    
            var count = 0
            while count < strongSelf.messages.count{
                if strongSelf.messages.count > count {
                    print("\(count)ばんめ -> \(strongSelf.messages[count])")
                    let PinData = strongSelf.messages[count].value as? [String : AnyObject] ?? [:]
                    print("pinデータ\(PinData)")
                    print("pinデータタイプ\(type(of:PinData))")
                    strongSelf.PinsData = []
                    //配列にコメント 緯度経度追加
                    strongSelf.PinsData.append(PinData)
                    //そのままデータ追加
                    let annotation = MKPointAnnotation()
                    if let x =  PinData["PlanID"] as? String{
                        annotation.subtitle = x
                    }
//                    annotation.subtitle = PinData["PlanID"] as? String
                    annotation.title = PinData["Plantheme"] as! String
                    annotation.coordinate.latitude = PinData["latitude"] as! CLLocationDegrees
                    annotation.coordinate.longitude = PinData["longitude"] as! CLLocationDegrees
                    strongSelf.annotationlist.append(annotation)
                    strongSelf.japan_map.addAnnotation(annotation)
    
                }
                count += 1
            }
            print("ピン何個？\(strongSelf.PinsData.count)")
            print("ピン？ -> \(strongSelf.PinsData)")

            
        })
    }
    
    //場所追加する時
    func addPlace(_lat : Double, _long : Double) -> Void {
        ref = Database.database().reference()
//        guard let userID = Auth.auth().currentUser?.uid else { return }

        self.ref.child("/Plans/Plan1/Places/latitude").setValue(_lat)
        self.ref.child("/Plans/Plan1/Places/longitude").setValue(_long)
        
    }
    

}

var handle: AuthStateDidChangeListenerHandle?

