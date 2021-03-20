//
//  recruit.swift
//  tabi!
//
//  Created by 百塚真弥 on 2021/03/17.
//

import Foundation
import UIKit

import GoogleSignIn
import FirebaseAuth
//import FirebaseDatabase
import Firebase

import UIKit

//
//  ViewController.swift
//  insects_tableView
//
//  Created by yoshiyuki oshige on 2018/08/17.
//  Copyright © 2018年 yoshiyuki oshige. All rights reserved.
//

import UIKit

// テーブルビューに表示するデータ
let sectionTitle = ["チョウ目", "バッタ目", "コウチュウ目"]
let section0 = [("キタテハ","タテハチョウ科"),("クロアゲハ","アゲハチョウ科")]
let section1 = [("キリギリス","キリギリス科"),("ヒナバッタ","バッタ科"),("マツムシ","マツムシ科")]
let section2 = [("ハンミョウ","ハンミョウ科"),("アオオサムシ","オサムシ科"),("チビクワガタ","クワガタムシ科")]
let tableData = [section0, section1, section2]
let viewRect=CGRect(x:50,y:280,width:314,height:532)
// テーブルビューを作る
let myTableView = UITableView(frame: viewRect, style: .grouped)


class recruit: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //var tap = false
    

    @IBAction func appear(_ sender: Any) {
        
        // テーブルビューのデリゲートを設定する
            myTableView.delegate = self
            // テーブルビューのデータソースを設定する
            myTableView.dataSource = self
        
        
        
        if(myTableView.isHidden==false){
            // テーブルビューを表示する
            view.addSubview(myTableView)
            myTableView.isHidden = !myTableView.isHidden
        }else{
            print("猫です")
            //tap = false
            myTableView.isHidden = !myTableView.isHidden
        }
    }
    
    
    //@IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    /*　UITableViewDataSourceプロトコル */
    // セクションの個数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }

    // セクションごとの行数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData[section]
        return sectionData.count
    }

    // セクションのタイトルを決める
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

    // セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        return cell
    }

    /* UITableViewDelegateデリゲートメソッド */
    // 行がタップされると実行される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = sectionTitle[indexPath.section]
        let sectionData = tableData[indexPath.section]
        let cellData = sectionData[indexPath.row]
        print("\(title)\(cellData.1)")
        print("\(cellData.0)")
    }

}

//class recruit: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    let TODO = ["牛乳を買う", "掃除をする", "アプリ開発の勉強をする"]
//    @IBOutlet weak var test: UILabel!
//    @IBOutlet weak var table: UITableViewCell!
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return TODO.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // セルを取得する
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        print("表示するもの")
//        print(TODO[indexPath.row])
//        // セルに表示する値を設定する
//        cell.textLabel!.text = TODO[indexPath.row]
//        return cell
//    }
//
//
////    var ref: DatabaseReference! = Database.database().reference()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        var Username = Auth.auth().currentUser?.displayName
//        print("表示！")
//        print(TODO[0])
//
//    }
//
//}
//
