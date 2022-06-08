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

enum DownloadError : Error {
    case wrongUrl
    case unload
    case unbuild
}

struct StaticAppData{
    let listsBySearchKey = [
        "turkeySongs" : [
            "Bul Beni",
            "Bilmem mi?",
            "Alaz Alaz",
            "Blinding Lights",
            "Ariyorum",
            "Dunyanin En Guzel Kizi",
            "Pare",
            "1 gr eksik",
            "Easy On Me",
            "Kim",
            "Bonita",
            "Bad Habits",
            "You Right",
        ],
        "turkeySongsExpanded" : [
            "Bul Beni",
            "Bilmem mi?",
            "Alaz Alaz",
            "Blinding Lights",
            "Ariyorum",
            "Dunyanin En Guzel Kizi",
            "Pare",
            "1 gr eksik",
            "Easy On Me",
            "Kim",
            "Bonita",
            "Bad Habits",
            "You Right",
            "Sevmedim Deme",
            "Seveni Bul Da Gel",
            "late at night",
            "Retrograde(Galantis Remix)",
            "Gravity Glidin",
            "Astronaut in The Ocean",
            "Higher Power",
            "EveryTime I Cry",
            "By Your Side",
            "Marlon Brando",
            "Our Song",
            "Kanunlar Gibi",
            "Affet beni sevgilim",
            "Sezenler olmuş",
            "Cindy",
            "Paranoya",
            "Krvn",
            "ölebilirim",
            "Yangen kızar",
            "Tatlıyla Bağla",
            "Sensizlik yarim",
        ],
        "usaSongs" : [
            "pushin P",
            "Do we have a problem?",
            "super gremlin",
            "we don't talk about bruno",
            "hrs and hrs",
            "don't play that",
            "p power",
            "knife talk",
            "ciggarettes",
            "surface pressure",
            "i hate u",
            "cold december",
            "lost",
        ],
        "usaSongsExpanded" : [
            "pushin P",
            "Do we have a problem?",
            "super gremlin",
            "we don't talk about bruno",
            "hrs and hrs",
            "don't play that",
            "p power",
            "knife talk",
            "ciggarettes",
            "surface pressure",
            "i hate u",
            "cold december",
            "lost",
            "broadway girls",
            "25k jacket",
            "she's all i wanna be",
            "the family madrigal",
            "me or sum",
            "who want smoke??",
            "kingpen ghostwriter",
            "easy on me",
            "heat waves",
            "way 2 sexy",
            "fingers crossed",
        ],
        "globalSongs" : [
            "Do We Have A Problem?",
            "she's all i wanna be",
            "Super Gremlin",
            "We don't talk about bruno",
            "hrs and hrs",
            "STAY",
            "don't play that",
            "cigarettes",
            "Easy On Me",
            "P power",
            "abcdefu",
            "Heat Waves",
            "Lost",
        ],
        "globalSongsExpanded" : [
            "Do We Have A Problem?",
            "she's all i wanna be",
            "Super Gremlin",
            "We don't talk about bruno",
            "hrs and hrs",
            "STAY",
            "don't play that",
            "cigarettes",
            "Easy On Me",
            "P power",
            "abcdefu",
            "Heat Waves",
            "Lost",
            "Surface Pressure",
            "i hate u",
            "shivers",
            "knife talk",
            "cold heart(PNAU Remix)",
            "Fingers Crossed",
            "Bad Habits",
            "INDUSTRY BABY",
            "oh my god",
            "blinding lights",
            "woman",
        ]
    ]
}
