class RandomNumber {
  String? status;
  int? min;
  int? max;
  int? random;

  RandomNumber({this.status, this.min, this.max, this.random});

  RandomNumber.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    min = json['min'];
    max = json['max'];
    random = json['random'];
  }


}