

import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth{

  int status;
  int user_id;
  String token;
  String message;

  Auth({
    required this.status,
    required this.user_id,
    required this.token,
    required this.message,
  });

  factory Auth.fromJson(Map<String,dynamic> data) => _$AuthFromJson(data);

  Map<String,dynamic> toJson() => _$AuthToJson(this);

}