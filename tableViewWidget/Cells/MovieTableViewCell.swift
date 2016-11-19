//
//  MovieTableViewCell.swift
//  tableViewWidget
//
//  Created by Marcelo Garcia on 04/10/16.
//  Copyright © 2016 Marcelo Garcia. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var typeMovie: UILabel!
    @IBOutlet weak var yearMovie: UILabel!
    
    func loadMovieCell(movie:Movie){
        titleMovie.text = movie.title
        typeMovie.text = movie.typeMovie
        yearMovie.text = movie.year
        
        DispatchQueue.global().async {
            let url = NSURL(string: movie.poster!)
            let data = NSData(contentsOf: url! as URL)
            DispatchQueue.main.async {
                self.imageMovie?.image = UIImage(data: data! as Data)
            }
        }
    }
}
