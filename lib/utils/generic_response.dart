import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseModel<T> {
  int? code;
  String? message;
  @JsonKey(
    fromJson: _fromJson,
    toJson: _toJson,
    name: 'data',
  )
  T? data;

  ResponseModel({this.code, this.data, this.message});

  static T? _fromJson<T>(Object? json) {
    var converted;
    if (json is Map<String, dynamic>) {
      if (json.containsKey('email'))
        converted = UserModel.fromJson(json);
      else if (json.containsKey('pending')) {
        var pending = json['pending'] as List;
        var active = json['active'] as List;
        converted = {
          'pending':
              pending.map((element) => LobbyModel.fromJson(element)).toList(),
          'active':
              active.map((element) => LobbyModel.fromJson(element)).toList()
        };
      } else if (json.containsKey('participants')) {
        converted = LobbyModel.fromJson(json);
      }
      return converted as T;
    } else if (json is List<dynamic>) {
      if (json.isEmpty) {
        return null;
      }
      var data = json.asMap()[0];

      if (data.containsKey('creator')) {
        converted =
            json.map((element) => MessageModel.fromJson(element)).toList();
      } else if (data.containsKey('vehicleType')) {
        converted = json.map((element) => CarModel.fromJson(element)).toList();
      } else if (data.containsKey('joinStatus')) {
        converted =
            json.map((element) => ParticipantModel.fromJson(element)).toList();
      } else if (data.containsKey('friendId')) {
        converted = json
            .map((element) => {
                  'friendName': element['friendName'] as String,
                  'friendId': element['friendId'] as String,
                  'status': element['status'] as String,
                })
            .toList();
      }
      return converted as T;
    } else if (json == null) {
      return json as T;
    }
    throw ArgumentError.value(json, 'json', 'Cannot handle this JSON payload');
  }

  static Object _toJson<T>(T object) {
    if (object is Serializable) return object.toJson();
    throw ArgumentError.value(object, 'Cannot serialize to JSON',
        'This object is not serializable or unrecognized.');
  }

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ResponseModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
