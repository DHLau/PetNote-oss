//
//  ChatView.swift
//  mymx-oss
//
//  Created by ice on 2025/3/11.
//
import SwiftUI

struct ChatView: View {
    @State private var inputStr = ""
    var body: some View {
        VStack{
            ScrollView{
                
            }
            TextField("聊一聊猫咪", text: $inputStr)
        }
        .navigationTitle("AI宠医生")
    }
}
