//
//  account_3.swift
//  tabi!
//
//  Created by 藤元彩花 on 2021/03/22.
//

import Foundation
import UIKit

class account_3: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var date: UIPickerView!
    @IBOutlet weak var time: UIDatePicker!
    let compos = [["1日目","2日目"]]
    var plan_array:[[String]] = []
    
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
        plan_array.append([,"a"])
    }
}
