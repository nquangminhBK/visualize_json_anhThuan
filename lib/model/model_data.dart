/// success : true
/// message : ""
/// data : {"invoice_cycles":["15 Dec 2022 - 14 Jan 2023","15 Jan 2023 - 14 Feb 2023","15 Feb 2023 - 14 Mar 2023","15 Mar 2023 - 14 Apr 2023","15 Apr 2023 - 14 May 2023"],"data_cycle":"15 Apr 2023 - 14 May 2023","tracked_hours":[{"id":28676,"project_name":"Whizhack","developer_name":"DUONG QUANG Binh","developer_email":"bduongquang@pentalog.com","tracked_secs":38820},{"id":24207,"project_name":"B.E.S.T Budget App","developer_name":"HOANG VAN Thai","developer_email":"thoangvan@pentalog.com","tracked_secs":401275},{"id":29904,"project_name":"Send&End","developer_name":"LE DUC Thang","developer_email":"tleduc@pentalog.com","tracked_secs":288058},{"id":32737,"project_name":"EtOH Suite","developer_name":"NGO TIEN Tan","developer_email":"tngotien@pentalog.com","tracked_secs":0},{"id":32079,"project_name":"GolaVi","developer_name":"NGO TIEN Tan","developer_email":"tngotien@pentalog.com","tracked_secs":57060},{"id":21475,"project_name":"21K_Shared Services_INR","developer_name":"NGO TIEN Tan","developer_email":"tngotien@pentalog.com","tracked_secs":172800},{"id":30957,"project_name":"WLDD- Memer App","developer_name":"NGUYEN ANH Tu","developer_email":"tnguyenanh@pentalog.com","tracked_secs":158410},{"id":30329,"project_name":"Techfin","developer_name":"NGUYEN MINH Tien","developer_email":"tinguyenminh@pentalog.com","tracked_secs":259200},{"id":24308,"project_name":"AA Enterprise Search","developer_name":"NGUYEN THI Trang","developer_email":"tnguyenthi@pentalog.com","tracked_secs":345600},{"id":23286,"project_name":"Ads templates","developer_name":"NGUYEN VAN Dung","developer_email":"dnguyenvan@pentalog.com","tracked_secs":301655},{"id":32740,"project_name":"EtOH Suite","developer_name":"NGUYEN VAN Dung","developer_email":"dnguyenvan@pentalog.com","tracked_secs":0},{"id":30537,"project_name":"Ali's LinkedIn","developer_name":"NGUYEN VAN Thuy","developer_email":"tnguyenvan@pentalog.com","tracked_secs":168708},{"id":26082,"project_name":"Fastel","developer_name":"NGUYEN VIET Anh","developer_email":"anguyenviet@pentalog.com","tracked_secs":291652}]}
/// meta : {}
/// errors : []

class ModelData {
  ModelData({
    bool? success,
    Data? data,
    dynamic meta,
    List<dynamic>? errors,
  }) {
    _success = success;

    _data = data;
    _meta = meta;
    _errors = errors;
  }

  ModelData.fromJson(dynamic json) {
    _success = json['success'];

    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _meta = json['meta'];
  }

  bool? _success;

  Data? _data;
  dynamic _meta;
  List<dynamic>? _errors;

  ModelData copyWith({
    bool? success,
    Data? data,
    dynamic meta,
    List<dynamic>? errors,
  }) =>
      ModelData(
        success: success ?? _success,
        data: data ?? _data,
        meta: meta ?? _meta,
        errors: errors ?? _errors,
      );

  bool? get success => _success;

  Data? get data => _data;

  dynamic get meta => _meta;

