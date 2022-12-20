//
//  String + Ext.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.12.2022.
//

import Foundation

extension String {
    func keyToLocalizedValue() -> String {
        NSLocalizedString(self, comment: "key to localized value")
    }
}
