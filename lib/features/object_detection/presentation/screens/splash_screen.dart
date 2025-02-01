import 'package:an_core_ui/an_core_ui.dart';
import 'package:flutter/material.dart';
import 'package:object_detection_test/core/index.dart';

class SplashScreen extends BaseStatefulWidget {
  const SplashScreen({super.key});

  @override
  BaseState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      2.seconds,
      // ignore: use_build_context_synchronously
      () => context.pushNamedReplacement(Routes.objectSelectionScreen),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: Hero(
            tag: 'appIcon',
            child: Assets.images.appIcon.image(height: .5.sh, width: .5.sw),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 18.h,
          width: 18.w,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        40.heightBox,
      ],
    );
  }
}
