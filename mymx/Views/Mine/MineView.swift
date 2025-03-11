//
//  MineView.swift
//  mymx
//
//  Created by ice on 2024/7/8.
//

import SwiftUI
import NukeUI

struct MineView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var showProfile = false
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 0){
                    GeometryReader { geometry in
                        LazyImage(url: URL(string: "https://icemono.oss-cn-hangzhou.aliyuncs.com/images/denis-istomin-kaspa2.jpg")) { state in
                            state.image?
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: 400)
                                .clipped()
                        }
                        .frame(width: geometry.size.width, height: 400)
                        
                    }
                    .frame(height: 400)
                    .padding(.top, -80)
                    .padding(.bottom)
                    
                    HStack(spacing: 0){
                        LazyImage(url: URL(string: "https://maoxun.oss-cn-hangzhou.aliyuncs.com/image/other/img_pet_doctor.jpg")){ state in
                            state.image?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                        }
                        .clipShape(Circle())
                        Text("AI宠医生")
                            .padding(.leading)
                        Spacer()
                    }
                    .padding()
                    
                    HStack(spacing: 0){
                        LazyImage(url: URL(string: "https://maoxun.oss-cn-hangzhou.aliyuncs.com/image/other/img_orange_cat.jpeg")){ state in
                            state.image?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                        }
                        .clipShape(Circle())
                        Text("猫咪食物禁忌")
                            .padding(.leading)
                        Spacer()
                    }
                    .padding()
                }
            }
            .ignoresSafeArea(edges: .top)
            .toolbar{
                if(modelData.user != nil){
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            showProfile.toggle()
                        } label: {
                            Label("User Profile", systemImage: "gearshape")
                        }
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .sheet(isPresented: $showProfile, content: {
                ProfileView(showProfile:$showProfile)
            })
        }
    }
}


#Preview {
    let modelData = ModelData()
    return MineView()
        .environmentObject(modelData)
}
