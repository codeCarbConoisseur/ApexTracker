import Foundation

public protocol TokensStoragable {
    func obtain() -> SessionInfo?
    func save(data: SessionInfo)
    func clean()
}
