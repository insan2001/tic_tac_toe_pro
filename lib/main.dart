// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe_pro/functions/dataIO.dart';
import 'package:tic_tac_toe_pro/screens/instructions.dart';
import 'package:tic_tac_toe_pro/screens/options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await dataIO.init();
  bool firstTime = await dataIO.firstTimeGet() ?? true;
  if (firstTime) {
    await dataIO.setUserName1("");
    await dataIO.setUserName2("");
  }

  runApp(
    MyApp(firstTime: firstTime),
  );
}

class MyApp extends StatelessWidget {
  bool firstTime;
  MyApp({super.key, required this.firstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: firstTime ? InstructionScreen() : GameOptions(),
      ),
    );
  }
}
