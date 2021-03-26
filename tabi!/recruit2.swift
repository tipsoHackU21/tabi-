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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titletextfield.delegate = self
        input_title = false
        defaults.set(false, forKey: "isDecidePlace")
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if defaults.bool(forKey: "isDecidePlace") {
            print("latitude : \(defaults.float(forKey: "lat"))")
            print("longitude : \(defaults.float(forKey: "long"))")
        }
        
    }
    
    
    
    var input_title = false
    

    @IBOutlet weak var kanto: UIButton!
    @IBOutlet weak var hokkaido: UIButton!
    @IBOutlet weak var hokuriku: UIButton!
    @IBOutlet weak var con: UIButton!
   
    
    @IBAction func hokkaido_press(_ sender: Any) {
        hokkaido.isSelected = !hokkaido.isSelected
        if(kanto.isSelected){
            kanto.isSelected = !kanto.isSelected
        }
        if(hokuriku.isSelected){
            hokuriku.isSelected = !hokuriku.isSelected
        }
        
    }
    
    @IBAction func kanto_press(_ sender: Any) {
        kanto.isSelected = !kanto.isSelected
        if(hokuriku.isSelected){
            hokuriku.isSelected = !hokuriku.isSelected
        }
        if(hokkaido.isSelected){
            hokkaido.isSelected = !hokkaido.isSelected
        }
    }
    @IBAction func hokuriku_press(_ sender: Any) {
        hokuriku.isSelected = !hokuriku.isSelected
        if(hokkaido.isSelected){
            hokkaido.isSelected = !hokkaido.isSelected
        }
        if(kanto.isSelected){
            kanto.isSelected = !kanto.isSelected
        }
    }
    
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
        let defaults = UserDefaults.standard
        defaults.set(textField.text!,forKey:"title")
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
       
        if((!hokkaido.isSelected && !hokuriku.isSelected && !kanto.isSelected && !input_title) || titletextfield.text!.isEmpty){
            con.setTitle("すべて入力してください", for: .normal)
        }else{
            con.setTitle("確認", for: .normal)
            let tmp_string:String;
            if(hokuriku.isSelected){
                tmp_string="北陸"
            }else if(kanto.isSelected){
                tmp_string="関東"
            }else{
                tmp_string = "北海道"
            }
            let defaults = UserDefaults.standard
            defaults.set(tmp_string,forKey:"destination")
            
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "confirmpage")
            present(nextVC!, animated: true,completion: nil)
            
            //入力事項をセット
            print("ここに行きたい -> \(tmp_string)")
            print("ここに行きたい -> \(type(of: tmp_string))")
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
