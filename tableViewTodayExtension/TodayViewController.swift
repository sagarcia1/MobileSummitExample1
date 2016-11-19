//
//  TodayViewController.swift
//  tableViewTodayExtension
//
//  Created by Marcelo Garcia on 10/4/16.
//  Copyright © 2016 Marcelo Garcia. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    var arrayMovies:[Movie] = [Movie]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        populateTableView()
    }
    
    func populateTableView(){
        let mc = MovielistClient()
        mc.delegate = self
        mc.getMovies()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @nonobjc func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        populateTableView()
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        self.preferredContentSize = activeDisplayMode == NCWidgetDisplayMode.compact ? maxSize : CGSize(width: 0, height: 110 * arrayMovies.count)
    }
    
}

extension TodayViewController:MovieListDelegate {
    func success(response: [Movie]) {
        arrayMovies = response
        reloadTableview()
    }
    
    func reloadTableview(){
        if let table = tableView {
            table.reloadData()
        }
    }
}

extension TodayViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrayMovies.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell
        cell?.loadMovieCell(movie: (arrayMovies[indexPath.row]))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < arrayMovies.count {
            let url = URL(string: "widget://movie?code=\(arrayMovies[indexPath.row].code!)")
            extensionContext?.open(url!, completionHandler: nil)
        }
    }
}

