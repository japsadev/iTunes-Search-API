//
//  Double + Ext.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.12.2022.
//

import SwiftUI

extension Double {
    var responsiveW: Double { return (UIScreen.main.bounds.size.width * self) / 100}
    var responsiveH: Double { return (UIScreen.main.bounds.size.height * self) / 100}
}
