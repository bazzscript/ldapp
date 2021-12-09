import 'dart:math';

class Util {}

bool checkifGameNameExists(List gamelist, String gamename) {
  for (var i = 0; i < gamelist.length; i++) {
    if (gamelist[i].gamename == gamename) {
      return true;
    }
  }
  return false;
}

getGameIdGivenGameName(List gamelist, String gamename) {
  for (var i = 0; i < gamelist.length; i++) {
    if (gamelist[i].gamename == gamename) {
      return gamelist[i].gameid;
    }
  }
  return null;
}

int randomNumberGenerator(int min, int max) {
  return min + Random().nextInt(max - min);
}
