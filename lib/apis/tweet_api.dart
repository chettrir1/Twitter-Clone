import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import '../constants/constants.dart';

final tweetApiProvider = Provider((ref) {
  final database = ref.watch(appwriteDatabaseProvider);
  return TweetAPI(db: database);
});

abstract class ITweetApi {
  FutureEither<Document> shareTweet(TweetModel tweetModel);
}

class TweetAPI implements ITweetApi {
  final Databases _db;

  TweetAPI({required Databases db}) : _db = db;

  @override
  FutureEither<Document> shareTweet(TweetModel tweetModel) async {
    try {
      final document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.tweetsCollection,
        documentId: ID.unique(),
        data: tweetModel.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
        e.message ?? "Some unexpected error occurred!",
        stackTrace.toString(),
      ));
    } catch (e, stackTrace) {
      return left(Failure(
        e.toString(),
        stackTrace.toString(),
      ));
    }
  }
}
