export 'constants.dart';

String getImageUrl(String craUserId, String imageUrl) {
  return 'http://127.0.0.1:443/images/$craUserId/$imageUrl';
}

const environment = 'TEST';
