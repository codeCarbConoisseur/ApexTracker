import Foundation

enum StorageKeys: String {
    case userId = "userId"
    case platform = "platform"
}

public final class TokensStorage: TokensStoragable {
    
    private let storage: UserDefaults
    
    public init(storage: UserDefaults) {
        self.storage = storage
    }
    
    public func obtain() -> SessionInfo? {
        guard let userId = storage.object(forKey: StorageKeys.userId.rawValue),
            let platform = storage.object(forKey: StorageKeys.platform.rawValue) else {
                return nil
        }
        return SessionInfo(userId: userId as! String, platform: platform as! SessionPlatform)
    }
    
    public func save(data: SessionInfo) {
        storage.set(data.userId, forKey: StorageKeys.userId.rawValue)
        storage.set(data.platform, forKey: StorageKeys.platform.rawValue)
    }
    
    public func clean() {
        storage.removeObject(forKey: StorageKeys.userId.rawValue)
        storage.removeObject(forKey: StorageKeys.platform.rawValue)
    }
}
