import 'dart:ui';
import 'package:flutter/cupertino.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:taskproject/core/constant/app_path.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/constant/theme.dart';

import 'login_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with TickerProviderStateMixin {
  AnimationController? _signInAnimController;
  late RiveAnimationController _btnController;

  @override
  void initState() {
    super.initState();
    _signInAnimController = AnimationController(
      duration: const Duration(milliseconds: 350),
      upperBound: 1,
      vsync: this,
    );

    _btnController = OneShotAnimation("active", autoplay: false);

    const springDesc = SpringDescription(mass: 0.1, stiffness: 40, damping: 5);

    _btnController.isActiveChanged.addListener(() {
      if (!_btnController.isActive) {
        final springAnim = SpringSimulation(springDesc, 0, 1, 0);
        _signInAnimController?.animateWith(springAnim);
      }
    });
  }

  @override
  void dispose() {
    _signInAnimController?.dispose();
    _btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _blurredBackground(),
          _blurredShapes(),
          _onBoardingContent(),
          _signInModal(),
        ],
      ),
    );
  }

  Widget _blurredBackground() => ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
    child: Center(
      child: OverflowBox(
        maxWidth: double.infinity,
        child: Transform.translate(
          offset: const Offset(200, 100),
          child: Image.asset(AppPath.spline, fit: BoxFit.cover),
        ),
      ),
    ),
  );

  Widget _blurredShapes() => ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
    child: Container(
      color: Colors.white,
      child: const RiveAnimation.asset(AppPath.shapesRiv),
    ),
  );


  Widget _onBoardingContent() => AnimatedBuilder(
    animation: _signInAnimController!,
    builder: (context, child) => Transform.translate(
      offset: Offset(0, -50 * _signInAnimController!.value),
      child: child,
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 260,
                      child: Text(
                        "ONBOARDING - VIEW",
                        style: TextStyle(fontFamily: "Poppins", fontSize: 60),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Welcome on boarding view -- Welcome on boarding view -- Welcome on boarding view",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontFamily: "Inter",
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _startCourseButton(),
            const SizedBox(height: 16),
            Text(
              "Welcome on boarding view -- Welcome on boarding view -- Welcome on boarding view",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontFamily: "Inter",
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _startCourseButton() => GestureDetector(
    onTap: () => _btnController.isActive = true,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: 236,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Stack(
          children: [
            RiveAnimation.asset(AppPath.buttonRiv, fit: BoxFit.cover, controllers: [_btnController]),
             Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_forward_rounded),
                  const SizedBox(width: AppSize.paddingMenu),
                  Text(
                    "Login",
                    style: AppTextStyle.textBodyTile()
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );

  Widget _signInModal() => AnimatedBuilder(
    animation: _signInAnimController!,
    builder: (context, child) => Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true,
            child: Opacity(
              opacity: 0.4 * _signInAnimController!.value,
              child: Container(color: RiveAppTheme.shadow),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -MediaQuery.of(context).size.height * (1 - _signInAnimController!.value)),
          child: child,
        ),
      ],
    ),
    child: SignInView(closeModal: () => _signInAnimController?.reverse()),
  );
}