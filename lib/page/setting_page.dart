import 'package:dekoki/common/style.dart';
import 'package:dekoki/provider/preferences_provider.dart';
import 'package:dekoki/provider/scheduling_provider.dart';
import 'package:dekoki/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting';

  const SettingPage({Key? key}) : super(key: key);

  Widget buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prvider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text(
                  'Daily Reminder',
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    color: ColorStyles.primaryTextColor,
                  ),
                ),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch(
                      value: prvider.isDailyReminderActive,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                        prvider.enableDailyReminder(value);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: ColorStyles.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: buildList(context),
    );
  }

  Widget buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Setting',
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: ColorStyles.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorStyles.secondaryColor,
        transitionBetweenRoutes: false,
      ),
      child: buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: buildAndroid,
      iosBuilder: buildIos,
    );
  }
}
