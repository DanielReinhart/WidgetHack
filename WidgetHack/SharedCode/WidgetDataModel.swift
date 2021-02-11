import SwiftUI

// COPY: WidgetHack.WidgetDataModel.swift

enum WidgetKind: String {
    case openItems
}

struct WidgetStoreSnapshot: Codable {
    ///"Open Items" : { "Punch": WidgetContent, "Correspondence": WidgetContent }
    let data: [String: Set<WidgetToolSnapshot>]
    let lastUpdated: Date
    let versionNumber: String
}

enum WidgetsAppGroup: String {
    case name = "group.com.useyourloaf.widgets"
}

extension WidgetStoreSnapshot {
    func contentBy(kind: WidgetKind, tool: String) -> WidgetContent? {
        data[kind.rawValue]?.first(where: { $0.toolName == tool })?.content
    }
}

struct WidgetToolSnapshot: Codable, Hashable {
    let toolName: String
    let content: WidgetContent

    func hash(into hasher: inout Hasher) {
        hasher.combine(toolName)
        hasher.combine(content)
    }
}

struct WidgetContent: Codable, Hashable {
    let title: String
    let subtitle: String
    let imageName: String // tool icon name
    let primaryContent: String // for both small and medium size
    let secondaryContent: String? // for medium size
    let count: String? // for example: number of open items
    let updatedAt: String // relative formatted date of last update
}
