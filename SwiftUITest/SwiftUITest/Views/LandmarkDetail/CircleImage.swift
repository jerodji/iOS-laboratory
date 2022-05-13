//
//  turtlerock.swift
//  gite
//
//  Created by CN210208396 on 2022/5/9.
//

import SwiftUI

struct CircleImage: View {
    
    var image: Image
    
    var body: some View {
        image
            .renderingMode(.original)
            .resizable(resizingMode: .stretch)
            .frame(width: 200.0, height: 200.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: 10))
            .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("33"))
            .previewLayout(.sizeThatFits)
            
    }
}
