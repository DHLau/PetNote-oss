//
//  ContentView.swift
//  mymx
//
//  Created by ice on 2024/6/17.
//

import SwiftUI
import NukeUI

enum Tab: String {
    case home
    case note
    case add
    case community
    case mine
}

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(NetworkMonitor.self) private var networkMonitor
    
    @StateObject private var photoVM = PhotographVM()
    @StateObject private var weatherVM = WeatherVM()
    @StateObject private var factsVM = FactsVM()
    @StateObject private var noteVM = NoteVM()
    @StateObject private var addNoteVM = AddNoteVM()
    @StateObject private var shopVM = ShopVM()
    
    @State private var isLoggedIn: Bool = false
    @State private var selection: Tab = .home
    @State private var showAddNote = false
    @State private var joinRanking = 0
    
    var body: some View {
        ZStack{
            Text("")
                .onChange(of: [networkMonitor.isConnected], {
                    print("network is connected: \(networkMonitor.isConnected)")
                    if(networkMonitor.isConnected){
                        factsVM.nextFact()
                        modelData.getPetList()

                        if(photoVM.photoList.isEmpty){
                            photoVM.fetchFirst()
                        }
                        if weatherVM.poetryWeathers.isEmpty{
                            weatherVM.fetchWeather(city: modelData.city)
                        }
                    }
                })
            
            VStack(spacing: 0){
                ZStack{
                    switch selection {
                    case .home:
                        CardHome(weatherVM: weatherVM, factsVM: factsVM, photoVM: photoVM)
                            .tag(Tab.home)
                    case .note:
                        NoteView(viewModel: noteVM)
                            .tag(Tab.note)
                    case .add:
                        EmptyView()
                            .tag(Tab.add)
                    case .community:
                        CommunityView(shopVM: shopVM)
                            .tag(Tab.community)
                    case .mine:
                        MineView()
                            .tag(Tab.mine)
                    }
                    
                    if modelData.user == nil && selection != .home{
                        LoginView()
                            .onDisappear{
                                if(modelData.user != nil){
                                    // 登录成功的逻辑
                                    print("Login success")
                                    if let rank = modelData.user?.joinRanking{
                                        self.joinRanking = rank
                                    }
                                    modelData.getPetList()
                                    if(selection == .note){
                                        noteVM.getNoteList()
                                    }
                                }
                            }
                    }
                    
                }
                
                Spacer(minLength: 0)
                MyTabView(active: $selection, showAddNote: $showAddNote)
                        .background(.lightBg)
                        .contentShape(.rect)
                        .onTapGesture {
                            print("tap tab view")
                        }
            }
            .ignoresSafeArea(.keyboard)
            
            VStack(spacing: 0){
                if addNoteVM.loading || addNoteVM.progress == 1 || !addNoteVM.errorMsg.isEmpty{
                    VStack{
                        HStack{
                            if(addNoteVM.imageList.count > 0){
                                Image(uiImage: addNoteVM.imageList[0])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 48, height: 48)
                                    .clipped()
                            }
                            if addNoteVM.progress == 1{
                                Text("发布成功！🎉 ")
                                Spacer()
                                Button("好的", action: {
                                    withAnimation{
                                        addNoteVM.cancel()
                                    }
                                    if(selection == .note){
                                        noteVM.getNoteList()
                                    }else{
                                        GlobalParams.updateNote = true
                                    }
                                })
                            }else if !addNoteVM.errorMsg.isEmpty{
                                Text(addNoteVM.errorMsg)
                                    .foregroundStyle(.red)
                                Spacer()
                                Button("取消", action: {
                                    withAnimation{
                                        addNoteVM.cancel()
                                    }
                                })
                                .padding(.trailing)
                                Button("重试", action: {
                                    showAddNote = true
                                })
                            } else {
                                Text(addNoteVM.imageList.count > 0 ? "图片上传中，请稍作等待..." : "动态发布中...")
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        ProgressView(value: addNoteVM.progress)
                            .progressViewStyle(.linear)
                            .tint(Color(hex: "B4E380"))
                    }
                    .padding(.top)
                    .background(.regularMaterial)
                    .transition(.offset(x:0, y: -128))
                }
                Spacer()
            }
            .ignoresSafeArea(.keyboard)
            
            if joinRanking > 0 {
                JoinRankingView(joinRanking: $joinRanking)
                    .transition(.opacity)
            }
        }
        .fullScreenCover(isPresented: $showAddNote, content: {
            AddNoteView(showAddNote:$showAddNote, viewModel: addNoteVM)
                .environmentObject(modelData)
        })
        .onOpenURL { url in
            print("Received deep link: \(url)")
            // https://zzz.pet/loveoss/note?selectedPet=49
            // Use URLComponents to parse the URL
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                     
            let pathArray = url.path().split(separator: "/")
            if pathArray.count > 1{
                let path = pathArray[1]
                let tab = Tab(rawValue: path.lowercased())
                selection = tab ?? .home
                if tab == .note{
                    if let queryItems = components?.queryItems {
                        for item in queryItems {
                            if item.name == "selectedPet", let petId = Int(item.value ?? "0") {
                                // change selectedPet
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            print("ContentView onAppear")
            if(modelData.petList.isEmpty){
                modelData.getPetList()
            }
        })
    }
}

struct MyTabView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var active: Tab
    @Binding var showAddNote: Bool
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 5), spacing: 0) {
            Rectangle()
                .foregroundStyle(.clear)
                .contentShape(.rect)
                .overlay{
                    Text("首页")
                        .font(active == .home ? .headline : .callout)
                        .bold()
                        .foregroundStyle(active == .home ? .primary : .secondary)
                        .padding(.vertical, 4)
                }
                .onTapGesture {
                    withAnimation{
                        active = .home
                    }
                }
            Rectangle()
                .foregroundStyle(.clear)
                .contentShape(.rect)
                .overlay{
                    Text("爱宠说")
                        .font(active == .note ? .headline : .callout)
                        .bold()
                        .foregroundStyle(active == .note ? .primary : .secondary)
                        .padding(.vertical, 4)
                }
                .onTapGesture {
                    withAnimation{
                        active = .note
                    }
                }
            Rectangle()
                .foregroundStyle(.clear)
                .contentShape(.rect)
                .overlay{
                    Button(action: {
                        print("add Note")
                        if(modelData.user == nil){
                            withAnimation{
                                active = .note
                            }
                        }else{
                            self.showAddNote = true
                        }
                    }){
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 20)
                            .padding(10)
                            .foregroundStyle(.white)
                            .bold()
                            .background(.button)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .plusShadow, radius: 8, x: 0, y: 4)
                        
                    }
                }
                .frame(minHeight: 50)
                .onTapGesture {
                    
                }
            Rectangle()
                .foregroundStyle(.clear)
                .contentShape(.rect)
                .overlay{
                    Text("社区")
                        .font(active == .community ? .headline : .callout)
                        .bold()
                        .foregroundStyle(active == .community ? .primary : .secondary)
                        .padding(.vertical, 4)
                }
                .onTapGesture {
                    withAnimation{
                        active = .community
                    }
                }
            Rectangle()
                .foregroundStyle(.clear)
                .contentShape(.rect)
                .overlay{
                    Text("AI")
                        .font(active == .mine ? .headline : .callout)
                        .bold()
                        .foregroundStyle(active == .mine ? .primary : .secondary)
                }
                .padding(.vertical, 4)
                .onTapGesture {
                    withAnimation{
                        active = .mine
                    }
                }
        }
    }
}

#Preview {
    let modelData = ModelData()
    return ContentView()
        .environmentObject(modelData)
        .environment(NetworkMonitor())
}
