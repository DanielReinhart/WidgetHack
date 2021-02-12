import SwiftUI

// COPY: WidgetHack.WidgetDataModel.swift

enum WidgetKind: String, Codable {
    case openItems
}

enum WidgetTool: String, Codable {
    case punch
    case coordinationIssues
    case rfi
}

extension WidgetTool {
    var displayName: String {
        switch self {
        case .punch:
            return "Punch List"
        case .coordinationIssues:
            return "Coordination Issues"
        case .rfi:
            return "RFI"
        }
    }

    var imageName: String {
        switch self {
        case .punch:
            return "Punchlist"
        case .coordinationIssues:
            return "CoordinationIssues"
        case .rfi:
            return "RFI"
        }
    }

}

struct WidgetStoreSnapshot: Codable {
    ///"Open Items" : { "Punch": WidgetContent, "Correspondence": WidgetContent }
    let data: [WidgetKind: Set<WidgetToolSnapshot>]
    let lastUpdated: Date
    let versionNumber: String
}

extension WidgetStoreSnapshot {
    func contentBy(kind: WidgetKind, tool: WidgetTool) -> WidgetContent? {
        data[kind]?.first(where: { $0.tool == tool })?.content
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


// MARK: - CustomStringConvertible

//extension WidgetKind: CustomStringConvertible {
//    var description: String {
//        switch self {
//        case .openItems:
//            return "Open Items"
//        }
//    }
//}

extension WidgetTool: CustomStringConvertible {
    var description: String { displayName }
}

extension WidgetStoreSnapshot: CustomStringConvertible {
    var description: String {
"""
Version: \(versionNumber)
updated at: \(lastUpdated)
\(data)
"""
    }
}

extension WidgetToolSnapshot: CustomStringConvertible {
    var description: String {
"""
    Tool: \(tool)
    \(content)
"""
    }
}

extension WidgetContent: CustomStringConvertible {
    var description: String {
"""
Title: \(title)
Subtitle: \(subtitle)
ImageName: \(imageName ?? "--")
PrimaryContent: \(primaryContent)
SecondaryContent: \(secondaryContent ?? "--")
Count: \(count ?? "--")
Updated At: \(updatedAt ?? "--")
"""
    }
}