  List<dynamic>? get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['meta'] = _meta;
    if (_errors != null) {
      map['errors'] = _errors?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// invoice_cycles : ["15 Dec 2022 - 14 Jan 2023","15 Jan 2023 - 14 Feb 2023","15 Feb 2023 - 14 Mar 2023","15 Mar 2023 - 14 Apr 2023","15 Apr 2023 - 14 May 2023"]
/// data_cycle : "15 Apr 2023 - 14 May 2023"
/// tracked_hours : [{"id":28676,"project_name":"Whizhack","developer_name":"DUONG QUANG Binh","developer_email":"bduongquang@pentalog.com","tracked_secs":38820},{"id":24207,"project_name":"B.E.S.T Budget App","developer_name":"HOANG VAN Thai","developer_email":"thoangvan@pentalog.com","tracked_secs":401275},{"id":29904,"project_name":"Send&End","developer_name":"LE DUC Thang","developer_email":"tleduc@pentalog.com","tracked_secs":288058},{"id":32737,"project_name":"EtOH Suite","developer_name":"NGO TIEN Tan","developer_email":"tngotien@pentalog.com","tracked_secs":0},{"id":32079,"project_name":"GolaVi","developer_name":"NGO TIEN Tan","developer_email":"tngotien@pentalog.com","tracked_secs":57060},{"id":21475,"project_name":"21K_Shared Services_INR","developer_name":"NGO TIEN Tan","developer_email":"tngotien@pentalog.com","tracked_secs":172800},{"id":30957,"project_name":"WLDD- Memer App","developer_name":"NGUYEN ANH Tu","developer_email":"tnguyenanh@pentalog.com","tracked_secs":158410},{"id":30329,"project_name":"Techfin","developer_name":"NGUYEN MINH Tien","developer_email":"tinguyenminh@pentalog.com","tracked_secs":259200},{"id":24308,"project_name":"AA Enterprise Search","developer_name":"NGUYEN THI Trang","developer_email":"tnguyenthi@pentalog.com","tracked_secs":345600},{"id":23286,"project_name":"Ads templates","developer_name":"NGUYEN VAN Dung","developer_email":"dnguyenvan@pentalog.com","tracked_secs":301655},{"id":32740,"project_name":"EtOH Suite","developer_name":"NGUYEN VAN Dung","developer_email":"dnguyenvan@pentalog.com","tracked_secs":0},{"id":30537,"project_name":"Ali's LinkedIn","developer_name":"NGUYEN VAN Thuy","developer_email":"tnguyenvan@pentalog.com","tracked_secs":168708},{"id":26082,"project_name":"Fastel","developer_name":"NGUYEN VIET Anh","developer_email":"anguyenviet@pentalog.com","tracked_secs":291652}]

class Data {
  Data({
    List<String>? invoiceCycles,
    String? dataCycle,
    List<TrackedHours>? trackedHours,
  }) {
    _invoiceCycles = invoiceCycles;
    _dataCycle = dataCycle;
    _trackedHours = trackedHours;
  }

  Data.fromJson(dynamic json) {
    _invoiceCycles = json['invoice_cycles'] != null ? json['invoice_cycles'].cast<String>() : [];
    _dataCycle = json['data_cycle'];
    if (json['tracked_hours'] != null) {
      _trackedHours = [];
      json['tracked_hours'].forEach((v) {
        _trackedHours?.add(TrackedHours.fromJson(v));
      });
    }
  }

  List<String>? _invoiceCycles;
  String? _dataCycle;
  List<TrackedHours>? _trackedHours;

  Data copyWith({
    List<String>? invoiceCycles,
    String? dataCycle,
    List<TrackedHours>? trackedHours,
  }) =>
      Data(
        invoiceCycles: invoiceCycles ?? _invoiceCycles,
        dataCycle: dataCycle ?? _dataCycle,
        trackedHours: trackedHours ?? _trackedHours,
      );

  List<String>? get invoiceCycles => _invoiceCycles;

  String? get dataCycle => _dataCycle;

  List<TrackedHours>? get trackedHours => _trackedHours;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoice_cycles'] = _invoiceCycles;
    map['data_cycle'] = _dataCycle;
    if (_trackedHours != null) {
      map['tracked_hours'] = _trackedHours?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 28676
/// project_name : "Whizhack"
/// developer_name : "DUONG QUANG Binh"
/// developer_email : "bduongquang@pentalog.com"
/// tracked_secs : 38820

class TrackedHours {
  TrackedHours({
    num? id,
    String? projectName,
    String? developerName,
    String? developerEmail,
    num? trackedSecs,
  }) {
    _id = id;
    _projectName = projectName;
    _developerName = developerName;
    _developerEmail = developerEmail;
    _trackedSecs = trackedSecs;
  }

  TrackedHours.fromJson(dynamic json) {
    _id = json['id'];
    _projectName = json['project_name'];
    _developerName = json['developer_name'];
    _developerEmail = json['developer_email'];
    _trackedSecs = json['tracked_secs'];
  }

  num? _id;
  String? _projectName;
  String? _developerName;
  String? _developerEmail;
  num? _trackedSecs;

  TrackedHours copyWith({
    num? id,
    String? projectName,
    String? developerName,
    String? developerEmail,
    num? trackedSecs,
  }) =>
      TrackedHours(
        id: id ?? _id,
        projectName: projectName ?? _projectName,
        developerName: developerName ?? _developerName,
        developerEmail: developerEmail ?? _developerEmail,
        trackedSecs: trackedSecs ?? _trackedSecs,
      );

  num? get id => _id;

  String? get projectName => _projectName;

  String? get developerName => _developerName;

  String? get developerEmail => _developerEmail;

  num? get trackedSecs => _trackedSecs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['project_name'] = _projectName;
    map['developer_name'] = _developerName;
    map['developer_email'] = _developerEmail;
    map['tracked_secs'] = _trackedSecs;
    return map;
  }
}
