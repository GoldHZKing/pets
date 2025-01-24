
 import 'package:dogs/src/utils/exports.dart';


class AddPetDetailsProvider extends ChangeNotifier {
  AddPetDetailsProvider() : super() {}
  DropdownModel? selectedPetType;
  DropdownModel? selectedGender;
  XFile? pickedImage;
  bool submitBtnPressed = false;
  GlobalKey<FormState> formKey = GlobalKey();
  final List<DropdownModel> petsTypeList = [
    DropdownModel(name: 'Dog', code: 'T001'),
    DropdownModel(name: 'Bird', code: 'T002'),
  ];
  final List<DropdownModel> genderList = [
    DropdownModel(name: 'male', code: 'G001'),
    DropdownModel(name: 'female', code: 'G002'),
  ];

  TextEditingController petName = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController additionalNotes = TextEditingController();

  onChangePetsType(DropdownModel? data) {
    selectedPetType = data;
    notifyListeners();
  }

  onChangeGender(DropdownModel? data) {
    selectedGender = data;
    notifyListeners();
  }

  pickImagesFromGallery() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedImage = file;
      notifyListeners();
    }
  }

  deleteImage() {
    pickedImage = null;
    notifyListeners();
  }

  String? petNameValidation(String? data) =>
      data == null || data
          .trim()
          .isEmpty
          ? 'Please enter the your pet name'
          : null;

  String? petOwnerNameValidation(String? data) =>
      data == null || data
          .trim()
          .isEmpty
          ? 'Please enter the pet owner name'
          : null;

  String? locationValidation(String? data) =>
      data == null || data
          .trim()
          .isEmpty ? 'Please enter location' : null;

  String? typeOfPetValidation(DropdownModel? data) =>
      data == null ? 'Please Select the type of pet' : null;

  String? genderValidation(DropdownModel? data) =>
      data == null ? 'Please Select gender' : null;
  String?pickedImageWarning;

  validation() async {
    if (submitBtnPressed) return;
    submitBtnPressed = true;
    if (pickedImage == null) {
      pickedImageWarning = 'Please pick the pick the photo from gallery';
    }
    notifyListeners();
    if (formKey.currentState!.validate()) {
      try {
        await _sendToServer().then((a) =>
        {
          submitBtnPressed = false
        });
      } catch (e) {
        submitBtnPressed = false;
      }
    } else {
      submitBtnPressed = false;
    }
  }

  Future _sendToServer() async {
    var body = {
      "pet_name": petName.text.trim(),
      "user_name": ownerName.text.trim(),
      "pet_type": selectedPetType?.name,
      "gender": selectedGender?.name,
      "location": location.text.trim(),
      "image": await MultipartFile.fromFile(
        pickedImage!.path,
        filename: pickedImage!
            .path
            .split('/')
            .last,
      ),
    };
    await HttpServices.postMethod(path: EndPoints.addPets, body: body)?.then((
        Response a) {

      if (a.statusCode == 200) {
        navigatorKey.currentContext!.read<DisplayPetDetailsProvider>().getPetDetails();

        Navigator.pop(navigatorKey.currentContext!);
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            SnackBar(content: CustomText(
                'Success.',color: Colors.white,)));
      }
      else {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            SnackBar(content: CustomText(
                'Something went wrong.Please try again later.',color: Colors.white,)));
      }
    });

   }
}


