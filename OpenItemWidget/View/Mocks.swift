import Foundation

extension WidgetEntry {
    static var mock: Self {
        Self(date: Date(), content: .mock)
    }
}

extension WidgetContent {
    static var mock: Self {
        Self(
            title: "Title",
            subtitle: "subtitle",
            imageName: "Punchlist",
            primaryContent: "primary content",
            secondaryContent: "secondary content",
            updatedAt: "updated: yesterday")
    }
}
