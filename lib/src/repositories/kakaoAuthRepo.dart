import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:placex/src/models/kakaoUserLoginStatus.dart';

import '../models/usersModel.dart';

class kakaoAuthRepo {
  Future<kakaoUserLoginStatus> kakaoLogin() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        return kakaoUserLoginStatus.granted;
      } catch (error) {
        try {
          // 카카오톡으로 로그인
          await UserApi.instance.loginWithKakaoTalk();
          return kakaoUserLoginStatus.granted;
        } catch (error) {
          try {
            // 카카오계정으로 로그인
            await UserApi.instance.loginWithKakaoAccount();

            return kakaoUserLoginStatus.granted;
          } catch (error) {
            return kakaoUserLoginStatus.denied;
          }
        }
      }
    } else {
      try {
        // 카카오톡으로 로그인
        await UserApi.instance.loginWithKakaoTalk();
        return kakaoUserLoginStatus.granted;
      } catch (error) {
        try {
          // 카카오계정으로 로그인
          await UserApi.instance.loginWithKakaoAccount();

          return kakaoUserLoginStatus.granted;
        } catch (error) {
          return kakaoUserLoginStatus.denied;
        }
      }
    }
  }

  kakaoLogout() async {
    try {
      await UserApi.instance.logout();
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel> kakaoGetUsers() async {
    try {
      User user = await UserApi.instance.me();
      return UserModel(email: user.kakaoAccount?.email, kakaoID: user.id);
    } catch (error) {
      rethrow;
    }
  }
}
