//
//  Protocol.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/29.
//

import Foundation
import UIKit

@objc
protocol SetNotification {
    var notificationCenter: UNUserNotificationCenter { get }
    @objc optional var triggerTime: UNTimeIntervalNotificationTrigger { get }
    @objc optional var triggerCalendar: UNCalendarNotificationTrigger { get }
    func requestAuthorization()
    func sendNotification()

}
