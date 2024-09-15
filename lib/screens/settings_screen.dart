import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ice_hockey_ball/screens/change_language_screen.dart';
import 'package:ice_hockey_ball/screens/game_screen.dart';
import 'package:ice_hockey_ball/screens/privacy_policy_screen.dart';
import 'package:ice_hockey_ball/utils/screen_navigation_extension.dart';
import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../widgets/custom_text.dart';
import '../constants/string_const.dart';
import '../controller/language_controller.dart';
import 'intro_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.fromScreen});
final String fromScreen;
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var box = GetStorage();
  int player1Wins = 0;
  int player2Wins = 0;
  int sgPlayer1Wins = 0;
  int sgPlayer2Wins = 0;
  bool isAiThinking = false;

  final AudioPlayer player1 = AudioPlayer();
  final AudioPlayer player = AudioPlayer();
  bool isMuted = true;

  @override
  void initState() {
    playSound();
    getScore();
    super.initState();
  }
void getScore(){

    setState(() {
      player1Wins =box.read("p1") ?? 0;
      player2Wins = box.read("p2") ?? 0;
    });
}
  void playSound() async {
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(
      AssetSource('audio/MainTheme.mp3'),
    );

    if (isMuted) {
      player.setVolume(0.0);
    } else {
      player.setVolume(1.0);
    }
    setState(() {});
  }

  void setSoundOnOff() async {
    final box = GetStorage();
    setState(() {
      isMuted = !isMuted;
      if (isMuted) {
        player.setVolume(0.0);
      } else {
        player.setVolume(1.0);
      }
    });

    box.write("isMuted", isMuted);
  }

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          iconSize: 40.sp,
          icon: Image.asset('assets/images/back_btn.webp'),
          onPressed: () {
            if(widget.fromScreen == "i"){
              context.navigateAndRemoveUntil( const IntroScreen(), false);
            }else{

            context.navigateAndRemoveUntil( AirHockey(), true);}
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: CustomText(
          text: "settings".tr,
          color: whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: CustomText(
                    text: "score_board".tr,
                    color: whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 80.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/board.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: 'player1'.tr,
                            color: whiteColor,
                            fontSize: 12.sp,
                          ),
                          kSizedBoxW10,
                          AnimatedNumberText(
                            player1Wins, // int or double
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1),
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: yellowColor,
                                fontFamily: "Audiowide"),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          AnimatedNumberText(
                            player2Wins, // int or double
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1),
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: yellowColor,
                                fontFamily: "Audiowide"),
                          ),
                          kSizedBoxW10,
                          CustomText(
                            text: 'player2'.tr,
                            color: whiteColor,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              kSizedBoxH30,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: CustomText(
                    text: "language_settings".tr,
                    color: whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
Get.to(const ChangeLanguageScreen());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "change_language".tr,
                        color: whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      kSizedBoxW5,
                   Icon(Icons.language, color: whiteColor,size: 35.w
                     ,)
                    ],
                  ),
                ),
              ),
              kSizedBoxH30,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: CustomText(
                    text: "sound_settings".tr,
                    color: whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  setSoundOnOff();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "sound".tr,
                        color: whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      kSizedBoxW5,
                      Image.asset(
                          (isMuted == true)
                              ? "assets/images/sound_off.webp"
                              : "assets/images/sound_btn.webp",
                          width: 40.w,
                          height: 40.h)
                    ],
                  ),
                ),
              ),
              kSizedBoxH30,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: CustomText(
                    text: "general".tr,
                    color: whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  context.navigateAndRemoveUntil(const PrivacyPolicy(), true);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "policy".tr,
                          color: whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                      kSizedBoxW5,
                      Image.asset('assets/images/privacy.webp',
                          width: 40.w, height: 40.h),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: MediaQuery.of(context).size.width,
                height: 60.h,
                decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "version".tr,
                        color: whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                    kSizedBoxW5,
                    CustomText(
                        text: version,
                        color: whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              ),
              kSizedBoxH30,
            ],
          ),
        ),
      ),
    );
  }
}
