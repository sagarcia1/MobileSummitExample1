//
//  MovieDetailClient.swift
//  tableViewWidget
//
//  Created by Marcelo Garcia on 04/10/16.
//  Copyright © 2016 Marcelo Garcia. All rights reserved.
//

import UIKit

protocol MovieDetailDelegate {
    func successDetail(response: MovieDetail)
}

class MovieDetailClient: NSObject {
    var delegate:MovieDetailDelegate?
    func getMovies(id:String) {
        let myUrl = NSURL(string:"http://www.omdbapi.com/?i=\(id)")
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    let movieDetail = try MovieDetail(map: Mapper(json: convertedJsonIntoDict))
                    self.delegate?.successDetail(response:movieDetail)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
}
