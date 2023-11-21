import 'package:joiner_1/service/api_service.dart';

export 'utils.dart';

const environment = 'OFFLINE';

String getImageUrl(String imageUrl) {
  if (imageUrl.startsWith('http'))
    return imageUrl;
  else
    return '$serverUrl$imageUrl';
}

String? isEmpty(String? value) {
  if (value == null || value.trim().isEmpty) return 'Field is empty';
  return null;
}
