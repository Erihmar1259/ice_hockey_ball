import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ice_hockey_ball/screens/game_screen.dart';
import 'package:ice_hockey_ball/screens/settings_screen.dart';
import 'package:ice_hockey_ball/utils/screen_navigation_extension.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/color_const.dart';
import '../constants/dimen_const.dart';
import '../constants/image_const.dart';
import '../utils/global.dart';
import '../widgets/custom_image_button.dart';
import '../widgets/custom_text.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    first = box.read('first') ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 1.sh * 0.80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                  height: 1.sh * 0.65,
                                  width: double.infinity,
                                  child: WebViewWidget(
                                      controller: WebViewController()
                                        ..loadHtmlString(Global.policyEn))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: mainColor,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked ? mainColor : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                const CustomText(
                                  text: "I agree to the privacy policy",
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateColor.resolveWith((states) =>
                                  isAccepted ? mainColor : greyColor)),
                              // ignore: sort_child_properties_last
                              child: CustomText(
                                text: "Accept and Continue",
                                color: whiteColor,
                              ),
                              onPressed: isAccepted
                                  ? () async {
                                final box = GetStorage();
                                box.write('first', 'notfirst');
                                Navigator.pop(context);
                              }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        // print("Error fetching SharedPreferences: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(AirHockeyController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    context.navigateAndRemoveUntil(
                        const SettingsScreen(fromScreen: "i",), true);
                  },
                  child: Image.asset(settingImg)),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.webp"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CustomImageButton(
                btnLabel: "Play Now",
                onTapFun: () {
                  // controller.isSinglePlayer.value = true;
                   context.navigateAndRemoveUntil( AirHockey(), true);
                },
              ),
              kSizedBoxH20,

              CustomImageButton(
                  btnLabel: "Exit",
                  onTapFun: () {
                    exit(0);
                  }),
            ],
          ),
        ));
  }
}
