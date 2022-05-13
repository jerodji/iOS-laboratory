//
//  UserData.swift
//  SwiftUITest
//
//  Created by CN210208396 on 2022/5/12.
//

import Foundation
import Combine //重要的响应框架

/// 使用可观察对象来存储数据
/// 可观察对象需要对外公布内部数据的改动 @Published
/// 因此订阅此可观察对象的订阅者就可以获得对应的数据改动信息
final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
