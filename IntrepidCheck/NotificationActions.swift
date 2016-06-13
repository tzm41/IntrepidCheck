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
		let sendMessageOnEntryAction = UIMutableUserNotificationAction()
		sendMessageOnEntryAction.identifier = "sendMessageOnEntryAction"
		sendMessageOnEntryAction.title = "Shout on Slack"
		sendMessageOnEntryAction.activationMode = UIUserNotificationActivationMode.Background
		sendMessageOnEntryAction.destructive = false
		sendMessageOnEntryAction.authenticationRequired = false
		return sendMessageOnEntryAction
	}
    
    static var sendMessageOnExitAction: UIMutableUserNotificationAction {
        let sendMessageOnExitAction = UIMutableUserNotificationAction()
        sendMessageOnExitAction.identifier = "sendMessageOnExitAction"
        sendMessageOnExitAction.title = "Shout on Slack"
        sendMessageOnExitAction.activationMode = UIUserNotificationActivationMode.Background
        sendMessageOnExitAction.destructive = false
        sendMessageOnExitAction.authenticationRequired = false
        return sendMessageOnExitAction
    }
}
