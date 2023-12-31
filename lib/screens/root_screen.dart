import 'package:flutter/material.dart';
import 'package:flutter_local_notification/native_api/local_notification.dart';
import 'package:flutter_local_notification/screens/home_screen.dart';

import 'splash_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late Future appInit;

  @override
  initState() {
    appInit = appInitialize(context: context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: appInit,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            } else if (snapshot.hasError) {
              return Container();
            } else if (snapshot.hasData) {
              if (snapshot.data == true) {
                // GoRouter.of(context).goNamed(AppRoute.name.home);
                return const HomeScreen();
              }
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

Future<bool> appInitialize({required BuildContext context}) async {
  LocalNotification.initialize();

  await Future.delayed(const Duration(milliseconds: 1000), () {});
  return true;
}
