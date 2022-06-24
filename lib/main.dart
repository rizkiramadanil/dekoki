import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dekoki/common/navigation.dart';
import 'package:dekoki/common/style.dart';
import 'package:dekoki/data/api/api_service.dart';
import 'package:dekoki/data/database/database_helper.dart';
import 'package:dekoki/data/model/list.dart';
import 'package:dekoki/data/preferences/preferences_helper.dart';
import 'package:dekoki/page/home_page.dart';
import 'package:dekoki/page/restaurant_detail_page.dart';
import 'package:dekoki/page/splash_screen_page.dart';
import 'package:dekoki/provider/database_provider.dart';
import 'package:dekoki/provider/list_provider.dart';
import 'package:dekoki/provider/preferences_provider.dart';
import 'package:dekoki/provider/scheduling_provider.dart';
import 'package:dekoki/utils/background_service.dart';
import 'package:dekoki/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService(), id: ''),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider()
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Dekoki',
            theme: ThemeData(
              primaryColor: ColorStyles.primaryColor,
              scaffoldBackgroundColor: ColorStyles.primaryColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: const AppBarTheme(
                  color: ColorStyles.secondaryColor
              ),
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorStyles.secondaryColor),
            ),
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              HomePage.routeName: (context) => const HomePage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                  listRestaurant: ModalRoute.of(context)?.settings.arguments as Restaurant
              ),
            },
          );
        },
      ),
    );
  }
}
