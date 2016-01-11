//
//  TextListCell.swift
//  ShowMoreText
//
//  Created by juanmao on 15/12/8.
//  Copyright © 2015年 juanmao. All rights reserved.
//

import UIKit
let screenHeight = UIScreen.mainScreen().bounds.height
let screenWidth  = UIScreen.mainScreen().bounds.width
    ///类似oc中的typedef
typealias showMoreTextClosure = (cell:UITableViewCell)->Void
class TextListCell: UITableViewCell {
    var textTitle:UILabel!
    var textContent:UILabel!
    var moreTextBtn:UIButton!
    var entity:TextEntity!
        ///声明一个闭包
    var myClosure:showMoreTextClosure?
    
    static func cellDefaultHeight(entity:TextEntity)->CGFloat{
        return 85.0
    }
    
    static func cellMoreHeight(entity:TextEntity)->CGFloat{
        let attribute = [NSFontAttributeName:UIFont.systemFontOfSize(16)]
        let option:NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let text: NSString = NSString(CString: entity.textContent!.cStringUsingEncoding(NSUTF8StringEncoding)!,
            encoding: NSUTF8StringEncoding)!
        let frame:CGRect = text.boundingRectWithSize(CGSizeMake(screenWidth-30, 3000), options: option, attributes: attribute, context: nil)
        return frame.size.height+50;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textTitle = UILabel(frame: CGRectMake(15, 5, 140, 20))
        textTitle.textColor = UIColor.blackColor()
        textTitle.font = UIFont.systemFontOfSize(18)
        self.contentView.addSubview(textTitle)
        
        textContent = UILabel(frame: CGRectMake(15, 30,screenWidth - 30 , 20))
        textContent.textColor = UIColor.blackColor()
        textContent.font = UIFont.systemFontOfSize(16)
        textContent.numberOfLines = 0
        self.contentView.addSubview(textContent)
        
        moreTextBtn = UIButton(type: UIButtonType.Custom)
        moreTextBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        moreTextBtn.frame = CGRectMake(screenWidth - 50, 5, 40, 20)
        self.contentView.addSubview(moreTextBtn)
        moreTextBtn.addTarget(self, action: "showMoreText", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textTitle.text = entity.textName
        textContent.text = entity.textContent
        
        if entity.isShowText == true
        {
            let attribute = [NSFontAttributeName:textContent.font]
            let option:NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
            let text: NSString = NSString(CString: entity.textContent!.cStringUsingEncoding(NSUTF8StringEncoding)!,
                encoding: NSUTF8StringEncoding)!
            let frame:CGRect = text.boundingRectWithSize(CGSizeMake(screenWidth-30, 3000), options: option, attributes: attribute, context: nil)
            let height = frame.size.height
            textContent.frame = CGRectMake(15, 30, screenWidth-30, height)
            moreTextBtn.setTitle("收起", forState: UIControlState.Normal)
        }
        else
        {
            moreTextBtn.setTitle("展开", forState: UIControlState.Normal)
            textContent.frame = CGRectMake(15, 30, screenWidth - 30, 35)
        }
    }
    
    func showMoreText()
    {
        entity.isShowText = !entity.isShowText
        if (myClosure != nil){
            myClosure!(cell: self)
        }
    }
}
