//
//  account_3.swift
//  tabi!
//
//  Created by 藤元彩花 on 2021/03/22.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class account_3: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var date: UIPickerView!
    @IBOutlet weak var time: UIDatePicker!
    let compos = [["1日目","2日目"]]
    var plan_array:[[String]] = []
    var ref: DatabaseReference!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return compos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let compo = compos[component]
        return compo.count
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = compos[component][row]
        return item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = compos[component][row]
        print(item)
        let defaults = UserDefaults.standard
        defaults.set(item,forKey:"date")
    }

    @IBAction func changetime(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"//"yyyy/MM/dd HH:mm:ss"
        let defaults = UserDefaults.standard
        defaults.set(formatter.string(from: sender.date),forKey:"plan_time")
        print(formatter.string(from: sender.date)+"眠い")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        date.delegate = self
        date.dataSource = self
        title_textfield.delegate = self
        
    }
    @IBOutlet weak var title_textfield: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let defaults = UserDefaults.standard
        defaults.set(title_textfield.text!,forKey:"plan_title")
        // キーボードを下げる
        view.endEditing(true)
        return false // 改行は入力しない
    }
    @IBAction func add_button(_ sender: Any) {
        self.setData(_Comment : "コメント", _Places : "場所", _Pref : "都道府県", _Speci : "行きたい場所", _lat : 2.3, _long : 3.4, _start_time : "2:50", _end_time : "3:00", _action : "行動", _day : 1)
    }
    
    //suggestPlanを作る
    //Comment,Places,Schedule,isSelected,maker
    func setData(_Comment : String, _Places : String, _Pref : String, _Speci : String, _lat : Double, _long : Double, _start_time : String, _end_time : String, _action : String, _day : Int){
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        //keyを生成
        guard let key = self.ref.child("suggestPlans").childByAutoId().key else { return }
        //Comment,Places,Schedule,isSelected,makerを追加
        let places = ["Prefecture" : "都道府県",
                      "Specific" : "場所名",
                      "latitude" : "緯度",
                      "longitude" : "経度"]
        let schedules = ["start_time": "開始時間",
                         "end_time": "終了時間",
                         "action": "行動",
                         "place": _Places,
                         "day": "何日目"]
        self.ref.child("/suggestPlans/\(key)").setValue(["Comment" : _Comment,
                                                         "Places" : places,
                                                         "Schedule" : schedules,
                                                         "isSelected" : 0,
                                                         "maker" : userID])
    }
    
}
