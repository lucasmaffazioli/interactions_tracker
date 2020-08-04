import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@Entity(tableName: 'config', indices: [])
class ConfigModel {
  @PrimaryKey()
  final int id = 1;
  final int lastRunVersion;

  ConfigModel({
    @required this.lastRunVersion,
  });

  String toJson() {
    return json.encode({
      'id': id.toString(),
      'lastRunVersion': lastRunVersion.toString(),
    });
  }
}
