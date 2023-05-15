import 'dart:developer';

import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationController {
  initializeNotification() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
          defaultColor: AppColors.bgColor,
          ledColor: AppColors.red1,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      debug: true,
    );
  }

  notificationPermission() async {
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  setNotificationListener(BuildContext context) {
    AwesomeNotifications().setListeners(
      onNotificationCreatedMethod:
          (ReceivedNotification receivedNotification) async {
        await NotificationController.onNotificationCreatedMethod(
            receivedNotification);
      },
      onNotificationDisplayedMethod:
          (ReceivedNotification receivedNotification) async {
        await NotificationController.onNotificationDisplayedMethod(
            receivedNotification);
      },
      onActionReceivedMethod: (ReceivedAction receivedAction) async {
        await NotificationController.onActionReceivedMethod(
            receivedAction, context);
      },
      onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
        await NotificationController.onDismissActionReceivedMethod(
            receivedAction);
      },
    );
  }

  showNotification({
    required final int id,
    required final String title,
    final String? body,
    final String? summary,
    final String? bigPicture,
    final String? icon,
    final String? largeIcon,
    final NotificationCategory? category,
    final Map<String, String>? payload,
    final int? interval,
    final bool scheduled = false,
    final bool autoDismissible = true,
    final bool wakeUpScreen = false,
    final bool hideLargeIconOnExpand = false,
    final List<NotificationActionButton>? actionButtons,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        summary: summary,
        bigPicture: bigPicture,
        icon: icon,
        largeIcon: largeIcon,
        category: category,
        payload: payload,
        actionType: actionType,
        notificationLayout: notificationLayout,
        autoDismissible: autoDismissible,
        wakeUpScreen: wakeUpScreen,
        hideLargeIconOnExpand: hideLargeIconOnExpand,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }

  dismissNotification({int? id}) async {
    if (id != null) {
      await AwesomeNotifications().dismiss(id);
      return;
    }
    await AwesomeNotifications().dismissAllNotifications();
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    log("create");
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // log(receivedNotification.toString(), name: "display");
    log("display");
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    log("dismiss");
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction, BuildContext context) async {
    // Your code goes here

    log(receivedAction.toString(), name: "action");
    if (receivedAction.id == 1) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        HiveServices.getToken() != null
            ? AppRoutes.notificationScreen
            : AppRoutes.notificationScreen,
        (val) => false,
      );
    }

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
    //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}
