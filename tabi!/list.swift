//
//  list.swift
//  tabi!
//
//  Created by 藤元彩花 on 2021/03/26.
//

import Foundation
import UIKit

class list: UITableViewController {
    // セルに表示するデータ
    let webList = [
        (name:"アップル", url:"https://www.apple.com/jp/"),
        (name:"国立天文台", url:"https://www.nao.ac.jp"),
        (name:"東京都美術館", url:"http://www.tobikan.jp"),
        (name:"amazon", url:"https://www.amazon.co.jp")
    ]
    
    // MARK: - Table view data source
    // セクションの個数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セクション内の行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 配列webListの値の個数
        return webList.count
    }
    
    // セルを作る
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // テーブルのセルを参照する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // テーブルにWebListのデータを表示する
        let webData = webList[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = webData.name
        cell.detailTextLabel?.text = webData.url

        return cell
    }
    
    // MARK: - Navigation
    
    // セグエで移動する前にデータを受け渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // セグエがshowWebPageのときの処理
        if segue.identifier == "showWebPage" {
            // タップした行番号を取り出す
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // 行のデータを取り出す
                let webData = webList[(indexPath as NSIndexPath).row]
                // 移動先のビューコントローラのdataプロパティに値を設定する
                //(segue.destination as! ViewController).data = webData
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
