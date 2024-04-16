//
//  FeedModel.swift
//  PrimoApp
//
//  Created by Perm on 15/4/2567 BE.
//

import Foundation

struct Feed: Codable {
    var title   : String    = ""
    var link    : String    = ""
    var category: [String]  = []
    var creator : String    = ""
    var pubDate : String    = ""
    var updated : String    = ""
    var image   : String    = ""
    var content : String    = ""
    
    init(title: String, link: String, category: [String], creator: String, pubDate: String, updated: String, content: String) {
        self.title = title
        self.link = link
        self.category = category
        self.creator = creator
        self.pubDate = pubDate
        self.updated = updated
        self.content = content
    }
    
    init(feedStrArr: [String]) {

        for feedStr in feedStrArr {
            if feedStr.contains("<title>") {
                self.title = self.getStringContent(feedStr)
            }
            else if feedStr.contains("<link>") {
                self.link = self.getStringContent(feedStr)
            }
            else if feedStr.contains("<category>") {
                self.category.append(self.getStringContent(feedStr))
            }
            else if feedStr.contains("<dc:creator>") {
                self.creator = self.getStringContent(feedStr)
            }
            else if feedStr.contains("<pubDate>") {
                self.pubDate = self.getStringContent(feedStr)
            }
            else if feedStr.contains("<atom:updated>") {
                self.updated = self.getStringContent(feedStr)
            }
            else if feedStr.contains("<p>") {
                if self.title == "อะไรคือสิ่งที่ลูกค้าต้องการจาก Personalized Marketing" {
                    print(feedStr)
                }
                let subContentArr = feedStr.components(separatedBy: "</figure>")
                if let rawImgStr = subContentArr.first, rawImgStr.contains("figure") {
//                    print("rawImgStr: \(rawImgStr)")
                    self.image =  self.getStringContent(rawImgStr)
                }
                if let rawContent = subContentArr.last {
                    let rawString =  self.getStringContent(rawContent)
                    self.content = self.modString(rawString)
                }
            }
        }
    }
    
    private func getStringContent(_ allString: String) -> String {
        if allString.contains("figure") { //image
            guard let firstbound = allString.range(of: "http")?.lowerBound else { return "" }
            var lastbound: String.Index? {
                if allString.contains("png") {
                    return allString.range(of: "png")?.upperBound
                }
                else if allString.contains("jpeg") {
                    return allString.range(of: "jpeg")?.upperBound
                }
                else if allString.contains("jpg") {
                    return allString.range(of: "jpg")?.upperBound
                }
                return nil
            }
            guard let lastbound = lastbound else { return "" }
            return String(allString[firstbound..<lastbound])
        }
        else if allString.contains("<p>") { //content
            let arrTmp = allString.components(separatedBy: "<img")
            let arrTmp2 = arrTmp.first?.components(separatedBy: "อ้างอิง")
            guard let realContent = arrTmp2?.first else { return "" }
            return realContent
        }
        else if allString.contains("[") {
            guard var firstbound = allString.lastIndex(of: "[")  else { return "" }
            guard let lastbound  = allString.firstIndex(of: "]") else { return "" }
            firstbound = allString.index(after: firstbound)
            return String(allString[firstbound..<lastbound])
        }
        else {
            guard var firstbound = allString.firstIndex(of: ">") else { return "" }
            guard let lastbound  = allString.lastIndex(of: "<")  else { return "" }
            firstbound = allString.index(after: firstbound)
            return String(allString[firstbound..<lastbound])
        }
    }
    
    private func modString(_ str: String) -> String {
        var mod = str.replacingOccurrences(of: "<p>-", with: "")
        mod = mod.replacingOccurrences(of: "<p>", with: "")
        mod = mod.replacingOccurrences(of: "</p>", with: "")
        mod = mod.replacingOccurrences(of: "<strong>", with: "")
        mod = mod.replacingOccurrences(of: "</strong>", with: "")
        mod = mod.replacingOccurrences(of: "<blockquote>", with: "")
        mod = mod.replacingOccurrences(of: "</blockquote>", with: "")
        return mod
    }
}
