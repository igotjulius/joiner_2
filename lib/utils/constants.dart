import 'package:joiner_1/service/api_service.dart';

export 'constants.dart';

const environment = 'TEST';
const device = 'MOBILE';

String getImageUrl(String craUserId, String imageUrl) {
  if (environment == 'TEST' && device == 'MOBILE')
    return '${serverUrl}images/$craUserId/$imageUrl';
  else
    return imageUrl;
}
