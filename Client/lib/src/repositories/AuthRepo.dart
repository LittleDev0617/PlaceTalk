import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../models/UserAuthStatusModel.dart';
import '../models/UserModel.dart';

class AuthRepo {
  Future<UserAuthStatusModel> kakaoLogin() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        return UserAuthStatusModel.granted;
      } catch (error) {
        try {
          // 카카오톡으로 로그인
          await UserApi.instance.loginWithKakaoTalk();
          return UserAuthStatusModel.granted;
        } catch (error) {
          try {
            // 카카오계정으로 로그인
            await UserApi.instance.loginWithKakaoAccount();

            return UserAuthStatusModel.granted;
          } catch (error) {
            return UserAuthStatusModel.denied;
          }
        }
      }
    } else {
      try {
        // 카카오톡으로 로그인
        await UserApi.instance.loginWithKakaoTalk();
        return UserAuthStatusModel.granted;
      } catch (error) {
        try {
          // 카카오계정으로 로그인
          await UserApi.instance.loginWithKakaoAccount();

          return UserAuthStatusModel.granted;
        } catch (error) {
          return UserAuthStatusModel.denied;
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

      return UserModel(
        email: user.kakaoAccount?.email,
        kakaoID: user.id,
      );
    } catch (error) {
      rethrow;
    }
  }
}
