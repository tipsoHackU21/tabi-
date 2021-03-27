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

var sectiontitle:[String] = ["1日目","2日目"]//"チョウ目", "バッタ目", "コウチュウ目"]
var section_0:[(String,String)] = []
var section_1:[(String,String)] = [] //[("キリギリス","キリギリス科"),("ヒナバッタ","バッタ科"),("マツムシ","マツムシ科")]
var section_2:[(String,String)] = [] //[("ハンミョウ","ハンミョウ科"),("アオオサムシ","オサムシ科"),("チビクワガタ","クワガタムシ科")]
var tableData3:[[(String,String)]] = [section_0, section_1, section_2]


class account_3: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var date: UIPickerView!
    @IBOutlet weak var time: UIDatePicker!
//    @IBOutlet weak var end_time: UIDatePicker!
    @IBOutlet weak var action_textfield: UITextField!
    
    @IBOutlet weak var plan_table: UITableView!
    
    let compos = [sectiontitle]
    var plan_array:[[String]] = []
    var ref: DatabaseReference!
    
    
    // セルのオブジェクトを格納する配列
    var cellArray : NSMutableArray = NSMutableArray.init()
    
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

    @IBAction func starttime(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"//"yyyy/MM/dd HH:mm:ss"
        let defaults = UserDefaults.standard
        defaults.set(formatter.string(from: sender.date),forKey:"start_time")
        print(formatter.string(from: sender.date)+"眠い")
    }
    @IBAction func endtime(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"//"yyyy/MM/dd HH:mm:ss"
        let defaults = UserDefaults.standard
        defaults.set(formatter.string(from: sender.date),forKey:"end_time")
        print(formatter.string(from: sender.date)+"エンドタイム！")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.delegate = self
        date.dataSource = self
        title_textfield.delegate = self
        plan_table.delegate = self
        plan_table.dataSource = self
        action_textfield.delegate = self
        title_textfield.tag = 0
        action_textfield.tag = 1
        
        
    }
    @IBOutlet weak var title_textfield: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let defaults = UserDefaults.standard
        if textField.tag == 0{
            defaults.set(title_textfield.text!,forKey:"plan_title")
        }else{
            defaults.set(action_textfield.text!,forKey: "action")
        }
        
        // キーボードを下げる
        view.endEditing(true)
        return false // 改行は入力しない
    }
    @IBAction func add_button(_ sender: Any) {
        if !title_textfield.text!.isEmpty && !action_textfield.text!.isEmpty{
        let com = title_textfield.text!
        let defaults = UserDefaults.standard
        let date = defaults.string(forKey: "date")
        let start_time = defaults.string(forKey: "start_time")
        let end_time = defaults.string(forKey: "end_time")
        let action = defaults.string(forKey: "action")
        self.setData(_Comment : com, _Places : "場所", _Pref : "都道府県", _Speci : "行きたい場所", _lat : 2.3, _long : 3.4, _start_time : start_time!, _end_time : end_time!, _action : "行動", _day : date!)
        let tmp_str = start_time!+"-"+end_time!//+" "+action!
        
        print(date!)
        
            if(date! == "1日目"){
                section_0.append((tmp_str,action!))
            }else{
                section_1.append((tmp_str,action!))
            }
//        self.plan_table.beginUpdates()
//        self.plan_table.insertRows(at: [IndexPath(row: 0, section: 0)],
//                                  with: .automatic)
//        self.plan_table.endUpdates()
        
//        // 新たに追加するセルを配列に格納する
//               let cell : TableViewCell = TableViewCell.initFromNib()
//               cell.cellTitleLabel?.text = "\(self.cellArray.count + 1).新しい項目"
//               self.cellArray.add(cell)
               
            //section_0.reloadData()
            tableData3 = [section_0, section_1, section_2]
               // テーブルビューをリロードする
            self.plan_table.reloadData()
            
        }
    }
    
    //suggestPlanを作る
    //Comment,Places,Schedule,isSelected,maker
    func setData(_Comment : String, _Places : String, _Pref : String, _Speci : String, _lat : Double, _long : Double, _start_time : String, _end_time : String, _action : String, _day : String){
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        //keyを生成
        guard let key = self.ref.child("suggestPlans").childByAutoId().key else { return }
        //Comment,Places,Schedule,isSelected,makerを追加
        let places = ["Prefecture" : _Pref,
                      "Specific" : _Speci,
                      "latitude" : _lat,
                      "longitude" : _long] as [String : Any]
        let schedules = ["start_time": _start_time,
                         "end_time": _end_time,
                         "action": _action,
                         "place": _Places,
                         "day": _day]
        self.ref.child("/suggestPlans/\(key)").setValue(["Comment" : _Comment,
                                                         "Places" : places,
                                                         "Schedule" : schedules,
                                                         "isSelected" : 0,
                                                         "maker" : userID])
        
        //give plan
        
        let defaults = UserDefaults.standard
        let set_gift = [ "\(defaults.string(forKey :"Planuser")!)" : ["\(defaults.string(forKey :"suggestPlanID")!)" : [ _Comment :"\(key)" ]]]
        self.ref.child("/giftPlans").updateChildValues(set_gift)
    }
    
    
    
    /*　UITableViewDataSourceプロトコル */
    // セクションの個数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectiontitle.count
    }

    // セクションごとの行数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.cellArray.count
        let sectionData = tableData3[section]
        return sectionData.count
    }

    // セクションのタイトルを決める
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectiontitle[section]
    }

    // セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData3[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1

        return cell
//        return self.cellArray.object(at: indexPath.row) as! TableViewCell
        
    

    }

    /* UITableViewDelegateデリゲートメソッド */
    // 行がタップされると実行される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = sectiontitle[indexPath.section]
        let sectionData = tableData3[indexPath.section]
        let cellData = sectionData[indexPath.row]
        print("\(title)\(cellData.1)")
        print("\(cellData.0)")
    }
    
}


