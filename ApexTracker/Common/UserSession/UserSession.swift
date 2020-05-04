import Foundation

public final class UserSession {
    
    public enum State {
        case initialized, opened, closed
    }
    
    // MARK: - Properties.
    
    public var state: State {
        get {
            return _state
        }
        set {
            _state = newValue
        }
    }
    
    public var sessionInvalidated: ((_ userId: Int?) -> Void)?
    public var userSessionInfo: SessionInfo? { storage.obtain() }
    
    private var _state: State = .initialized
    private let storage: TokensStoragable
    
    // MARK: - Init.
    
    init(storage: TokensStoragable) {
        self.storage = storage
    }
    
    // MARK: - Session managment.
    
    func startSession(with provider: SessionInfo) {
        storage.save(data: provider)
        _state = .opened
    }
    
    func stopSession() {
        storage.clean()
        _state = .closed
    }
    
    // MARK: - Session Restoration.

    public func canRestorePreviousSession() -> Bool {
        if storage.obtain() != nil {
            _state = .opened
            return true
        }
        return false
    }
}
