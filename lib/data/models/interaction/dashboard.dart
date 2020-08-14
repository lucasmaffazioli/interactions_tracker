import 'dart:convert';

class DashboardInteractionsCountModel {
  final int interactions;

  DashboardInteractionsCountModel.fromMap(Map map) : this.interactions = map["interactions"];

  String toJson() {
    return json.encode({
      'interactions': interactions,
    });
  }
}

class DashboardComplexModel {
  final int pointId;
  final double pointAvg;
  final String pointName;
  final String pointType;

  DashboardComplexModel.fromMap(Map map)
      : this.pointId = map["pointId"],
        this.pointAvg = map["pointAvg"],
        this.pointName = map["pointName"],
        this.pointType = map["pointType"];

  String toJson() {
    return json.encode({
      'pointId': pointId,
      'pointAvg': pointAvg,
      'pointName': pointName,
      'pointType': pointType,
    });
  }
}
