import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/routing/routes.dart';
import '../widgets/animated_triangles.dart' show AnimatedGameShapes;
import '../widgets/dot_indicator_nav.dart' show DotIndicatorNav;
import '../widgets/onboarding_page_one.dart' show OnboardingPageOne;
import '../widgets/onboarding_page_two.dart' show OnboardingPageTwo;

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkAgreement();
  }

  Future<void> _checkAgreement() async {
    final prefs = await SharedPreferences.getInstance();
    final agreed = prefs.getBool('agreed_to_terms') ?? false;
    if (agreed) {
      _navigateToHome();
    } else {
      setState(() => _loading = false);
    }
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.mainPage,
      (final route) => false,
    );
  }

  @override
  Widget build(final BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedGameShapes(),
          PageView(
            controller: _pageController,
            children: const [
              OnboardingPageOne(),
              OnboardingPageTwo(
                firstIcon: Icons.qr_code_rounded,
                secondIcon: Icons.image_search_rounded,
                firstTitle: 'فحص الباركود',
                secondTitle: 'تحليل الصور',
                subtitle:
                    'اكشف عن المنتجات باستخدام الكاميرا أو حلل الصور بتقنية تعلّم الآلة.',
              ),
              OnboardingPageTwo(
                firstIcon: Icons.search_rounded,
                secondIcon: Icons.new_releases_outlined,
                firstTitle: 'ابحث عن المنتج',
                secondTitle: 'اعثر على البدائل',
                subtitle:
                    'ابحث عن المنتجات واحصل علي البدائل لمنتجات المقاطعة بكل سهولة.',
              ),
              OnboardingPageTwo(
                height: 75.5,
                appOnlineRun: true,
                firstIcon: Icons.cloud_done_outlined,
                secondIcon: Icons.cloud_off_rounded,
                firstTitle: 'مع اتصال بالإنترنت',
                secondTitle: 'دون اتصال بالإنترنت',
                subtitle:
                    ' اضغط على الزر الموجود في الاسفل لتفعيل التطبيق يعمل بكفاءة سواء كنت متصلاً بالإنترنت أو لا.',
              ),
            ],
          ),
          DotIndicatorNav(pageController: _pageController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
