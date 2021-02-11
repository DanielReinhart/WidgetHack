//
//  WidgetContentNotificationPoster.swift
//  WidgetHack
//
//  Created by Daniel Reinhart on 2/11/21.
//

import Foundation

//Clients should use this to post notifications to update widget data
final class WidgetContentNotificationPoster {
    static func post(with content: WidgetContent, tool: WidgetTool, kind: WidgetKind) {
        let userInfo = WidgetContentNotificationData.constructUserInfo(kind: kind,
                                                                       tool: tool,
                                                                       content: content)

        let notification = Notification(name: .widgetContent, object: nil, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }
}

//Internal helper struct to handle construction of notification user info
struct WidgetContentNotificationData {
    static let userInfoKey = "data"

    let kind: WidgetKind
    let tool: WidgetTool
    let content: WidgetContent

    fileprivate static func constructUserInfo(kind: WidgetKind, tool: WidgetTool, content: WidgetContent) -> [String: Any] {
        return [ userInfoKey : WidgetContentNotificationData(kind: kind, tool: tool, content: content) ]
    }
}
