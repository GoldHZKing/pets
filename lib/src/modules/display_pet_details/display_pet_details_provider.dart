import 'package:dogs/src/utils/exports.dart';
import 'package:flutter/cupertino.dart';


class DisplayPetDetailsProvider extends ChangeNotifier {
  DisplayPetDetailsProvider() : super() {
    _initialFunctions();
  }

  PetDetailsModel? petDetailsModel;
bool isError=false;
  _initialFunctions() async {
 await  getPetDetails();
  }
getPetDetails()async{
  try {
    isError=false;
    Response? response =
        await HttpServices.getMethod(path: EndPoints.getPetDetails);
    if (response != null && response.statusCode == 200) {
      petDetailsModel = PetDetailsModel.fromJson(response.data);
      notifyListeners();
    }
  } catch (e, a) {
    isError=true;
    petDetailsModel = null;
    debugPrint(a.toString());
    notifyListeners();
  }
}
  onTapAddNewPet() {
    Navigator.push(
        navigatorKey.currentContext!,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => AddPetDetailsProvider(),
                  child: AddPetDetailsPage(),
                )));
  }
}
