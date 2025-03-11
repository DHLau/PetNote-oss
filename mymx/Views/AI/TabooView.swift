//
//  TabooView.swift
//  mymx-oss
//
//  Created by ice on 2025/3/11.
//
import SwiftUI


struct TabooView: View{
    
    @State private var foodName = ""
    
    var body: some View{
        VStack{
            Text("Instruction (即系统的人设)")
            Text("伟伟伟伟伟伟")
            
            Spacer()
            
            TextField("请输入食物名称，比如巧克力🍫", text: $foodName)
                .submitLabel(.search)
                .onSubmit {
                    // searchFood
                }
            
            VStack{
                Text("结果。。。")
            }
        }
        .navigationTitle("猫咪食物禁忌")
    }
}
