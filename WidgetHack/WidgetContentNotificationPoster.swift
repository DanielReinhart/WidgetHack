//
//  WidgetContentNotificationPoster.swift
//  WidgetHack
//
//  Created by Daniel Reinhart on 2/11/21.
//

import Foundation

//Clients should use this to post notifications to update widget data
final class WidgetContentNotificationPoster {
    static func post(with content: WidgetContent, tool: String, kind: WidgetKind) {
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
    let tool: String
    let content: WidgetContent

    fileprivate static func constructUserInfo(kind: WidgetKind, tool: String, content: WidgetContent) -> [String: Any] {
        return [ userInfoKey : WidgetContentNotificationData(kind: kind, tool: tool, content: content) ]
    }
}
