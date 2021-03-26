
import UIKit
import Foundation
import UIKit

import GoogleSignIn
import FirebaseAuth
import FirebaseDatabase
import Firebase


// テーブルビューに表示するデータ
//let sectionTitle = ["チョウ目", "バッタ目", "コウチュウ目"]
//let section0 = [("キタテハ","タテハチョウ科"),("クロアゲハ","アゲハチョウ科")]
let section1 = [("キリギリス","キリギリス科"),("ヒナバッタ","バッタ科"),("マツムシ","マツムシ科")]
let section2 = [("ハンミョウ","ハンミョウ科"),("アオオサムシ","オサムシ科"),("チビクワガタ","クワガタムシ科")]


//let tableData2 = [section0, section1, section2]

var tableData4 = [[("キタテハ","タテハチョウ科"),("クロアゲハ","アゲハチョウ科"),("あ", "い")]]


class home: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    //データベース
    var ref: DatabaseReference!
    var userName = Auth.auth().currentUser?.displayName
    fileprivate var _refHandle: DatabaseHandle!
    var messages: [DataSnapshot] = []
    
    // テーブルビューに表示するデータ
    let sectionTitle = ["作成中のプラン"]
    var section0 = [("キタテハ","タテハチョウ科")]
    
    let my_suggestTableView = UITableView(frame: CGRect(x:50,y:280,width:414,height:542), style: .grouped)
    
    
//    @IBOutlet weak var my_suggestTableView: UITableView!
    
//    var my_suggestTableView = UITableView(frame: CGRect(x:50,y:280,width:414,height:542), style: .grouped)
    
    @IBAction func appear(_ sender: Any) {
//        self.tableView.reloadData()
        // データの更新
        tableData4 = [section0]


        // テーブルビューのデリゲートを設定する
            my_suggestTableView.delegate = self
        // テーブルビューのデータソースを設定する
            my_suggestTableView.dataSource = self
        
        
        if(my_suggestTableView.isHidden==false){
            // テーブルビューを表示する
            view.addSubview(my_suggestTableView)
            my_suggestTableView.isHidden = !my_suggestTableView.isHidden
            print("\(tableData4)ああ")
            
        }else{
            print("猫です")
            print("\(tableData4)")
            //tap = false
            my_suggestTableView.isHidden = !my_suggestTableView.isHidden
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        ref = Database.database().reference()
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        //プラン一覧を表示したい
        tableData4 = [section0]
        configureDatabase()
        tableData4 = [section0]
    }
    


    //データベース確認
    func configureDatabase() {
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
    // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("Users/\(userID)/MyPlans").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
            // プランをsection0に追加する
            self!.section0 = []
            strongSelf.messages.append(snapshot)
            print("個数 : \(strongSelf.messages.count)")
            var count = 0
            while count < strongSelf.messages.count {
                print("どうですかね")
                guard let x = strongSelf.messages[count].value as? String else { return }
                self!.section0.append((x, "プラン"))
                count += 1
            }
            print("どうですかああ\(self!.section0)")
            print("どうですかああ\(type(of : self!.section0))")
            
            
        })
        print("表示してくれええええええ\(self.messages)")
        
  }
    
    


    /*　UITableViewDataSourceプロトコル */
    // セクションの個数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }

    // セクションごとの行数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            let sectionData = tableData4[section]
            print("\(sectionData.count)ああああああああ")
            return sectionData.count
            print("行数\(messages.count)")
    //        return messages.count
    }

    // セクションのタイトルを決める
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

    // セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.my_suggestTableView .dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        _ = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            let sectionData = tableData4[(indexPath as NSIndexPath).section]
    //        let sectionData = "セクション"
            let cellData = sectionData[(indexPath as NSIndexPath).row]
            
            cell.textLabel?.text = cellData.0
            cell.detailTextLabel?.text = cellData.1
        print("セルの中身\(cell.textLabel!.text )")
            return cell
    }

    /* UITableViewDelegateデリゲートメソッド */
    // 行がタップされると実行される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = sectionTitle[indexPath.section]
        let sectionData = tableData4[indexPath.section]
        let cellData = sectionData[indexPath.row]
//        let cellData = messages[indexPath.row]
        print("\(title)\(cellData.1)")
        print("\(cellData.0)")
    }
    

}

