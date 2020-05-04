import Foundation

public struct SessionInfo {
    let userId: String
    let platform: SessionPlatform
}

public enum SessionPlatform: String {
    case PC = "pc"
    case PSN = "psn"
    case XBOX = "xbox"
}
