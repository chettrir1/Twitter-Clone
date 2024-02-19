import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/tweet/view/create_tweet_view.dart';
import 'package:twitter_clone/theme/theme.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final appBar = UiConstants.appBar();
  int _page = 0;

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  onCreateTweet() {
    Navigator.push(context, CreateTweetView.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _page,
        children: UiConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweet,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  (_page == 0)
                      ? AssetsConstants.homeFilledIcon
                      : AssetsConstants.homeOutlinedIcon,
                  colorFilter: const ColorFilter.mode(
                      Pallete.whiteColor, BlendMode.srcIn))),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsConstants.searchIcon,
                  colorFilter: const ColorFilter.mode(
                    Pallete.whiteColor,
                    BlendMode.srcIn,
                  ))),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  (_page == 2)
                      ? AssetsConstants.notifFilledIcon
                      : AssetsConstants.notifOutlinedIcon,
                  colorFilter: const ColorFilter.mode(
                    Pallete.whiteColor,
                    BlendMode.srcIn,
                  )))
        ],
      ),
    );
  }
}
