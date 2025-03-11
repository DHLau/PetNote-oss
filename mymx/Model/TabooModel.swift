//
//  TabooModel.swift
//  mymx-oss
//
//  Created by ice on 2025/3/12.
//

import Foundation

// 解析 Taboo 数据
struct TabooModel: Codable {
    let 是否安全: String
    let 危害等级: String
    let 安全等级: String
    let 可能风险: String
    let 可能优点: String
    let 小贴士: String
}
