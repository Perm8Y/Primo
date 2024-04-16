//
//  FeedManager.swift
//  PrimoApp
//
//  Created by Perm on 15/4/2567 BE.
//

import Foundation

class FeedManager {
    
    static let shared   = FeedManager()
    static let feedPath = "https://medium.com/feed/@primoapp"
    
    let saveUrl = URL.documentsDirectory.appending(path: "feedLocal")

    
    var feedData = [Feed]()
    

    
    //MARK: load new
    func load(completion: @escaping()->Void) {

        guard let url = URL(string: FeedManager.feedPath) else { return }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                print("FeedDownloader start with error: \(error.localizedDescription)")
            }
            
            guard let data = data else { return }
            guard let string = String(data: data, encoding: .utf8) else { return }

            //split each topic
            let splitedArray = string.components(separatedBy: "<item>")
            
            //remove old
            self.feedData.removeAll()
            
            //create feed data
            for topic in splitedArray {
                if topic.contains("content:encoded") {
                    let lineArray = topic.components(separatedBy: "\n")
                    let feed = Feed(feedStrArr: lineArray)
                    self.feedData.append(feed)
                    
                    for item in lineArray {
                        print(item)
                        print("_______________________________")
                    }
                }
            }

            //save
            self.save(self.feedData)
            
            completion()

        }.resume()
    }
    
    //MARK: local check
    func checkData() -> Bool {
        if FileManager.default.fileExists(atPath: self.saveUrl.path) {
            return true
        }
        return false
    }
    
    //MARK: local load
    func getLocalData(compleion: ()->Void) {
        guard let rawData = try? Data(contentsOf: self.saveUrl) else { return }
        guard let data = try? JSONDecoder().decode([Feed].self, from: rawData) else { return }
        self.feedData = data
        compleion()
    }
    
    //MARK: local save
    func save(_ rawData: [Feed]) {
        guard let data = try? JSONEncoder().encode(rawData) else { return }
        if self.checkData() == true {
            try? FileManager.default.removeItem(atPath: self.saveUrl.path)
        }
        
        do {
            try data.write(to: self.saveUrl)
        }
        catch {
            print("error: \(error)")
        }
    }
}
