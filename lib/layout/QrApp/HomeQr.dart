import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:modules.news_app/shared/ads_helper/adsHelper.dart';

class HomeQr extends StatelessWidget {
  const HomeQr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
      ),
      body: const HomeOne(),
    );
  }
}

class HomeOne extends StatefulWidget {
  const HomeOne({Key? key}) : super(key: key);

  @override
  State<HomeOne> createState() => _HomeOneState();
}




class _HomeOneState extends State<HomeOne> {

@override
  void dispose() {

  AdsHelper.interstitialAd!.dispose();
  AdsHelper.myBanner!.dispose();

  // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      print(AdsHelper.isDone.toString() + "hhhhhhhhhhhhh");
                      if (AdsHelper.isDone) {
                        AdsHelper.interstitialAd!.show();
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BarcodeScannerWithController()))
                            .then((value) {

                        });
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BarcodeScannerWithController()));
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.50),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  1, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.indigo),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.qr_code,
                            size: 100,
                            color: Colors.white,
                          ),
                          Text(
                            "  Qr انشاء",
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      )),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.50),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(1, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.indigo),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.qr_code_scanner_outlined,
                              size: 100, color: Colors.white),
                          Text(
                            " Qr مسح  ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 200,
            //   color: Colors.indigo,
            // ),
            AdsHelper.adContainer,
          ],
        ),
      ),
    );
  }
}

class BarcodeScannerWithController extends StatefulWidget {
  const BarcodeScannerWithController({Key? key}) : super(key: key);

