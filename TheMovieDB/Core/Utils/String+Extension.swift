//
//  String+Extension.swift
//  TheMovieDB
//
//  Created by alfian on 17/07/24.
//

import Foundation

extension String {
    func localized() -> String {
        let path = Bundle.main.path(forResource: Locale.current.languageCode, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle!, value: self, comment: self)
    }
}
