class ResponseModel {
  String? error;
  String? error_code;
  var data;

  ResponseModel({this.error, this.error_code, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    error_code = json['error_code'];
    data = json['data'];
  }

  @override
  String toString() {
    return 'ResponseModel{error: $error, error_code: $error_code, data: $data}';
  }
}
