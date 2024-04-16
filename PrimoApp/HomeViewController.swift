//
//  ViewController.swift
//  PrimoApp
//
//  Created by Perm on 15/4/2567 BE.
//

import UIKit

class HomeViewController: UIViewController {

    var contentTbv  = UITableView()
    var refresher   = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUI()
        self.initData()
    }
    
    private func setUI() {
        self.view.backgroundColor = .black
        
        self.contentTbv.frame = CGRect(x: 5, y: top_safearea+10, width: screen_width-10, height: self.view.height-bottom_safearea-(top_safearea+10))
        self.contentTbv.backgroundColor = .clear
        self.contentTbv.separatorStyle = .none
        self.contentTbv.delegate = self
        self.contentTbv.dataSource = self
        self.contentTbv.showsVerticalScrollIndicator = false
        self.view.addSubview(self.contentTbv)
        
        self.refresher.tintColor = .white
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.contentTbv.addSubview(self.refresher)
    }
    
    private func initData() {
        //using local data (if exist)
        if FeedManager.shared.checkData() == true {
            FeedManager.shared.getLocalData {
                DispatchQueue.main.async {
                    self.contentTbv.reloadData()
                }
            }
        }
        
        //load new data for update
        self.loadData()
    }
    
    @objc func loadData() {
        FeedManager.shared.load {
            DispatchQueue.main.async {
                self.refresher.endRefreshing()
                self.contentTbv.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedManager.shared.feedData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.width
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FeedCell()
        if indexPath.row < FeedManager.shared.feedData.count {
            let data = FeedManager.shared.feedData[indexPath.row]
            cell.setCell(frame: CGRect(x: 0, y: 0, width: tableView.width, height: tableView.width), data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < FeedManager.shared.feedData.count {
            let data = FeedManager.shared.feedData[indexPath.row]
            if let link = URL(string: data.link) {
                let webVC = FeedWebViewController()
                webVC.setWebView(url: link)
                self.present(webVC, animated: true)
            }
        }
    }
    
}

