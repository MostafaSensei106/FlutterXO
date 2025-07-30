import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/config/const/sensei_const.dart';

class OnboardingPageOne extends StatelessWidget {
  const OnboardingPageOne({super.key});

  @override
  Widget build(final BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 24.5.h),
        Container(
          padding: const EdgeInsets.all(SenseiConst.padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
            child: Image.asset(
              SenseiConst.tadamonAppImage,
              width: 200.w,
              height: 200.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'تطبيق تَضَامُنٌ',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            'التطبيق الذي يساعدك على دعم القضية الفلسطينية وتقديم المساعدات للمحتاجين بكل سهولة.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(0x80),
            ),
          ),
        ),
      ],
    ),
  );
}
