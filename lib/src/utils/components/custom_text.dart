import 'package:dogs/src/utils/exports.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.data,
      {super.key, this.color, this.fontSize, this.fontWeight,this.overflow,});

  final String data;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 15, overflow:overflow,
          fontWeight: fontWeight ?? FontWeight.w500),
    );
  }
}
