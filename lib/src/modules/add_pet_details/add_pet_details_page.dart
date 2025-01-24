

import 'package:dogs/src/utils/exports.dart';




class AddPetDetailsPage extends StatelessWidget {
  const AddPetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AddPetDetailsProvider provider = context.read<AddPetDetailsProvider>();
    return CustomScaffold( title: 'Add your pet detail',
      body: CustomPadding( padding: EdgeInsets.only(bottom: 15),
        child: Form( key: provider.formKey,
          child: Column(

            children: [
            Expanded(
              child: SingleChildScrollView( padding: EdgeInsets.only(bottom: 30),
                child: Column( mainAxisSize: MainAxisSize.min,  spacing: 10,
                  children: [
                  CustomTextField(
                    'Your pet name', controller: provider.petName,
                    hint: 'enter your pet name', validator: provider.petNameValidation,
                  ),
                  CustomTextField(
                    'Your pet owner name', validator: provider.petOwnerNameValidation,
                    hint: 'enter your pet owner name', controller:  provider.ownerName,
                  ),

                  CustomDropDown(
                    'Type of Pet',
                    hint: 'ex.dog',
                    items: provider.petsTypeList,
                    provider: provider, validator: provider.typeOfPetValidation,
                    onChange: provider.onChangePetsType,
                  ),
                  CustomDropDown(
                    'Gender',
                    hint: 'ex.male',
                    items: provider.genderList,
                    provider: provider, validator: provider.genderValidation,
                    onChange: provider.onChangeGender,
                  ),
                    CustomTextField(
                      'Enter pet location', validator: provider.locationValidation,
                      hint: 'enter your pet location',controller: provider.location,
                    ),
                  TextArea('Additional Notes',controller: provider.additionalNotes,),
                  ImageUploadButton(provider),
                ],),
              ),
            ),
              SubmitButtonWithIcon(
                label: 'Submit', onPressed:provider.submitBtnPressed?null: provider.validation,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageUploadButton extends StatelessWidget {
  const ImageUploadButton(
    this.provider, {
    super.key,
  });

  final AddPetDetailsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        CustomText('Add your pet profile picture and upload pet photos'),
        InkWell(
          onTap: provider.pickImagesFromGallery,
          child: DottedBorder(
            color: Color(0xFF494FDD),
            padding: EdgeInsets.symmetric(vertical: 8),
            strokeCap: StrokeCap.butt,
            radius: Radius.circular(30),
            dashPattern: [2],
            borderType: BorderType.RRect,
            child: Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  'Upload Photos', fontWeight: FontWeight.bold,
                  color: Color(0xFF494FDD),
                ),
                Icon(
                  Icons.file_upload_outlined,
                  color: Color(0xFF494FDD),
                )
              ],
            ),
          ),
        ),
        if (context.select((AddPetDetailsProvider a) => a.pickedImage == null && a.pickedImageWarning!=null))
          CustomPadding( padding: EdgeInsets.only(left: 12),
              child: Selector (
  selector: (context, AddPetDetailsProvider p) => p.pickedImageWarning,
  builder: (context, v, child) {
    return CustomText(v!,color: Colors.red.shade800,fontSize: 12,);
  },
)),
        if (context.select((AddPetDetailsProvider a) => a.pickedImage != null))
          Selector(
            selector: (context, AddPetDetailsProvider p) => p.pickedImage,
            builder: (context, v, child) {
              return CustomPadding(
                child: Stack( clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)), clipBehavior: Clip.hardEdge,
                      child: Image.file(
                        File(v!.path),
                        height: 62,
                        width: 62,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned( right:-3,top:-3,
                        child: CustomIconButton(  onPressed: provider.deleteImage,
                      Icons.horizontal_rule,
                      iconColor: Colors.white,
                      bgColor: Colors.red,
                    ))
                  ],
                ),
              );
            },
          )
        
      ],
    );
  }
}

class TextArea extends StatelessWidget {
  const TextArea(
    this.label, {
    this.controller,
    super.key,
  });

  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration( filled: true,fillColor: Colors.grey.shade50,isDense: true,
            border: customBorder(radius: 15), enabledBorder: customBorder(radius: 15),focusedBorder: customBorder(radius: 15,borderColor: AppData.primaryColor)
          ),
        ),
      ],
    );
  }
}



