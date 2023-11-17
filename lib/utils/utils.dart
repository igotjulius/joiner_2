import 'package:joiner_1/service/api_service.dart';

export 'utils.dart';

const environment = 'TEST';
const device = 'MOBILE';

String getImageUrl(String craUserId, String imageUrl) {
  if (environment == 'TEST' && device == 'MOBILE')
    return '${serverUrl}images/$craUserId/$imageUrl';
  else
    return imageUrl;
}

String? isEmpty(String? value) {
  if (value == null || value.trim().isEmpty) return 'Field is empty';
  return null;
}
