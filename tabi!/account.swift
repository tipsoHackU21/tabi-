import UIKit
import Foundation
import FirebaseAuth
import MapKit
class account: UIViewController,MKMapViewDelegate {

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
        annotationlist.append(annotation)
        japan_map.addAnnotation(annotation)
    }
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
    
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView?{
        let pinView = MKPinAnnotationView()
        pinView.canShowCallout = true
        
        pinView.animatesDrop = true
        pinView.isDraggable = true
        pinView.pinTintColor = UIColor.blue
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(buttonEvent(_:)),for:UIControl.Event.touchUpInside)
        pinView.rightCalloutAccessoryView = button
        //pinView.canShowCallout = true
        return pinView
    }
    
    //    ピンの中のiマークを押したときの処理
        @objc func buttonEvent(_ sender: UIButton) {
            let storyboard: UIStoryboard = self.storyboard!
                   // ②遷移先ViewControllerのインスタンス取得
                   let nextView = storyboard.instantiateViewController(withIdentifier: "account_2") as! account_2
                   // ③画面遷移
                   self.present(nextView, animated: true, completion: nil)


        }
    

    @IBAction func removeLastPin(_ sender: Any) {
        if(annotationlist.count>0){
            let lastPin = annotationlist.removeLast()
            japan_map.removeAnnotation(lastPin)
        }
    }
    

}

var handle: AuthStateDidChangeListenerHandle?

