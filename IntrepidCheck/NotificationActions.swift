//
//  NotificationActions.swift
//  IntrepidCheck
//
//  Created by Colin Tan on 6/10/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import UIKit

struct NotificationActions {
    static var sendMessageOnEntryAction: UIMutableUserNotificationAction {
        return actionWithIdentifier("sendMessageOnEntryAction")
    }

    static var sendMessageOnExitAction: UIMutableUserNotificationAction {
        return actionWithIdentifier("sendMessageOnExitAction")
    }

    private static func actionWithIdentifier(identifier: String) -> UIMutableUserNotificationAction {
        let action = UIMutableUserNotificationAction()
        action.identifier = identifier
        action.title = "Shout on Slack"
        action.activationMode = UIUserNotificationActivationMode.Background
        action.destructive = false
        action.authenticationRequired = false
        return action
    }
}
