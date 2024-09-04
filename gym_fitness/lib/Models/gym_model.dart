class GymMobel {
  String? gymName;
  String? gymLogo;

  GymMobel({this.gymName, this.gymLogo});

  GymMobel.fromJson(Map<String, dynamic> json) {
    gymName = json['gym_name'];
    gymLogo = json['gym_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gym_name'] = gymName;
    data['gym_logo'] = gymLogo;
    return data;
  }
}
