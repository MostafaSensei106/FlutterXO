import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../config/fonts/fonts.dart';

class LottieComponent extends StatelessWidget {
  const LottieComponent({
    required this.lottiePath,
    required this.text,
    super.key,
  });
  final String lottiePath;
  final String text;

  @override
  /// Returns a [Column] widget with a [Lottie.asset] widget and a [Text]
  /// widget as children. The [Lottie.asset] widget is configured with the
  /// given [lottiePath], and a width and height of 200 logical pixels. The
  /// [Text] widget is configured with the given [text], and a font size of
  /// 16 logical pixels, and a color of the primary color of the theme.
  Widget build(final BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        lottiePath,
        width: 200.w,
        height: 200.h,
        fit: BoxFit.cover,
        options: LottieOptions(enableMergePaths: true),
      ),
      SizedBox(height: 10.h),
      Text(
        text,
        style: AppTextStyle(context).subtitle.copyWith(fontSize: 16.sp),
      ),
    ],
  );
}
