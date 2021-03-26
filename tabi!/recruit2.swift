//
//  recruit2.swift
//  tabi!
//
//  Created by 藤元彩花 on 2021/03/20.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import MapKit
import SwiftUI

/*import GoogleSignIn
import FirebaseAuth
//import FirebaseDatabase
import Firebase*/






class recruit2 : UIViewController, UITextFieldDelegate{
    @IBOutlet weak var titletextfield: UITextField!
    let defaults = UserDefaults.standard
    var latitude : Float = 0.0
    var longitude : Float = 0.0
    var ref: DatabaseReference!
    @IBOutlet weak var `where`: UILabel!
    @IBOutlet weak var night: UITextField!

    @IBOutlet weak var about: UITextView!
    //@IBOutlet weak var about: PlaceHolderTextView!
    @IBOutlet weak var schedule: UITextField!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titletextfield.delegate = self
        schedule.delegate = self
        input_title = false
        defaults.set(false, forKey: "isDecidePlace")

        schedule.tag = 1
        titletextfield.tag = 0
        
  

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.`where`.text = "お腹"
        if defaults.bool(forKey: "isDecidePlace") {
            print("latitude : \(defaults.float(forKey: "lat"))")
            print("longitude : \(defaults.float(forKey: "long"))")
            self.`where`.text = defaults.string(forKey: "都道府県")!
            print("都道府県\(defaults.string(forKey: "都道府県")!)")
        }
        if(defaults.bool(forKey: "isDecidePlace")){
            let t = CGRect(origin:CGPoint(x:180,y:250),size:CGSize(width:200,height:70))
            let japan_map = MKMapView(frame: t)
            let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(CGFloat(defaults.float(forKey: "lat"))), longitude: CLLocationDegrees(CGFloat(defaults.float(forKey: "long"))))
            let span = MKCoordinateSpan(latitudeDelta: 4.0, longitudeDelta: 4.0)
            let region = MKCoordinateRegion(center: center, span: span)
            japan_map.setRegion(region, animated: true)
            self.view.addSubview(japan_map)
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = "ここです！"
            japan_map.addAnnotation(annotation)
            print("ああーーーーーーーーーー")
            
                }
        
    }
    
    
    
    var input_title = false
   
    
    
    
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(22222)
        title = textField.text!
        self.view.endEditing(true) //キーボード閉じる
        print(33333)
        return true
    }*/
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(444444)
        let tmpstr = textField.text! as NSString
        
        return true
    }*/
    
    //画面のキーボードで入力して改行で終わらないと値が入らない
    // 改行が入力された（デリゲートメソッド）
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("タグ:"+String(textField.tag))
        
        //let defaults = UserDefaults.standard
        if(textField.tag == 0){
            defaults.set(textField.text!,forKey:"title")
        }else{
            defaults.set(textField.text!,forKey: "schedule")
        }
        input_title=true
        // キーボードを下げる
        view.endEditing(true)
        
        return false // 改行は入力しない
    }
    
    //募集地図を立てるための目的地データベース追加
    func addDestination(_lat : Double, _long : Double, _PlanID : String, _Plantheme : String) -> Void {
        
        guard (Auth.auth().currentUser?.uid) != nil else { return }

        self.ref.child("/Destinations/\(_PlanID)").setValue(["latitude" : _lat, "longitude" : _long, "Plantheme" : _Plantheme, "PlanID" : "\(_PlanID)"])
//        self.ref.child("/Destinations/\(_PlanID)").setValue(_long)
    }
    
    //目的地データベース追加
    func addPlans(_lat : Double, _long : Double, _PlanID : String, _Plantheme : String) -> Void {
        
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }

//        self.ref.child("/Users/\(userID)/MyPlans/").setValue(["\(_Plantheme)" :"\(_PlanID)"])
////        self.ref.child("/Destinations/\(_PlanID)").setValue(_long)
        let plan_user_data = "\(_Plantheme)" 
        let childUpdates_user_plan = ["/Users/\(userID)/MyPlans/\(_PlanID)" : plan_user_data]
        ref.updateChildValues(childUpdates_user_plan)
        
        
        let plan_data = ["Plantheme" : _Plantheme, "PlanUser" : userID, "Plannners" : [userID], "When" : "なし", "Schedule" : "なし", "Comment" : "なし"] as [String : Any]
        let childUpdates_plan = ["/Plans/\(_PlanID)/" : plan_data]
        ref.updateChildValues(childUpdates_plan)
    }
    
    
    
    
    
    
    
    @IBAction func confirm(_ sender: Any) {
       
        if titletextfield.text!.isEmpty || !defaults.bool(forKey: "isDecidePlace") || schedule.text!.isEmpty {
            con.setTitle("すべて入力してください", for: .normal)
        }else{
            con.setTitle("確認", for: .normal)

            let defaults = UserDefaults.standard

            
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "confirmpage")
//            present(nextVC!, animated: true,completion: nil)
            
            //入力事項をセット
            print("テーマ\(titletextfield.text!)")
            
            ref = Database.database().reference()
            
            guard let key = self.ref.child("Plans").childByAutoId().key else { return }
            
            self.latitude = Float(defaults.float(forKey: "lat"))
            self.longitude = Float(defaults.float(forKey: "long"))
            
            //ユーザーのプラン追加
            self.addPlans(_lat : Double(self.latitude), _long : Double(self.longitude), _PlanID : "\(key)", _Plantheme : titletextfield.text!)
            
            //ユーザーにプラン追加
            self.addDestination(_lat: Double(self.latitude), _long: Double(self.longitude), _PlanID: "\(key)", _Plantheme : titletextfield.text!)

        }
    }
}
