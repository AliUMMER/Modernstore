import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/widgets/app_color.dart';

class fontStyles {
  static TextStyle heading1 = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: appColor.primaryText);

  static TextStyle heading2 = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w600, color: appColor.heading2);

  static TextStyle bodyText = TextStyle(
    fontSize: 11.sp,
    color: appColor.secondaryText,
  );
  static TextStyle primaryTextStyle = TextStyle(
    fontSize: 14.sp,
    color: appColor.primaryText,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
  );

  static TextStyle errorstyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    color: appColor.errorColor,
  );
  static TextStyle errorstyle2 = TextStyle(
    fontSize: 12.sp,
    color: appColor.onError,
  );
}
