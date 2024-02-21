//
//  UDManager.swift
//  weave-ios
//
//  Created by 강동영 on 2/18/24.
//

import Foundation

@propertyWrapper
public struct UDWrapper<T> {
    private let ud = UserDefaults.standard
    var key: String
    var defaultValue: T
    public var wrappedValue: T {
        get {
            ud.value(forKey: key) as? T ?? defaultValue
        }
        set {
            ud.setValue(newValue, forKey: key)
            ud.synchronize()
        }
    }
}

public enum UDManager {
    @UDWrapper(key: CommonKey.AccessToken, defaultValue: "")
    static var accessToken: String
    
    @UDWrapper(key: CommonKey.RefreshToken, defaultValue: "")
    static var refreshToken: String
}

extension UDManager {
    static var isLogin: Bool {
        print("accessToken: \(UDManager.accessToken)")
        print("refreshToken: \(UDManager.refreshToken)")
        return !UDManager.accessToken.isEmpty && !UDManager.refreshToken.isEmpty
    }
}
