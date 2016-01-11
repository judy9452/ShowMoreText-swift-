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
    let screenHeight = UIScreen.mainScreen().bounds.height
    let screenWidth  = UIScreen.mainScreen().bounds.width
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "举个🌰"
        self.view.backgroundColor = UIColor.whiteColor()
        self.addSubView()
        self.initData()
    }
    
    func addSubView(){
        mTableView = UITableView(frame:CGRectMake(0, 0, screenWidth, screenHeight), style:UITableViewStyle.Plain)
        mTableView?.dataSource = self;
        mTableView?.delegate = self;

        mTableView?.tableFooterView = UIView()
        self.view.addSubview(mTableView!)
    }
    
    func initData(){
        let path:String = NSBundle.mainBundle().pathForResource("TextInfo", ofType: "json")!
        let nsData:NSData! = NSData(contentsOfURL: NSURL(fileURLWithPath: path))
        let json:AnyObject! = try? NSJSONSerialization.JSONObjectWithData(nsData, options: NSJSONReadingOptions.AllowFragments)
        let resultArr:AnyObject = json.objectForKey("textList")!
        for var dict in resultArr as! [[String: AnyObject]]
        {
            let entity = TextEntity(dict: dict)
            self.dataArr.append(entity)
        }
        
        
    }
        // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier: String = "TextListCellIdentifier"
        var cell: TextListCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? TextListCell
        
        if cell == nil
        {
            cell = TextListCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        if dataArr.count > indexPath.row
        {
            let model: TextEntity? = dataArr[indexPath.row] as? TextEntity
             cell!.entity = model
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.myClosure = myClosure
        return cell!
    }
    
        // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
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
    
    func myClosure(cell:UITableViewCell)->Void
    {
        let indexRow:NSIndexPath = (mTableView?.indexPathForCell(cell))!
        mTableView?.reloadRowsAtIndexPaths([indexRow], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
}

