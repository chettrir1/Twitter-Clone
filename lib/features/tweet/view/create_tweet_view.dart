import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetView());

  const CreateTweetView({super.key});

  @override
  ConsumerState createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetView> {
  final tweetTextController = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          RoundedSmallButton(
            onTap: () {},
            label: "Tweet",
            backgroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          )
        ],
      ),
      // body: currentUser == null
      //     ? const Loader()
      //     :
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    radius: 30,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: tweetTextController,
                      style: const TextStyle(fontSize: 22),
                      decoration: const InputDecoration(
                          hintText: "What's happening?",
                          hintStyle: TextStyle(
                              color: Pallete.greyColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                          border: InputBorder.none),
                      maxLines: null,
                    ),
                  )
                ],
              ),
              if (images.isNotEmpty)
                CarouselSlider(
                    items: images.map(
                      (file) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.file(file));
                      },
                    ).toList(),
                    options: CarouselOptions(
                      height: 400,
                      enableInfiniteScroll: false,
                    ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Pallete.greyColor, width: 0.3),
          ),
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(16.0)
                .copyWith(left: 16, right: 16, bottom: 16),
            child: GestureDetector(
              onTap: onPickImages,
              child: SvgPicture.asset(AssetsConstants.galleryIcon),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0)
                .copyWith(left: 16, right: 16, bottom: 16),
            child: SvgPicture.asset(AssetsConstants.gifIcon),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0)
                .copyWith(left: 16, right: 16, bottom: 16),
            child: SvgPicture.asset(AssetsConstants.emojiIcon),
          )
        ]),
      ),
    );
  }
}
