import SwiftUI

enum WidgetKind: String {
    case openItems
}

struct WidgetStoreSnapshot {
    let data: [WidgetKind: [WidgetToolSnapshot]]
    let lastUpdated: Date
    let versionNumber: String
}

extension WidgetStoreSnapshot {
    func contentBy(kind: WidgetKind, tool: String) -> WidgetContent? {
        data[kind]?.first(where: { $0.toolName == tool })?.content
    }
}

extension WidgetStoreSnapshot: Decodable {
    init(from decoder: Decoder) throws {
        self.data = [:]
        self.lastUpdated = Date()
        self.versionNumber = "0"
    }
}

struct WidgetToolSnapshot: Codable {
    let toolName: String
    let content: WidgetContent
}

struct WidgetContent: Codable {
    let title: String
    let subtitle: String
    let imageName: String
    let value: String
}

// convenience methods for read/write via JSONDecoder
