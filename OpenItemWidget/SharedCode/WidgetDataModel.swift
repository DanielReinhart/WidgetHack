import SwiftUI

// COPY: WidgetHack.WidgetDataModel.swift

enum WidgetKind: String {
    case openItems
}

enum WidgetTool: String, Codable {
    case punch
    case coordinationIssues
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
    func contentBy(kind: WidgetKind, tool: WidgetTool) -> WidgetContent? {
        data[kind.rawValue]?.first(where: { $0.tool == tool })?.content
    }
}

struct WidgetToolSnapshot: Codable, Hashable {
    let tool: WidgetTool
    let content: WidgetContent
}

struct WidgetContent: Codable, Hashable {
    let title: String
    let subtitle: String
    let imageName: String? // tool icon name
    let primaryContent: String // for both small and medium size
    let secondaryContent: String? // for medium size
    let count: String? // for example: number of open items
    let updatedAt: String? // relative formatted date of last update
}
