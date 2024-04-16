//
//  FeedCell.swift
//  PrimoApp
//
//  Created by Perm on 15/4/2567 BE.
//

import Foundation
import UIKit
import SDWebImage

class FeedCell: UITableViewCell {
    
    var baseView    = UIView()
    var imgView   = UIImageView()
    var authorLb    = UILabel()
    var titleLb     = UILabel()
    var dateLb      = UILabel()
    var describeLb  = UILabel()
    
    func setCell(frame: CGRect, data: Feed) {
        self.selectionStyle = .none
        self.backgroundColor = .clear

        self.baseView.frame = CGRect(x: 2.5, y: 5, width: frame.width-5, height: frame.height-10)
        self.baseView.backgroundColor = .white
        self.baseView.layer.cornerRadius = 8
        self.baseView.layer.masksToBounds = true
        self.addSubview(self.baseView)
        
        self.imgView.frame = CGRect(x: 2.5, y: 2.5, width: self.baseView.width-5, height: (self.baseView.width-5-10)/2)
        self.imgView.sd_setImage(with: URL(string: data.image))
        self.imgView.contentMode = .scaleAspectFill
        self.imgView.layer.cornerRadius = 8
        self.imgView.layer.masksToBounds = true
        self.baseView.addSubview(self.imgView)
        
        self.authorLb.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.authorLb.backgroundColor = .white
        self.authorLb.text = data.creator
        self.authorLb.textColor = .black
        self.authorLb.textAlignment = .center
        self.authorLb.font = .systemFont(ofSize: 16)
        self.authorLb.numberOfLines = 1
        self.authorLb.adjustsFontSizeToFitWidth = true
        self.imgView.addSubview(self.authorLb)
        
        self.titleLb.frame = CGRect(x: 5, y: self.imgView.bottom+5, width: self.baseView.width-10, height: self.imgView.height)
        self.titleLb.text = data.title
        self.titleLb.textColor = .black
        self.titleLb.textAlignment = .left
        self.titleLb.font = .systemFont(ofSize: 24, weight: .heavy)
        self.titleLb.numberOfLines = 2
        self.titleLb.lineBreakMode = .byTruncatingTail
        self.titleLb.sizeToFit()
        self.baseView.addSubview(self.titleLb)
        
        self.dateLb.frame = CGRect(x: 5, y: self.baseView.height-2.5-20, width: self.baseView.width-10, height: 20)
        self.dateLb.text = data.pubDate
        self.dateLb.textColor = .gray
        self.dateLb.textAlignment = .right
        self.dateLb.font = .systemFont(ofSize: 12)
        self.dateLb.numberOfLines = 1
        self.dateLb.adjustsFontSizeToFitWidth = true
        self.baseView.addSubview(self.dateLb)
        
        self.describeLb.frame = CGRect(x: 5, y: self.titleLb.bottom+5, width: self.baseView.width-10, height: self.dateLb.y-self.titleLb.bottom-10)
        self.describeLb.text = data.content
        self.describeLb.textColor = .black.withAlphaComponent(0.8)
        self.describeLb.textAlignment = .left
        self.describeLb.font = .systemFont(ofSize: 16, weight: .light)
        self.describeLb.numberOfLines = 0
        self.describeLb.lineBreakMode = .byTruncatingTail
        self.baseView.addSubview(self.describeLb)
        
    }
}
