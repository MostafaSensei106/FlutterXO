import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../../../core/config/const/sensei_const.dart';
import '../../../../../../../core/routing/routes.dart';
import '../../../../../../../core/widgets/button_components/elevated_button_components/elevated_icon_button_component.dart';

class DotIndicatorNav extends StatefulWidget {
  const DotIndicatorNav({required this.pageController, super.key});

  final PageController pageController;

  @override
  State<DotIndicatorNav> createState() => _DotIndicatorNavState();
}

class _DotIndicatorNavState extends State<DotIndicatorNav> {
  bool _isLastPage = false;
  bool _isFirstPage = true;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }

  void _pageListener() {
    final currentPage = (widget.pageController.page ?? 0).round();
    final isFirstPage = currentPage == 0;
    final isLastPage = currentPage == 3;

    if (isFirstPage != _isFirstPage || isLastPage != _isLastPage) {
      setState(() {
        _isFirstPage = isFirstPage;
        _isLastPage = isLastPage;
      });
    }
  }

  Widget _getActionButton(
    final String key,
    final String label,
    final IconData icon,
    final VoidCallback onPressed,
  ) => ElevatedIconButtonComponent(
    key: ValueKey(key),
    useInBorderRadius: true,
    label: label,
    icon: icon,
    onPressed: onPressed,
  );

  void _handleNavigation(final VoidCallback action) {
    HapticFeedback.vibrate();
    action();
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
    animation: widget.pageController,
    builder: (final context, final child) => Positioned(
      bottom: 0,
      left: 10,
      right: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SenseiConst.padding.w,
          vertical: SenseiConst.padding.h,
        ),
        child: Container(
          padding: EdgeInsets.all(SenseiConst.padding.w),
          alignment: Alignment.bottomCenter,
          width: 1.sw,
          height: 0.08.sh,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(0X80),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (final child, final animation) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: SizedBox(
                        width: 0.3.sw,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                child: _isFirstPage
                    ? _getActionButton(
                        'skip',
                        'تخطي',
                        Icons.keyboard_double_arrow_right_rounded,
                        () => _handleNavigation(() {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.onBoarding,
                            (final route) => false,
                          );
                        }),
                      )
                    : _getActionButton(
                        'previous',
                        'السابق',
                        Icons.keyboard_double_arrow_right_rounded,
                        () => _handleNavigation(() {
                          widget.pageController.previousPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                        }),
                      ),
              ),
              SmoothPageIndicator(
                controller: widget.pageController,
                count: 4,
                effect: ExpandingDotsEffect(
                  dotWidth: SenseiConst.indicatorDotSize,
                  dotHeight: SenseiConst.indicatorDotSize,
                  dotColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha((0.5 * 255).toInt()),
                  activeDotColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  expansionFactor: 2,
                ),
                onDotClicked: (final index) {
                  widget.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (final child, final animation) =>
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: SizedBox(
                          width: 0.3.sw,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                      ),
                  child: _isLastPage
                      ? _getActionButton(
                          'start',
                          'بدء',
                          Icons.keyboard_double_arrow_left_rounded,
                          () => _handleNavigation(() {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.onBoarding,
                              (final route) => false,
                            );
                          }),
                        )
                      : _getActionButton(
                          'next',
                          'التالي',
                          Icons.keyboard_double_arrow_left_rounded,
                          () => _handleNavigation(() {
                            widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          }),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
