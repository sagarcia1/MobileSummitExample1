//
//  MovielistClient.swift
//  tableViewWidget
//
//  Created by Marcelo Garcia on 04/10/16.
//  Copyright © 2016 Marcelo Garcia. All rights reserved.
//

import UIKit

protocol MovieListDelegate {
    func success(response: [Movie])
}

class MovielistClient: NSObject {
    var delegate:MovieListDelegate?
    func getMovies() {
        let myUrl = NSURL(string:"http://www.omdbapi.com/?s=Star%20Wars")
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
                    let collection = try MoviesList(map: Mapper(json: convertedJsonIntoDict))
                    self.delegate?.success(response: collection.list)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
}
