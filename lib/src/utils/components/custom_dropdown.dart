import 'package:dogs/src/utils/exports.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
    this.label, {
    this.hint,
    super.key,
    required this.provider,
    this.validator,
    this.onChange,
    required this.items,
  });

  final AddPetDetailsProvider provider;
  final void Function(DropdownModel?)? onChange;
  final String label;
  final String? hint;
  final List<DropdownModel> items;
  final String? Function(DropdownModel?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        CustomText(
          label,
        ),
        DropdownButtonFormField(
          isDense: true,
          dropdownColor: Colors.white,
          validator: validator,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black,
          ),
          value: provider.selectedPetType,
          hint: CustomText(
            hint ?? '',
            color: AppData.textColorHint,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          items: items.map((DropdownModel type) {
            return DropdownMenuItem(
                value: type,
                child: CustomText(
                  type.name,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ));
          }).toList(),
          onChanged: onChange,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              focusedBorder: customBorder(),
              enabledBorder: customBorder(),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              border: customBorder()),
        ),
      ],
    );
  }
}

class DropdownModel {
  String name, code;

  DropdownModel({required this.name, required this.code});
}
