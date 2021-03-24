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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titletextfield.delegate = self
        input_title = false
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        //ユーザーのプラン追加
//        self.ref.child("Plans").childByAutoId().setValue(["PlanUser" : userID, "Plannners" : [userID], "Places" : "なし", "When" : "なし", "Schedule" : "なし", "Comment" : "なし"])
        guard let key = ref.child("Plans").childByAutoId().key else { return }
        let plan_data = ["Plantheme" : "なし", "PlanUser" : userID, "Plannners" : [userID], "Places" : "なしししし", "When" : "なし", "Schedule" : "なし", "Comment" : "なし"] as [String : Any]
        let childUpdates_plan = ["/Plans/\(key)/" : plan_data]
        ref.updateChildValues(childUpdates_plan)
        //ユーザーにプラン追加
        
        //あとで変える
        let plan_user = ["2" : key] as [String : Any]
        let childUpdates_user = ["/Users/\(userID)/MyPlans/\(key)/" : plan_user]
        ref.updateChildValues(childUpdates_user)
       
    }
    
    
    
    var input_title = false
    var ref: DatabaseReference!

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
        }
    }
}
