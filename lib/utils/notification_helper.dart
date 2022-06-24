import 'dart:convert';
import 'dart:math';

import 'package:dekoki/common/navigation.dart';
import 'package:dekoki/data/model/list.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  var index = 0;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantList restaurantList) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dekoki channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId, _channelName, _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true)
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
    );

    Random random = Random();
    int randomNum = random.nextInt(restaurantList.restaurants.length - 1);
    var restaurant = restaurantList.restaurants[randomNum];

    var titleNotification = "<b>Mau makan siang?</b>";
    var titleName = "Yuk mampir ke " + restaurant.name + "...";

    await flutterLocalNotificationsPlugin.show(
      0, titleNotification, titleName, platformChannelSpecifics,
      payload: json.encode(restaurantList.toJson())
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantList.fromJson(json.decode(payload));
        var restaurant = data.restaurants[index];
        Navigation.intentWithData(route, restaurant);
      },
    );
  }
}
