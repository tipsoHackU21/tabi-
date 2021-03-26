
import UIKit
import Foundation
import UIKit

import GoogleSignIn
import FirebaseAuth
import FirebaseDatabase
import Firebase


// テーブルビューに表示するデータ
let sectionTitle = ["チョウ目", "バッタ目", "コウチュウ目"]
let section0 = [("キタテハ","タテハチョウ科"),("クロアゲハ","アゲハチョウ科")]
let section1 = [("キリギリス","キリギリス科"),("ヒナバッタ","バッタ科"),("マツムシ","マツムシ科")]
let section2 = [("ハンミョウ","ハンミョウ科"),("アオオサムシ","オサムシ科"),("チビクワガタ","クワガタムシ科")]
let tableData2 = [section0, section1, section2]

class home: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // テーブルビューを作る
//        let myTableView:UITableView!
//        myTableView = UITableView(frame: view.frame, style: .grouped)
        // テーブルビューのデリゲートを設定する
        myTableView.delegate = self
        // テーブルビューのデータソースを設定する
        myTableView.dataSource = self
        // テーブルビューを表示する
        view.addSubview(myTableView)
    }
    
    /*　UITableViewDataSourceプロトコル */
    // セクションの個数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }

    // セクションごとの行数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData2[section]
        return sectionData.count
    }

    // セクションのタイトルを決める
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

    // セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        let sectionData = tableData2[(indexPath as NSIndexPath).section]
//        let cellData = sectionData[(indexPath as NSIndexPath).row]
//        cell.textLabel?.text = cellData.0
//        cell.detailTextLabel?.text = cellData.1
//        return cell
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell {
//                 return cell
//             }
//             return UITableViewCell()
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? UITableViewCell else {
                    fatalError("Dequeue failed: AnimalTableViewCell.")
                }
        let sectionData = tableData2[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        return cell
    }

    /* UITableViewDelegateデリゲートメソッド */
    // 行がタップされると実行される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = sectionTitle[indexPath.section]
        let sectionData = tableData2[indexPath.section]
        let cellData = sectionData[indexPath.row]
        print("\(title)\(cellData.1)")
        print("\(cellData.0)")
        
        
        
        
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "home2") as! home2
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        print("猫です")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            if let indexPath = myTableView.indexPathForSelectedRow {
                guard let destination = segue.destination as? home2 else {
                    fatalError("Failed to prepare DetailViewController.")
                }
                print(indexPath.row)
                //destination.animal = animals[indexPath.row]
            }
        }
    }

}

