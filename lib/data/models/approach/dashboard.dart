class DashboardModel {
  final int pointId;
  final double pointAvg;
  final String pointName;
  final String pointType;

  // DashboardModel({
  //   this.pointId,
  //   this.pointAvg,
  //   this.pointName,
  //   this.pointType,
  // });

  DashboardModel.fromMap(Map map)
      : this.pointId = map["pointId"],
        this.pointAvg = map["pointAvg"],
        this.pointName = map["pointName"],
        this.pointType = map["pointType"];
}
