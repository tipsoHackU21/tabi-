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
    var button_array:[UIButton] = []
    var i = 0
    //var count:Int = 0

    var annotationlist = Array<MKPointAnnotation>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        japan_map.delegate = self
        pins()
        
        print(annotationlist.count)
//        while(i<2){
//            print(annotationlist[i].coordinate.latitude)
//            i=i+1
//        }
        
    }
    @IBOutlet weak var japan_map: MKMapView!
    
//    @IBAction func LongPress(_ sender: UILongPressGestureRecognizer) {
//        guard sender.state == UIGestureRecognizer.State.ended else {
//            return
//        }
//
//        let presspoint = sender.location(in: japan_map)
//        let pressCoordinate = japan_map.convert(presspoint, toCoordinateFrom: japan_map)
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = pressCoordinate
//        annotation.title = "ここ!"
//
//
//        print("どこだい\(annotation.coordinate.latitude)")
//        print("どこだい\(annotation.coordinate.longitude)")
//
//        annotationlist.append(annotation)
//        japan_map.addAnnotation(annotation)
//
//        self.addPlace(_lat: annotation.coordinate.latitude, _long: annotation.coordinate.longitude)
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //リスナーをアタッチ
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // ...
        }
        
        //pins()
        print("どうかな")
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
        let zero:CLLocationDegrees = 0

        

        pinView.animatesDrop = true
        pinView.isDraggable = true
        pinView.pinTintColor = UIColor.blue
        //button_array.append(UIButton(type: .detailDisclosure))
        let button = UIButton(type: .detailDisclosure)
        //button.setTitle(annotationlist[i].title, for: .normal)
        i=i+1
        button.addTarget(self, action: #selector(buttonEvent(_:)),for:UIControl.Event.touchUpInside)
        //self.navigationItem.rightBarButtonItem = button
        pinView.rightCalloutAccessoryView = button
        button_array.append(button)
        //pinView.canShowCallout = true
        print("ボタン何個？\(button_array.count)")

        //print("ピンの数\(annotationlist.count)")
        return pinView

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
//            print("neko")
            print(button_array[i].currentTitle)
//            print(annotationlist[i].title)
            //print(button_array[i].currentTitle ?? "ないねー")

            let defaults = UserDefaults.standard
            defaults.set(annotationlist[i].coordinate.latitude, forKey: "last_latitude")
            defaults.set(annotationlist[i].coordinate.longitude, forKey: "last_longtitude")
        }

//            wait(0.5)


            i=i+1;
        }
        

//        while(i<annotationlist.count){
//
//            print(annotationlist[i].coordinate.latitude)
//            i=i+1;
//
//        }
        
        

        var j=0
        while(j<button_array.count){
            print("ボタン"+String(j)+":"+button_array[j].currentTitle!)
            j=j+1
        }
        
        j=0
        
        while(j<annotationlist.count){
            print("アノテーション"+String(j)+":"+annotationlist[j].title!)
            j=j+1
        }
            
            
            
            
            
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
        guard let userID = Auth.auth().currentUser?.uid else { return }
        //Destinationsから配列を作る
        _refHandle = self.ref.child("Destinations/").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
                strongSelf.messages = []
                strongSelf.messages.append(snapshot)
    
            var count = 0
            while count < strongSelf.messages.count{
                if strongSelf.messages.count > count {
//                    print("\(count)ばんめ -> \(strongSelf.messages[count])")
                    let PinData = strongSelf.messages[count].value as? [String : AnyObject] ?? [:]
//                    print("pinデータ\(PinData)")
//                    print("pinデータタイプ\(type(of:PinData))")
                    //配列にコメント 緯度経度追加
                    strongSelf.PinsData.append(PinData)
//                    let presspoint:CGPoint
//                    presspoint.x = CGFloat(PinData["latitude"] as! CLLocationDegrees)
//                    presspoint.y = CGFloat(PinData["longitude"] as! CLLocationDegrees)
                    


                    
                    //そのままデータ追加
                    let annotation = MKPointAnnotation()
                    annotation.title = PinData["Plantheme"] as? String

                    annotation.coordinate.latitude = PinData["latitude"] as! CLLocationDegrees
                    annotation.coordinate.longitude = PinData["longitude"] as! CLLocationDegrees

                    let zero:CLLocationDegrees = 0

                    if(annotation.coordinate.latitude != zero || annotation.coordinate.longitude != zero){
                    strongSelf.annotationlist.append(annotation)
                    strongSelf.japan_map.addAnnotation(annotation)
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                }
                count += 1
            }
            print("ピン何個？\(self!.annotationlist.count)")
            //print("ボタン何個？\(self?.button_array.count)")

            Thread.sleep(forTimeInterval: 0.3)
            
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

