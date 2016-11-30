//
//  TextListCell.swift
//  ShowMoreText
//
//  Created by juanmao on 15/12/8.
//  Copyright © 2015年 juanmao. All rights reserved.
//

import UIKit
let screenHeight = UIScreen.main.bounds.height
let screenWidth  = UIScreen.main.bounds.width
    ///类似oc中的typedef
typealias showMoreTextClosure = (_ cell:UITableViewCell)->Void
class TextListCell: UITableViewCell {
    var textTitle:UILabel!
    var textContent:UILabel!
    var moreTextBtn:UIButton!
    var entity:TextEntity!
        ///声明一个闭包
    var myClosure:showMoreTextClosure?
    
    static func cellDefaultHeight(_ entity:TextEntity)->CGFloat{
        return 85.0
    }
    
    static func cellMoreHeight(_ entity:TextEntity)->CGFloat{
        let attribute = [NSFontAttributeName:UIFont.systemFont(ofSize: 16)]
        let option:NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin
        let text: NSString = NSString(cString: entity.textContent!.cString(using: String.Encoding.utf8)!,
            encoding: String.Encoding.utf8.rawValue)!
        let frame:CGRect = text.boundingRect(with: CGSize(width: screenWidth-30, height: 3000), options: option, attributes: attribute, context: nil)
        return frame.size.height+50;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textTitle = UILabel(frame: CGRect(x: 15, y: 5, width: 140, height: 20))
        textTitle.textColor = UIColor.black
        textTitle.font = UIFont.systemFont(ofSize: 18)
        self.contentView.addSubview(textTitle)
        
        textContent = UILabel(frame: CGRect(x: 15, y: 30,width: screenWidth - 30 , height: 20))
        textContent.textColor = UIColor.black
        textContent.font = UIFont.systemFont(ofSize: 16)
        textContent.numberOfLines = 0
        self.contentView.addSubview(textContent)
        
        moreTextBtn = UIButton(type: UIButtonType.custom)
        moreTextBtn.setTitleColor(UIColor.gray, for: UIControlState())
        moreTextBtn.frame = CGRect(x: screenWidth - 50, y: 5, width: 40, height: 20)
        self.contentView.addSubview(moreTextBtn)
        moreTextBtn.addTarget(self, action: #selector(TextListCell.showMoreText), for: UIControlEvents.touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textTitle.text = entity.textName
        textContent.text = entity.textContent
        
        if entity.isShowText == true
        {
            let attribute = [NSFontAttributeName:textContent.font]
            let option:NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin
            let text: NSString = NSString(cString: entity.textContent!.cString(using: String.Encoding.utf8)!,
                encoding: String.Encoding.utf8.rawValue)!
            let frame:CGRect = text.boundingRect(with: CGSize(width: screenWidth-30, height: 3000), options: option, attributes: attribute, context: nil)
            let height = frame.size.height
            textContent.frame = CGRect(x: 15, y: 30, width: screenWidth-30, height: height)
            moreTextBtn.setTitle("收起", for: UIControlState())
        }
        else
        {
            moreTextBtn.setTitle("展开", for: UIControlState())
            textContent.frame = CGRect(x: 15, y: 30, width: screenWidth - 30, height: 35)
        }
    }
    
    func showMoreText()
    {
        entity.isShowText = !entity.isShowText
        if (myClosure != nil){
            myClosure!(self)
        }
    }
}
