//
//  ViewController.swift
//  tableViewWidget
//
//  Created by Marcelo Garcia on 04/10/16.
//  Copyright © 2016 Marcelo Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var arrayMovies:[Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateTableView(){
        let mc = MovielistClient()
        mc.delegate = self
        mc.getMovies()
    }
    
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "detailSegue" == segue.identifier {
            let detailViewController:DetailViewController = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            detailViewController.idMovie? = arrayMovies[indexPath!.row].code!
        }
    }
}

extension ViewController: MovieListDelegate {
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

extension ViewController: UITableViewDelegate,UITableViewDataSource{
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
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
}
