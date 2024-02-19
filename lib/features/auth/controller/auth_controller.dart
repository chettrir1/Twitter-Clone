import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';

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

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);

  //state = isLoading
  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authAPI.signUp(email: email, password: password);
    state = false;
    response.fold(
        (left) => showSnackBar(context, left.message), (right) => right.email);
  }
}
