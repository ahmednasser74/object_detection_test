import 'dart:io';

import 'package:an_core_ui/an_core_ui.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final ({String imagePath, String objectName}) arg;

  const ResultScreen({super.key, required this.arg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText("Result")),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait ? _buildPortraitLayout(context) : _buildLandscapeLayout(context);
        },
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      children: [
        _objectNameTextWidget(),
        8.heightBox,
        _dateTextWidget(),
        8.heightBox,
        Expanded(
          child: Stack(
            children: [
              _imageWidget(),
              _doneButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _imageWidget()),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _objectNameTextWidget(),
              8.heightBox,
              _dateTextWidget(),
              8.heightBox,
              _doneButton(context),
            ],
          ),
        ),
      ],
    );
  }

  AppText _objectNameTextWidget() {
    return AppText(
      "Object: ${arg.objectName.toCamelCase}",
    );
  }

  AppText _dateTextWidget() {
    return AppText(
      "Date: ${DateFormat('yyyy-MM-dd – kk:mm aa').format(DateTime.now())}",
    );
  }

  Positioned _doneButton(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: AppButton(
        marginHorizontal: 40.sp,
        onTap: context.pop,
        text: "Done",
      ),
    );
  }

  Image _imageWidget() {
    return Image.file(
      File(arg.imagePath),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
