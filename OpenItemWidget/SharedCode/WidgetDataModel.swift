import SwiftUI

// COPY: WidgetHack.WidgetDataModel.swift

enum WidgetKind: String {
    case openItems
}

struct WidgetStoreSnapshot: Codable {
    ///"Open Items" : { "Punch": WidgetContent, "Correspondence": WidgetContent }
    let data: [String: [WidgetToolSnapshot]]
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
