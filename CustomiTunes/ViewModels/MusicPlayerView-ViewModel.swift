//
//  MusicPlayerView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import Foundation
import SwiftUI

@MainActor class MusicPlayerViewModel: ObservableObject{
    @Published var isPlayed: Bool = false
    @Published var isFavorite: Bool = false
    
    let imageContentSize: CGFloat = 75.0.responsiveW
    let imagePlaceholderSize: CGFloat = 75.0.responsiveW
}
