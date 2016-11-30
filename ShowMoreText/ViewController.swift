//
//  ViewController.swift
//  ShowMoreText
//
//  Created by juanmao on 15/12/8.
//  Copyright © 2015年 juanmao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var mTableView:UITableView?
    var dataArr:[AnyObject] = []
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth  = UIScreen.main.bounds.width
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "举个🌰"
        self.view.backgroundColor = UIColor.white
        self.addSubView()
        self.initData()
    }
    
    func addSubView(){
        mTableView = UITableView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), style:UITableViewStyle.plain)
        mTableView?.dataSource = self;
        mTableView?.delegate = self;

        mTableView?.tableFooterView = UIView()
        self.view.addSubview(mTableView!)
    }
    
    func initData(){
        let path:String = Bundle.main.path(forResource: "TextInfo", ofType: "json")!
        let nsData:Data! = try? Data(contentsOf: URL(fileURLWithPath: path))
        let json:AnyObject! = try? JSONSerialization.jsonObject(with: nsData, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject!
        let resultArr:AnyObject = json["textList"]! as AnyObject
        for var dict in resultArr as! [[String: AnyObject]]
        {
            let entity = TextEntity(dict: dict as NSDictionary)
            self.dataArr.append(entity)
        }
        
        
    }
        // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier: String = "TextListCellIdentifier"
        var cell: TextListCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TextListCell
        
        if cell == nil
        {
            cell = TextListCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        if dataArr.count > indexPath.row
        {
            let model: TextEntity? = dataArr[indexPath.row] as? TextEntity
             cell!.entity = model
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.myClosure = myClosure
        return cell!
    }
    
        // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let entity:TextEntity!
        if (dataArr.count > indexPath.row)
        {
            entity = (dataArr[indexPath.row] as? TextEntity)!
            if (entity.isShowText == true)
            {
                return TextListCell.cellMoreHeight(entity)
            }
            else
            {
                return TextListCell.cellDefaultHeight(entity)
            }
        }
        
        return 0.0
    }
    
    func myClosure(_ cell:UITableViewCell)->Void
    {
        let indexRow:IndexPath = (mTableView?.indexPath(for: cell))!
        mTableView?.reloadRows(at: [indexRow], with: UITableViewRowAnimation.automatic)
    }
}

