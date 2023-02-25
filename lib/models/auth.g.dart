// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth(
    status: json['status'] as int,
    user_id: json['user_id'] as int,
    token: json['token'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'status': instance.status,
      'user_id': instance.user_id,
      'token': instance.token,
      'message': instance.message,
    };
