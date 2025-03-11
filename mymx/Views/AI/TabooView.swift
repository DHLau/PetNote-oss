//
//  TabooView.swift
//  mymx-oss
//
//  Created by ice on 2025/3/11.
//
import SwiftUI


struct TabooView: View{
    
    @State private var foodName = ""
    @StateObject private var viewModel = TabooVM()
    
    var body: some View{
        VStack{
            Text("🤖 Instruction (即AI的人设)")
                .font(.title2)
            Text("""
你精通猫咪知识。用户正在询问猫咪的食物禁忌，请从危害等级/安全等级、可能风险/可能优点、小贴士3个方面给予回答。请以如下格式返回数据{"是否安全":"", "危害等级":"", "安全等级": "","可能风险":"", "可能优点": "", "小贴士": ""}，“是否安全”只能返回“是”与“否”
""")
            .padding()
            
            HStack{
                TextField("请输入食物名称，比如巧克力🍫", text: $foodName)
                    .submitLabel(.search)
                    .onSubmit {
                        viewModel.searchTaboo(foodName: foodName)
                    }
                    .padding()
                
                Image(systemName: "magnifyingglass")
                    .padding()
                    .onTapGesture {
                        viewModel.searchTaboo(foodName: foodName)
                    }
            }
            .font(.title3)
            .border(.green)
            .padding()
            
            if viewModel.isSearching{
                ProgressView()
            }
            
            if let taboo = viewModel.foodTaboo{
                VStack(alignment: .leading, spacing: 10) {
                    Text("🐱 是否安全: \(taboo.是否安全)")
                        .font(.headline)
                        .foregroundColor(taboo.是否安全 == "是" ? .green : .red)
                    
                    Text("⚠️ 危害等级: \(taboo.危害等级)")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                    
                    Text("🛑 安全等级: \(taboo.安全等级)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("⚠️ 可能风险:")
                        .font(.headline)
                    Text(taboo.可能风险)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Text("🌟 可能优点:")
                        .font(.headline)
                    Text(taboo.可能优点)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Text("💡 小贴士:")
                        .font(.headline)
                    Text(taboo.小贴士)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            
        }
        .navigationTitle("猫咪食物禁忌")
    }
}
