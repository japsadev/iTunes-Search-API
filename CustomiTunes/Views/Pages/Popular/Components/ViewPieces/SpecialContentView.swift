//
//  SpecialContentView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 29.01.2022.
//

import SwiftUI

struct SpecialContentView: View {
    let contentURL : URL
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 90.0.responsiveW, height: 55.0.responsiveW, alignment: .center)
                .foregroundColor(.primary.opacity(0.1))
                
            
            AsyncImage(url: self.contentURL) { image in
                image.resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 90.0.responsiveW, height: 55.0.responsiveW, alignment: .center)
                    .cornerRadius(10)
                    .shadow(radius: 4, x: 3, y: 10)
                    
            } placeholder: {
                ProgressView()
            }
        }
    }
}

struct SpecialContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialContentView(contentURL: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Features114/v4/01/e7/76/01e7760b-03e9-46c0-7579-0614e51db340/source/1000x611sr-60.jpg")!)
    }
}
