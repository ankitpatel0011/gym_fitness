import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techsaga/Models/gym_model.dart';
import 'package:techsaga/const/color_const.dart';
import 'package:techsaga/Repository/Server/gym_api.dart';

GymProvider gymProvider = GymProvider();

class GymProvider extends ChangeNotifier {
  List<GymMobel> _gym = [];
  bool _isLoding = false;
  bool get isLoding => _isLoding;
  List<GymMobel> get gym => _gym;

  set setLoading(bool isLoading) {
    _isLoding = isLoading;
    notifyListeners();
  }

  Future getGym() async {
    setLoading = true;
    await GymApi.getGymList().then((onValue) {
      if (onValue["data"] is List) {
        _gym = List.from(
            onValue["data"].map((e) => GymMobel.fromJson(e)).toList());
      } else {
        Fluttertoast.showToast(
          msg: onValue["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: red,
          textColor: white,
          fontSize: 15,
        );
      }
    }).catchError((onError) {
      Fluttertoast.showToast(
        msg: onError.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: red,
        textColor: white,
        fontSize: 15,
      );
    });
    setLoading = false;
    notifyListeners();
  }
}
