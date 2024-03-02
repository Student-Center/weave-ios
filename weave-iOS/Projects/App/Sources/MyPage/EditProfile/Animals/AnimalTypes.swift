//
//  AnimalTypes.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/25/24.
//

import Foundation
import DesignSystem

enum AnimalTypes: String, CaseIterable {
    case puppy = "PUPPY"
    case cat = "CAT"
    case fox = "FOX"
    case rabbit = "RABBIT"
    case tiger = "TIGER"
    case monkey = "MONKEY"
    case turtle = "TURTLE"
    case deer = "DEER"
    case hamster = "HAMSTER"
    case wolf = "WOLF"
    case teddyBear = "TEDDY_BEAR"
    case panda = "PANDA"
    case snake = "SNAKE"
    case otter = "OTTER"
    case fish = "FISH"
    case chick = "CHICK"
    case dinosour = "DINOSOUR"
    case horse = "HORSE"
    case sloth = "SLOTH"
    case lion = "LION"
    case camel = "CAMEL"
}

extension AnimalTypes: LeftAlignListFetchable, Identifiable {
    var text: String {
        return "\(imoji) \(animalName)상"
    }
    
    var id: String {
        return self.rawValue
    }
    
    var animalName: String {
        switch self {
        case .puppy: return "강아지"
        case .cat: return "고양이"
        case .fox: return "여우"
        case .rabbit: return "토끼"
        case .tiger: return "호랑이"
        case .monkey: return "원숭이"
        case .turtle: return "꼬부기"
        case .deer: return "사슴"
        case .hamster: return "햄스터"
        case .wolf: return "늑대"
        case .teddyBear: return "곰돌이"
        case .panda: return "판다"
        case .snake: return "뱀"
        case .otter: return "수달"
        case .fish: return "물고기"
        case .chick: return "병아리"
        case .dinosour: return "공룡"
        case .horse: return "말"
        case .sloth: return "나무늘보"
        case .lion: return "사자"
        case .camel: return "낙타"
        }
    }
    
    var imoji: String {
        switch self {
        case .puppy: return "🐶"
        case .cat: return "😸"
        case .fox: return "🦊"
        case .rabbit: return "🐰"
        case .tiger: return "🐯"
        case .monkey: return "🐵"
        case .turtle: return "🐢"
        case .deer: return "🦌"
        case .hamster: return "🐹"
        case .wolf: return "🐺"
        case .teddyBear: return "🐻"
        case .panda: return "🐼"
        case .snake: return "🐍"
        case .otter: return "🦦"
        case .fish: return "🐠"
        case .chick: return "🐤"
        case .dinosour: return "🦕"
        case .horse: return "🐴"
        case .sloth: return "🦥"
        case .lion: return "🦁"
        case .camel: return "🐪"
        }
    }
    
    var requestValue: String {
        return self.rawValue
    }
}

// HEDGEHOG - 서버에는 존재, FIGMA에는 없음
