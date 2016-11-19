//
//  DetailViewController.swift
//  tableViewWidget
//
//  Created by Marcelo Garcia on 04/10/16.
//  Copyright © 2016 Marcelo Garcia. All rights reserved.
//

import UIKit

class DetailViewController: ViewController {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var yearMovie: UILabel!
    @IBOutlet weak var typeMovie: UILabel!
    
    var movieDetail:MovieDetail?
    var idMovie: String? = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData(idMovie: idMovie!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadData(idMovie:String){
        let movieDetailClient = MovieDetailClient()
        movieDetailClient.delegate = self
        movieDetailClient.getMovies(id: String(idMovie))
    }
}

extension DetailViewController:MovieDetailDelegate {
    func successDetail(response: MovieDetail) {
        movieDetail = response
        populateView(movieDetail: movieDetail!)
    }
    
    func populateView(movieDetail:MovieDetail){
        titleMovie.text = movieDetail.title
        yearMovie.text = movieDetail.year
        typeMovie.text = movieDetail.typeMovie
        
        DispatchQueue.global().async {
            let url = NSURL(string: movieDetail.poster!)
            let data = NSData(contentsOf: url! as URL)
            DispatchQueue.main.async {
                self.imageMovie?.image = UIImage(data: data! as Data)
            }
        }
        
    }
}
