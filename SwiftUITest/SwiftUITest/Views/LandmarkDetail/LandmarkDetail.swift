//
//  ContentView.swift
//  gite
//
//  Created by CN210208396 on 2022/5/8.
//

import SwiftUI

struct LandmarkDetail: View {
    
    var landmark: Landmark
    
    @EnvironmentObject var userdata: UserData
    var landmarkIndex: Int {
        userdata.landmarks.firstIndex(where: {$0.id == landmark.id})!
    }
    
    var body: some View {
        VStack {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)
//                .edgesIgnoringSafeArea(.top)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                        .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    
                    Button.init(action: {
                        self.userdata.landmarks[landmarkIndex].isFavorite.toggle()
                    }, label: {
                        if self.userdata.landmarks[landmarkIndex].isFavorite {
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star").foregroundColor(.gray)
                        }
                    })
                    
                    Spacer()
                }
                
                HStack {
                    Text(landmark.park)
                        .font(.subheadline)
                    Spacer()
                    Text(landmark.state).font(.subheadline)
                }

            }.padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(landmark.name), displayMode: .inline)
    }
}

func clickAction() -> Void {
    print(#function)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarkData[3])
    }
}
