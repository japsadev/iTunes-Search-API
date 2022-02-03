//
//  Utils.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 29.01.2022.
//

import Foundation
import UIKit
import SwiftUI

extension Double{
    var responsiveW: Double { return (UIScreen.main.bounds.size.width * self) / 100}
    var responsiveH: Double { return (UIScreen.main.bounds.size.height * self) / 100}
}
