//
//  MovieDetail.swift
//  tableViewWidget
//
//  Created by Marcelo Garcia on 04/10/16.
//  Copyright © 2016 Marcelo Garcia. All rights reserved.
//

import UIKit

class MovieDetail: NSObject {
        public private(set) var code: String?
        public private(set) var year: String?
        public private(set) var title: String?
        public private(set) var typeMovie: String?
        public private(set) var poster: String?
        
        
        required public init(map: Mapper) throws {
            code  = map.optionalFrom(field: "imdbID")
            year  = map.optionalFrom(field: "Year")
            title = map.optionalFrom(field: "Title")
            typeMovie = map.optionalFrom(field: "Type")
            poster = map.optionalFrom(field: "Poster")
        }
}
