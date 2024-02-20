import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  final tweetApi = ref.watch(tweetApiProvider);
  return TweetController(
    ref: ref,
    tweetAPI: tweetApi,
  );
});

class TweetController extends StateNotifier<bool> {
  final Ref _ref;
  final TweetAPI _tweetAPI;

  TweetController({required Ref ref, required TweetAPI tweetAPI})
      : _ref = ref,
        _tweetAPI = tweetAPI,
        super(false);

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, "Please enter text!");
      return;
    }

    if (images.isNotEmpty) {
      _shareImageTweet(images: images, text: text, context: context);
    } else {
      _shareTextTweet(text: text, context: context);
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {}

  void _shareTextTweet({
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final hashTags = _getHashTagFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    TweetModel tweet = TweetModel(
        text: text,
        hashtags: hashTags,
        link: link,
        imageLinks: const [],
        uid: user.uid,
        tweetType: TweetType.text,
        tweetedAt: DateTime.now(),
        likes: const [],
        commentIds: const [],
        id: "",
        reshareCount: 0,
        retweetedBy: "",
        repliedTo: "");
    final response = await _tweetAPI.shareTweet(tweet);
    state = false;
    response.fold(
        (left) => showSnackBar(context, left.message), (right) => null);
  }

  String _getLinkFromText(String text) {
    String link = "";
    List<String> wordInSentence = text.split(' ');
    for (String word in wordInSentence) {
      if (word.startsWith("https://") || word.startsWith("www.")) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashTagFromText(String text) {
    List<String> hashtags = [];
    List<String> wordInSentence = text.split(' ');
    for (String word in wordInSentence) {
      if (word.startsWith("#")) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
