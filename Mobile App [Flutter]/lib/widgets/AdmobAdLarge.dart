import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobAdLarge extends StatefulWidget {
  AdMobAdLarge({
    Key? key,
    this.onTap,
  }) : super(
          key: key,
        );

  final VoidCallback? onTap;

  @override
  State<AdMobAdLarge> createState() => _AdMobAdLargeState();
}

class _AdMobAdLargeState extends State<AdMobAdLarge> {
  NativeAd? nativeAd;
  bool isNativeAdLoaded = false;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadNativeAd();
  }

  loadNativeAd(){
    nativeAd = NativeAd(
        adUnitId: 'ca-app-pub-3940256099942544/2247696110',
        factoryId: "listTileMedium",
        listener: NativeAdListener(
            onAdClosed: (Ad ad){
              print("Ad Closed");
            },
            onAdFailedToLoad: (Ad ad,LoadAdError error){
              ad.dispose();
            },
            onAdLoaded: (Ad ad){
              // bAd.customOptions.
              print('Ad Loaded');
              setState(() {
                isNativeAdLoaded = true;
              });
            },
            onAdOpened: (Ad ad){
              print('Ad opened');
            }
        ),
        request: AdRequest()
    );
    nativeAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isNativeAdLoaded ? Padding(
        padding: const EdgeInsets.all(15.0),
        child: AdWidget(
          ad: nativeAd!,
          // key: UniqueKey(),
        ),
      ) : Center(
          child: const Text("Loading media..."),
      ),
    );
  }

}
