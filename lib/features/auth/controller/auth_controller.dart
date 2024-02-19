import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';

/*here state_notifier is used so that we can expose the value
* which can be updated and also be read so, it is an upgrade
* to normal provider*/
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authApi = ref.watch(authApiProvider);
  return AuthController(
    authAPI: authApi,
  );
});

final currentUserAccountProvider = FutureProvider((ref) {
/*dont forget the notifier otherwise it will give
*you the isLoading value*/
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);

  Future<User?> currentUser() => _authAPI.currentUserAccount();

  //state = isLoading
  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authAPI.signUp(email: email, password: password);
    state = false;
    response.fold((left) => showSnackBar(context, left.message), (right) {
      showSnackBar(context, "Account Created! Please Login.");
      Navigator.push(context, LoginView.route());
    });
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authAPI.login(email: email, password: password);
    state = false;
    response.fold((left) => showSnackBar(context, left.message), (right) {
      Navigator.push(context, HomeView.route());
    });
  }
}
