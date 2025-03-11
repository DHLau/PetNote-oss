//
//  ChatMessage.swift
//  mymx-oss
//
//  Created by ice on 2025/3/12.
//

import Foundation

struct ChatMessage: Identifiable, Codable {
    var id = UUID()
    let content: String
    let isUser: Bool
    let createTime: Int
}
