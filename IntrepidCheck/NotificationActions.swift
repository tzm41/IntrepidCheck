//
//  NotificationActions.swift
//  IntrepidCheck
//
//  Created by Colin Tan on 6/10/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import UIKit

struct NotificationActions {
	static var sendMessageOnSlackAction: UIMutableUserNotificationAction {
		let action = UIMutableUserNotificationAction()
		action.identifier = "sendMessageAction"
		action.title = "Shout on slack"
		action.activationMode = UIUserNotificationActivationMode.Background
		action.destructive = false
		action.authenticationRequired = false
		return action
	}
}
