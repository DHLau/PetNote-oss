//
//  Urls.swift
//  mymx
//
//  Created by ice on 2024/6/27.
//

import Foundation

class Urls{
    private static let BASE_PUB_URL = "https://mymx-oss-pub-kkxdbyqfnl.cn-hangzhou.fcapp.run/"
    private static let BASE_URL = "https://mymx-oss-zihhjvkadm.cn-hangzhou.fcapp.run/api/"
    private static let BASE_STS_URL = "https://mymx-oss-zihhjvkadm.cn-hangzhou.fcapp.run/sts/"
    private static let BASE_3rd_URL = "https://mymx-oss-rd-kkxsgwqfnl.cn-hangzhou.fcapp.run/"
    
    static let CAT_FACT = "https://zzz.pet:3000/cat-fact"

    static let POETRY_WAETHER = BASE_PUB_URL + "poetryWeather"
    static let GET_RANDOM_IMAGE = BASE_PUB_URL + "getRandomImage"
    
    static let GET_AUTH_CODE = BASE_PUB_URL + "getAuthCode"
    static let LOGIN = BASE_PUB_URL + "login"
    
    static let STS_PET_AVATAR = BASE_STS_URL + "stsPetAvatar"
    static let STS_PET_NOTE = BASE_STS_URL + "stsPetNote"
    
    static let ADD_PET = BASE_URL + "addPet"
    static let UPDATE_PET = BASE_URL + "updatePet"
    static let DELETE_PET = BASE_URL + "deletePet"

    static let ADD_NOTE = BASE_URL + "addNote"
    static let GET_PET_LIST = BASE_URL + "getPetList"
    static let GET_NOTE_LIST = BASE_URL + "getNoteList"
    
    static let DELETE_NOTE = BASE_URL + "deleteNote"
    
    static let SEARCH_TABOO = BASE_3rd_URL + "searchTaboo"
    static let AI_CHAT_DOCTOR = BASE_3rd_URL + "aiChat/doctor"
}
