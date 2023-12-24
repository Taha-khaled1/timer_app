import 'package:flutter/material.dart';
import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/components/custom_butten.dart';
import 'package:task_manger/presentation_layer/resources/color_manager.dart';
import 'package:task_manger/presentation_layer/resources/font_manager.dart';
import 'package:task_manger/presentation_layer/resources/styles_manager.dart';
import 'package:task_manger/presentation_layer/screen/auth/social_login/social_login.dart';
import 'package:task_manger/presentation_layer/src/get_packge.dart';
import 'package:task_manger/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<Widget> _pages = [
    OnboardingPage(
      description: "Easy task & work management with pomo",
      imageUrl: "assets/images/Frame-2.png",
    ),
    OnboardingPage(
      description: "Track your productivity & gain insights",
      imageUrl: "assets/images/Frame-1.png",
    ),
    OnboardingPage(
      description: "Boost your productivity now & be successful",
      imageUrl: "assets/images/Frame.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: _pages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _pages[index];
                  },
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                axisDirection: Axis.horizontal,
                effect: ExpandingDotsEffect(
                  spacing: 8.0,
                  radius: 15,
                  dotWidth: 14.0,
                  dotHeight: 12.0,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 1.2,
                  dotColor: Colors.grey,
                  activeDotColor: ColorManager.kPrimary,
                ),
              ),
              SizedBox(height: 16.0),
              CustomButton(
                width: deviceInfo.localWidth * 0.8,
                rectangel: 18,
                haigh: 60,
                color: ColorManager.kPrimaryButton,
                text:
                    _currentPage == _pages.length - 1 ? "Get Started" : "Next",
                press: () {
                  if (_currentPage == _pages.length - 1) {
                    sharedPreferences.setString("lev", '1');
                    print(sharedPreferences.getString("lev"));
                    Get.off(() => SocialScreen());
                  } else {
                    setState(() {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                      _currentPage++;
                    });
                  }
                },
              ),
              SizedBox(height: 45),
            ],
          );
        },
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String description;
  final String imageUrl;

  OnboardingPage({
    Key? key,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: 200.0,
            width: 200.0,
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: MangeStyles().getBoldStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: FontSize.s40,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
