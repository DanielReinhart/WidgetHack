import Foundation

extension Tool {
    var widgetTool: WidgetTool? {
        switch self {
            case .punch: return .punch
            case .coordinationIssues: return .coordinationIssues
            case .unknown: return nil
        }
    }
}
