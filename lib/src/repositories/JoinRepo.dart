import 'package:placetalk/src/repositories/SessionRepo.dart';

class JoinRepo {
  final SessionRepo _sessionRepo;

  JoinRepo(this._sessionRepo);

  Future<int> toJoinBoard(int placeID) async {
    final apiData = await _sessionRepo.get('api/places/$placeID/join');

    final code = apiData[0]['code'];

    return code;
  }

  void toExitBoard(int placeID) async {
    await _sessionRepo.get('api/places/$placeID/exit');
  }
}