  @override
  _BarcodeScannerWithControllerState createState() =>
      _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState
    extends State<BarcodeScannerWithController>
    with SingleTickerProviderStateMixin {
  String? barcode;

  MobileScannerController controller = MobileScannerController(
    // formats: [BarcodeFormat.qrCode]

    facing: CameraFacing.back,
  );
  InterstitialAd? _interstitialAd;

  bool isStarted = true;

  void loadBanner() {
    final adUnitId = Platform.isAndroid
        ? '	ca-app-pub-3940256099942544/1033173712'
        : '	ca-app-pub-3940256099942544/1033173712';
    // final bannerAd = BannerAd(
    //     adUnitId: adUnitId,
    //     request: AdRequest(),
    //
    //     size: AdSize.banner, listener: BannerAdListener(
    //   onAdLoaded: (InterstitialAd ad) {
    //     _interstitialAd = ad;
    //   },
    // )
    // );
    // bannerAd.load();
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            print("Error $error");
          }
        },
      ),
    );
  }

  @override
  void initState() {
    // AdsHelper.myBanner.load();
    // loadBanner();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(barcode);
    return Scaffold(
        appBar: AppBar(),
        // backgroundColor: Colors.black,
        body: Column(
          children: [
            // AdsHelper.adContainer,
            Expanded(
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    fit: BoxFit.contain,

                    // controller: MobileScannerController(
                    //   torchEnabled: true,
                    //   facing: CameraFacing.front,
                    // ),
                    onDetect: (barcode, args) {
                      setState(() {
                        this.barcode = barcode.rawValue!;
                      });
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: IconButton(
                                    color: Colors.black26,
                                    icon: ValueListenableBuilder(
                                      valueListenable: controller.torchState,
                                      builder: (context, state, child) {
                                        if (state == null) {
                                          return const Icon(
                                            Icons.flash_off,
                                            color: Colors.grey,
                                          );
                                        }
                                        switch (state as TorchState) {
                                          case TorchState.off:
                                            return const Icon(
                                              Icons.flash_off_outlined,
                                              color: Colors.grey,
                                            );
                                          case TorchState.on:
                                            return const Icon(
                                              Icons.flash_on_outlined,
                                              color: Colors.yellow,
                                            );
                                        }
                                      },
                                    ),
                                    iconSize: 32.0,
                                    onPressed: () => controller.toggleTorch(),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: IconButton(
                                    color: Colors.black26,
                                    icon: isStarted
                                        ? const Icon(Icons.stop_outlined)
                                        : const Icon(Icons.play_arrow_outlined),
                                    iconSize: 32.0,
                                    onPressed: () => setState(() {
                                      isStarted
                                          ? controller.stop()
                                          : controller.start();
                                      isStarted = !isStarted;
                                    }),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.black26,
                                  icon: ValueListenableBuilder(
                                    valueListenable:
                                        controller.cameraFacingState,
                                    builder: (context, state, child) {
                                      if (kDebugMode) {
                                        print("state : $state");
                                      }

                                      if (state == null) {
                                        return const Icon(Icons.camera_front);
                                      }
                                      switch (state as CameraFacing) {
                                        case CameraFacing.front:
                                          return const Icon(
                                              Icons.camera_front_outlined);
                                        case CameraFacing.back:
                                          return const Icon(
                                              Icons.camera_rear_outlined);
                                      }
                                    },
                                  ),
                                  iconSize: 32.0,
                                  onPressed: () => controller.switchCamera(),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: IconButton(
                                    color: Colors.black26,
                                    icon: const Icon(Icons.image_outlined),
                                    iconSize: 32.0,
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();
                                      // Pick an image
                                      final XFile? image =
                                          await picker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (image != null) {
                                        if (await controller
                                            .analyzeImage(image.path)) {
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Barcode found!'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        } else {
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('No barcode found!'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 200,
                              height: 50,
                              child: InkWell(
                                onHover: (value) => "Copy",
                                onTap: () {
                                  Clipboard.setData(
                                          ClipboardData(text: barcode))
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Copy'),
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                    );
                                    _interstitialAd!.show();
                                  });
                                },
                                child: FittedBox(
                                  child: Text(
                                    barcode ?? 'Scan something!',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          if (barcode?.length != null)
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 200,
                                height: 50,
                                child: InkWell(
                                  onTap: () {
                                    Clipboard.setData(
                                            ClipboardData(text: barcode))
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Copy'),
                                          backgroundColor: Colors.blueAccent,
                                        ),
                                      );
                                    });
                                  },
                                  child: const Text(
                                    'Click to copy',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // Align(
                          //   alignment: Alignment.bottomCenter,
                          //   child: Container(
                          //     alignment: Alignment.bottomCenter,
                          //     height: 100,
                          //     color: Colors.black.withOpacity(0.4),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         IconButton(
                          //           color: Colors.white,
                          //           icon: ValueListenableBuilder(
                          //             valueListenable: controller.torchState,
                          //             builder: (context, state, child) {
                          //               if (state == null) {
                          //                 return const Icon(
                          //                   Icons.flash_off,
                          //                   color: Colors.grey,
                          //                 );
                          //               }
                          //               switch (state as TorchState) {
                          //                 case TorchState.off:
                          //                   return const Icon(
                          //                     Icons.flash_off,
                          //                     color: Colors.grey,
                          //                   );
                          //                 case TorchState.on:
                          //                   return const Icon(
                          //                     Icons.flash_on,
                          //                     color: Colors.yellow,
                          //                   );
                          //               }
                          //             },
                          //           ),
                          //           iconSize: 32.0,
                          //           onPressed: () => controller.toggleTorch(),
                          //         ),
                          //         IconButton(
                          //           color: Colors.white,
                          //           icon: isStarted
                          //               ? const Icon(Icons.stop)
                          //               : const Icon(Icons.play_arrow),
                          //           iconSize: 32.0,
                          //           onPressed: () => setState(() {
                          //             isStarted ? controller.stop() : controller.start();
                          //             isStarted = !isStarted;
                          //           }),
                          //         ),
                          //         Center(
                          //           child: SizedBox(
                          //             width: MediaQuery.of(context).size.width - 200,
                          //             height: 50,
                          //             child: FittedBox(
                          //               child: Text(
                          //                 barcode ?? 'Scan something!',
                          //                 overflow: TextOverflow.fade,
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .headline4!
                          //                     .copyWith(color: Colors.white),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         IconButton(
                          //           color: Colors.white,
                          //           icon: ValueListenableBuilder(
                          //             valueListenable: controller.cameraFacingState,
                          //             builder: (context, state, child) {
                          //               if (kDebugMode) {
                          //                 print("state : $state");
                          //               }
                          //
                          //               if (state == null) {
                          //                 return const Icon(Icons.camera_front);
                          //               }
                          //               switch (state as CameraFacing) {
                          //                 case CameraFacing.front:
                          //                   return const Icon(Icons.camera_front);
                          //                 case CameraFacing.back:
                          //                   return const Icon(Icons.camera_rear);
                          //               }
                          //
                          //
                          //             },
                          //           ),
                          //           iconSize: 32.0,
                          //           onPressed: () => controller.switchCamera(),
                          //         ),
                          //         IconButton(
                          //           color: Colors.white,
                          //           icon: const Icon(Icons.image),
                          //           iconSize: 32.0,
                          //           onPressed: () async {
                          //             final ImagePicker picker = ImagePicker();
                          //             // Pick an image
                          //             final XFile? image = await picker.pickImage(
                          //               source: ImageSource.gallery,
                          //             );
                          //             if (image != null) {
                          //               if (await controller.analyzeImage(image.path)) {
                          //                 if (!mounted) return;
                          //                 ScaffoldMessenger.of(context).showSnackBar(
                          //                   const SnackBar(
                          //                     content: Text('Barcode found!'),
                          //                     backgroundColor: Colors.green,
                          //                   ),
                          //                 );
                          //               } else {
                          //                 if (!mounted) return;
                          //                 ScaffoldMessenger.of(context).showSnackBar(
                          //                   const SnackBar(
                          //                     content: Text('No barcode found!'),
                          //                     backgroundColor: Colors.red,
                          //                   ),
                          //                 );
                          //               }
                          //             }
                          //           },
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  QrBody(BuildContext context) async {
    return Column(
      children: [
        AdsHelper.adContainer,
        Expanded(
          child: Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.contain,

                // controller: MobileScannerController(
                //   torchEnabled: true,
                //   facing: CameraFacing.front,
                // ),
                onDetect: (barcode, args) {
                  setState(() {
                    this.barcode = barcode.rawValue!;
                  });
                },
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: IconButton(
                                color: Colors.black26,
                                icon: ValueListenableBuilder(
                                  valueListenable: controller.torchState,
                                  builder: (context, state, child) {
                                    if (state == null) {
                                      return const Icon(
                                        Icons.flash_off,
                                        color: Colors.grey,
                                      );
                                    }
                                    switch (state as TorchState) {
                                      case TorchState.off:
                                        return const Icon(
                                          Icons.flash_off_outlined,
                                          color: Colors.grey,
                                        );
                                      case TorchState.on:
                                        return const Icon(
                                          Icons.flash_on_outlined,
                                          color: Colors.yellow,
                                        );
                                    }
                                  },
                                ),
                                iconSize: 32.0,
                                onPressed: () => controller.toggleTorch(),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: IconButton(
                                color: Colors.black26,
                                icon: isStarted
                                    ? const Icon(Icons.stop_outlined)
                                    : const Icon(Icons.play_arrow_outlined),
                                iconSize: 32.0,
                                onPressed: () => setState(() {
                                  isStarted
                                      ? controller.stop()
                                      : controller.start();
                                  isStarted = !isStarted;
                                }),
                              ),
                            ),
                            IconButton(
                              color: Colors.black26,
                              icon: ValueListenableBuilder(
                                valueListenable: controller.cameraFacingState,
                                builder: (context, state, child) {
                                  if (kDebugMode) {
                                    print("state : $state");
                                  }

                                  if (state == null) {
                                    return const Icon(Icons.camera_front);
                                  }
                                  switch (state as CameraFacing) {
                                    case CameraFacing.front:
                                      return const Icon(
                                          Icons.camera_front_outlined);
                                    case CameraFacing.back:
                                      return const Icon(
                                          Icons.camera_rear_outlined);
                                  }
                                },
                              ),
                              iconSize: 32.0,
                              onPressed: () => controller.switchCamera(),
                            ),
                            SizedBox(
                              width: 100,
                              child: IconButton(
                                color: Colors.black26,
                                icon: const Icon(Icons.image_outlined),
                                iconSize: 32.0,
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
                                  // Pick an image
                                  final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (image != null) {
                                    if (await controller
                                        .analyzeImage(image.path)) {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Barcode found!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('No barcode found!'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 50,
                          child: InkWell(
                            onHover: (value) => "Copy",
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: barcode))
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Copy'),
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                );
                                _interstitialAd!.show();
                              });
                            },
                            child: FittedBox(
                              child: Text(
                                barcode ?? 'Scan something!',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      if (barcode?.length != null)
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: barcode))
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Copy'),
                                      backgroundColor: Colors.blueAccent,
                                    ),
                                  );
                                });
                              },
                              child: const Text(
                                'Click to copy',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Container(
                      //     alignment: Alignment.bottomCenter,
                      //     height: 100,
                      //     color: Colors.black.withOpacity(0.4),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         IconButton(
                      //           color: Colors.white,
                      //           icon: ValueListenableBuilder(
                      //             valueListenable: controller.torchState,
                      //             builder: (context, state, child) {
                      //               if (state == null) {
                      //                 return const Icon(
                      //                   Icons.flash_off,
                      //                   color: Colors.grey,
                      //                 );
                      //               }
                      //               switch (state as TorchState) {
                      //                 case TorchState.off:
                      //                   return const Icon(
                      //                     Icons.flash_off,
                      //                     color: Colors.grey,
                      //                   );
                      //                 case TorchState.on:
                      //                   return const Icon(
                      //                     Icons.flash_on,
                      //                     color: Colors.yellow,
                      //                   );
                      //               }
                      //             },
                      //           ),
                      //           iconSize: 32.0,
                      //           onPressed: () => controller.toggleTorch(),
                      //         ),
                      //         IconButton(
                      //           color: Colors.white,
                      //           icon: isStarted
                      //               ? const Icon(Icons.stop)
                      //               : const Icon(Icons.play_arrow),
                      //           iconSize: 32.0,
                      //           onPressed: () => setState(() {
                      //             isStarted ? controller.stop() : controller.start();
                      //             isStarted = !isStarted;
                      //           }),
                      //         ),
                      //         Center(
                      //           child: SizedBox(
                      //             width: MediaQuery.of(context).size.width - 200,
                      //             height: 50,
                      //             child: FittedBox(
                      //               child: Text(
                      //                 barcode ?? 'Scan something!',
                      //                 overflow: TextOverflow.fade,
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .headline4!
                      //                     .copyWith(color: Colors.white),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         IconButton(
                      //           color: Colors.white,
                      //           icon: ValueListenableBuilder(
                      //             valueListenable: controller.cameraFacingState,
                      //             builder: (context, state, child) {
                      //               if (kDebugMode) {
                      //                 print("state : $state");
                      //               }
                      //
                      //               if (state == null) {
                      //                 return const Icon(Icons.camera_front);
                      //               }
                      //               switch (state as CameraFacing) {
                      //                 case CameraFacing.front:
                      //                   return const Icon(Icons.camera_front);
                      //                 case CameraFacing.back:
                      //                   return const Icon(Icons.camera_rear);
                      //               }
                      //
                      //
                      //             },
                      //           ),
                      //           iconSize: 32.0,
                      //           onPressed: () => controller.switchCamera(),
                      //         ),
                      //         IconButton(
                      //           color: Colors.white,
                      //           icon: const Icon(Icons.image),
                      //           iconSize: 32.0,
                      //           onPressed: () async {
                      //             final ImagePicker picker = ImagePicker();
                      //             // Pick an image
                      //             final XFile? image = await picker.pickImage(
                      //               source: ImageSource.gallery,
                      //             );
                      //             if (image != null) {
                      //               if (await controller.analyzeImage(image.path)) {
                      //                 if (!mounted) return;
                      //                 ScaffoldMessenger.of(context).showSnackBar(
                      //                   const SnackBar(
                      //                     content: Text('Barcode found!'),
                      //                     backgroundColor: Colors.green,
                      //                   ),
                      //                 );
                      //               } else {
                      //                 if (!mounted) return;
                      //                 ScaffoldMessenger.of(context).showSnackBar(
                      //                   const SnackBar(
                      //                     content: Text('No barcode found!'),
                      //                     backgroundColor: Colors.red,
                      //                   ),
                      //                 );
                      //               }
                      //             }
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// class Qrcode extends StatefulWidget {
//   @override
//   _QrcodeState createState() => _QrcodeState();
// }
//
// class _QrcodeState extends State<Qrcode> {
//   String _data = "";
//
//   Future<String?> _scan() async {
//     await FlutterBarcodeScanner.scanBarcode(
//             "#000000", "cancel", true, ScanMode.BARCODE)
//         .then((value) => setState(() => _data = value));
//   }
//
//   Future<void> scanQR(ScanMode scanMode) async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', false, scanMode);
//       if (kDebugMode) {
//         print(barcodeScanRes);
//       }
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       if (barcodeScanRes == "-1") {
//         _data = "";
//       } else {
//         _data = barcodeScanRes;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: double.infinity,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextButton(
//             child: const Text('Scan QRcode',
//                 style: TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold)),
//             onPressed: () => scanQR(ScanMode.QR),
//             style: const ButtonStyle(
//               backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
//             ),
//           ),
//           const SizedBox(
//             width: 12,
//           ),
//           TextButton(
//             child: const Text('Scan BARCODE',
//                 style: TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold)),
//             onPressed: () => scanQR(ScanMode.BARCODE),
//             style: const ButtonStyle(
//               backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
//             ),
//           ),
//           Text(_data)
//         ],
//       ),
//     );
//   }
// }
//
// class Qr_Image extends StatelessWidget {
//   const Qr_Image({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return QrImage(
//       data: "",
//       backgroundColor: Colors.black26,
//       embeddedImageStyle:
//           QrEmbeddedImageStyle(color: Colors.blue, size: const Size(12, 13)),
//       dataModuleStyle: const QrDataModuleStyle(
//         color: Colors.blueAccent,
//         dataModuleShape: QrDataModuleShape.square,
//       ),
//     );
//   }
// }

// class QRViewExample extends StatefulWidget {
//   const QRViewExample({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }
//
// class _QRViewExampleState extends State<QRViewExample> {
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//
//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 4, child: _buildQrView(context)),
//           Expanded(
//             flex: 1,
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   if (result != null)
//                     Text(
//                         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//                   else
//                     const Text('Scan a code'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                             onPressed: () async {
//                               await controller?.toggleFlash();
//                               setState(() {});
//                             },
//                             child: FutureBuilder(
//                               future: controller?.getFlashStatus(),
//                               builder: (context, snapshot) {
//                                 return Text('Flash: ${snapshot.data}');
//                               },
//                             )),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                             onPressed: () async {
//                               await controller?.flipCamera();
//                               setState(() {});
//                             },
//                             child: FutureBuilder(
//                               future: controller?.getCameraInfo(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.data != null) {
//                                   return Text(
//                                       'Camera facing ${describeEnum(snapshot.data!)}');
//                                 } else {
//                                   return const Text('loading');
//                                 }
//                               },
//                             )),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await controller?.pauseCamera();
//                           },
//                           child: const Text('pause',
//                               style: TextStyle(fontSize: 20)),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await controller?.resumeCamera();
//                           },
//                           child: const Text('resume',
//                               style: TextStyle(fontSize: 20)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
