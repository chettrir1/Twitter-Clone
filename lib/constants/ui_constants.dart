import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/theme/pallete.dart';

import 'constants.dart';

class UiConstants {
  static AppBar appBar() {
    return AppBar(
        title: SvgPicture.asset(AssetsConstants.twitterLogo,
            colorFilter:
                const ColorFilter.mode(Pallete.blueColor, BlendMode.srcIn),
            height: 30),
        centerTitle: true);
  }

  static List<Widget> bottomTabBarPages = [
    const Text("Feed Screen"),
    const Text("Search Screen"),
    const Text("Notification Screen"),
  ];
}
