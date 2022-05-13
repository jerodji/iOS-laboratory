//
//  LandmarkRow.swift
//  SwiftUITest
//
//  Created by CN210208396 on 2022/5/9.
//

import SwiftUI

struct LandmarkRow: View {
    
    var landmark: Landmark
    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            Text(landmark.name)
            Spacer()
            
            if (landmark.isFavorite) {
                Image.init(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRow(landmark: landmarkData[0])
            
        
        
//        Group {
//            LandmarkRow(landmark: landmarkData[0])
//            //            .previewLayout(.sizeThatFits)
//
//            LandmarkRow(landmark: landmarkData[1])
//
//            LandmarkRow(landmark: landmarkData[2])
//
//        }.previewLayout(.fixed(width: 300, height: 70))

    }
}
