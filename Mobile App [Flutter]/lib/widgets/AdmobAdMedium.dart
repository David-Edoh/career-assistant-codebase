import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobAd extends StatefulWidget {
  AdMobAd({
    Key? key,
    this.onTap,
  }) : super(
          key: key,
        );

  final VoidCallback? onTap;

  @override
  State<AdMobAd> createState() => _AdMobAdState();
}

class _AdMobAdState extends State<AdMobAd> {
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
    return SizedBox(
      height: mediaQueryData.size.height * 0.3,
      child: Card(
        elevation: 3,
        color: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: isNativeAdLoaded ? AdWidget(
          ad: nativeAd!,
          // key: UniqueKey(),
        ) : Center(
            child: const Text("Loading media..."),
        ),
      ),
    );
  }

}
