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
    var cl : CLGeocoder!
    var pre : String = "なし"
    
    @IBOutlet weak var address_field: UILabel!
    
    var annotationlist = Array<MKPointAnnotation>()
    
    @IBOutlet weak var con: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        japan_map.delegate = self
        con.layer.cornerRadius = 10.0
        
    }

    @IBOutlet weak var japan_map: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //リスナーをアタッチ
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // ...
        }
        
        geocode(_address: "埼玉県ふじみ野市中福岡10-22")
        
    }
    
    func geocode(_address : String){
        cl = CLGeocoder()
//    let address = "埼玉県ふじみ野市中福岡10-22"
    cl.geocodeAddressString(_address) { placemarks, error in
        if let lat = placemarks?.first?.location?.coordinate.latitude {
            print("緯度 : \(lat)")
        }
        if let lng = placemarks?.first?.location?.coordinate.longitude {
            print("経度 : \(lng)")
        }
    }
    }
    
    func revgeocode(_lat : Double, _long : Double) -> String{
        let location = CLLocation(latitude: _lat, longitude: _long)
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else { return }
            // あとは煮るなり焼くなり
            let s : String = "なし"
            print("どこかな\(placemark)")
            print("どこかな\(placemark.administrativeArea)")
            print("どこかな\(type(of:placemark.administrativeArea))")
            if placemark.administrativeArea! != nil{
                let defaults = UserDefaults.standard
                defaults.setValue(placemark.administrativeArea!, forKey: "都道府県")
                self.address_field.text = placemark.administrativeArea!
//                self.pre = placemark.administrativeArea!
            }
            
        }
        return self.pre
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
        print("都道府県\(self.revgeocode(_lat : Double(self.latitude), _long : Double(self.longitude)))")
//        defaults.set(self.revgeocode(_lat : Double(self.latitude), _long : Double(self.longitude)), forKey: "都道府県")
    }
    
}
