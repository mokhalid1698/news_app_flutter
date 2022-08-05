import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  static const bool testMod = true;

  static String get bannerAd {
    if (testMod) {
      return "";
    } else {
      return "";
    }
  }

  static BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) {
      if (kDebugMode) {
        print('Ad opened.');
      }
    },
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) {
      if (kDebugMode) {
        print('Ad closed.');
      }
    },
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) {
      if (kDebugMode) {
        print('Ad impression.');
      }
    },
  );
  static AdWidget adWidget = AdWidget(
    ad: myBanner,
  );
  static Container adContainer = Container(
    // color: Colors.white,
    alignment: Alignment.center,
    child: adWidget,
    width: myBanner.size.width.toDouble(),
    height: myBanner.size.height.toDouble(),
  );


  static InterstitialAd? interstitialAd;
  static void loadBanner() {
    final adUnitId = Platform.isAndroid
        ? '	ca-app-pub-3940256099942544/1033173712'
        : '	ca-app-pub-3940256099942544/1033173712';
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {
              if (kDebugMode) {
                print('%ad onAdShowedFullScreenContent.');
              }
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              if (kDebugMode) {
                print('$ad onAdDismissedFullScreenContent.');
              }
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              if (kDebugMode) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
              }
              ad.dispose();
            },
            onAdImpression: (InterstitialAd ad) {
              if (kDebugMode) {
                print('$ad impression occurred.');
              }
            },
          );

          print("object");

        },
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            print("Error $error");
          }
        },
      ),
    );
  }



}
