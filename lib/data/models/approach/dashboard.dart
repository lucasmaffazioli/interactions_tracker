import 'dart:convert';

class DashboardApproachesCountModel {
  final int approaches;

  DashboardApproachesCountModel.fromMap(Map map) : this.approaches = map["approaches"];

  String toJson() {
    return json.encode({
      'approaches': approaches,
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
