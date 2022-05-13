//
//  LandmarkList.swift
//  SwiftUITest
//
//  Created by CN210208396 on 2022/5/9.
//

import SwiftUI

struct LandmarkList: View {
    
    // tag 2
    /// 状态(State)是一个值或者一个值的集合，会随着时间而改变，同时会影响视图的内容、行为或布局。
    /// 在属性前面加上@State修饰词就是给视图添加了一个状态值
//    @State var showFavoritesOnly = true
    
    // 3, 需要从父类传入参数
    @EnvironmentObject var userdata: UserData
    
    var body: some View {
//        List {
//            LandmarkRow(landmark: landmarkData[0])
//            LandmarkRow(landmark: landmarkData[1])
//            LandmarkRow(landmark: landmarkData[2])
//        }
        
        NavigationView {
//            List(landmarkData, id: \.id) { landmark in
//                if (showFavoritesOnly) {
//                    NavigationLink.init(destination: LandmarkDetail(landmark: landmark)) {
//                        LandmarkRow(landmark: landmark)
//                    }
//                }
//            }
            
            // tag 2
//            List {
//                Toggle.init(isOn: $showFavoritesOnly) {
//                    Text("favorites only")
//                }
//
//                ForEach(landmarkData) { landmark in
//                    if !showFavoritesOnly || landmark.isFavorite {
//                        NavigationLink.init(destination: LandmarkDetail(landmark: landmark)) {
//                            LandmarkRow(landmark: landmark)
//                        }
//                    }
//                }
//            }
            
            // 3
             List {
                 Toggle.init(isOn: $userdata.showFavoritesOnly) {
                    Text("favorites only")
                }

                 ForEach(userdata.landmarks) { landmark in
                    if !userdata.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink.init(destination: LandmarkDetail(landmark: landmark)) {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            
            
            .navigationBarTitle(Text("Landmarks"))
        }
        
        
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandmarkList().environmentObject(UserData())
//            LandmarkList().previewDevice("iPhone 8")
        }
    }
}
