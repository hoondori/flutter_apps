import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {

    final String? uid;
    final String? nickName;
    final double? temperature; // 신뢰도
    final DateTime? createdAt;
    final DateTime? updatedAt;


    const UserModel({
      this.uid,
      this.nickName,
      this.createdAt,
      this.updatedAt,
      this.temperature,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) =>
        _$UserModelFromJson(json);

    factory UserModel.create(String name, String uid) {
      return UserModel(nickName: name,
          uid: uid,
          temperature: Random().nextInt(100) + 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
    }

    Map<String, dynamic> toJson() => _$UserModelToJson(this);

    @override
    List<Object?> get props => [
      uid,
      nickName,
      temperature,
      createdAt,
      updatedAt,
    ];

}