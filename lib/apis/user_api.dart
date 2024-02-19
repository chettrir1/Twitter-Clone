import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/models/user_model.dart';

final userApiProvider = Provider((ref) {
  final database = ref.watch(appwriteDatabaseProvider);
  return UserAPI(db: database);
});

abstract class IUserApi {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserAPI implements IUserApi {
  Databases _db;

  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: ID.unique(),
        data: userModel.toMap(),
      );
      return right(null);
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
