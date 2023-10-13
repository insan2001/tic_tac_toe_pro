import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const myBannerID = "ca-app-pub-9320493450035769/3707700397";
const myInterstitialID = "ca-app-pub-9320493450035769/1245188588";

const testBannerID = "ca-app-pub-3940256099942544/6300978111";
const testInterstitialID = "ca-app-pub-3940256099942544/1033173712";

class AdMobService {
  static String? get BannerAdUnitId {
    return testBannerID;
  }

  static String? get InterstitialAdUnitId {
    return testInterstitialID;
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
