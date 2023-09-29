import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get BannerAdUnitId {
    final adUnitId = Platform.isAndroid
        ? 'ca-app-pub-9320493450035769/3707700397'
        : 'ca-app-pub-9320493450035769/3707700397';
    return adUnitId;
  }

  static String? get InterstitialAdUnitId {
    final adUnitId = Platform.isAndroid
        ? 'ca-app-pub-9320493450035769/1245188588'
        : 'ca-app-pub-9320493450035769/1245188588';

    return adUnitId;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint("Ad Loaded"),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint("Ad failed to Load. $error");
    },
    onAdOpened: (ad) => debugPrint("Ad Opened"),
    onAdClosed: (ad) => debugPrint("Ad closed"),
  );
}
