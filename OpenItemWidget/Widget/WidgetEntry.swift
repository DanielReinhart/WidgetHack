import WidgetKit

struct WidgetEntry: TimelineEntry {
    let date: Date
    let content: WidgetContent
}

extension WidgetContent {
    static var placeholder: Self {
        Self(
            title: "My Tool",
            subtitle: "My Current Project",
            imageName: "RFI",
            primaryContent: "10 open items",
            secondaryContent: "141 items in project",
            count: "10",
            updatedAt: "last updated: 1/10/2021 8:00am")
    }

    static func makeEmptyState(tool: WidgetTool?) -> Self {
        Self(
            title: "No Data",
            subtitle: tool?.displayName ?? "--",
            imageName: nil,
            primaryContent: "tap to open procore app",
            secondaryContent: nil,
            count: nil,
            updatedAt: nil)
    }
}
