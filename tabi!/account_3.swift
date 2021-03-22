//
//  account_3.swift
//  tabi!
//
//  Created by 藤元彩花 on 2021/03/22.
//

import Foundation
import UIKit

class account_3: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var date: UIPickerView!
    @IBOutlet weak var time: UIDatePicker!
    let compos = [["1日目","2日目"]]
    
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
    }

    @IBAction func changetime(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                
        print(formatter.string(from: sender.date)+"眠い")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        date.delegate = self
        date.dataSource = self
    }
    @IBOutlet weak var title_textfield: UITextField!
}
