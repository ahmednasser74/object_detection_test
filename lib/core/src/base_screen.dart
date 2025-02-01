import 'package:an_core_ui/an_core_ui.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> {
  BaseState({
    this.resizeToAvoidBottomInset = false,
    this.extendBodyBehindAppBar = false,
  });
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool resizeToAvoidBottomInset;
  bool extendBodyBehindAppBar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: getBackGroundColor(context),
      key: getScreenKey,
      appBar: getAppBar(context),
      drawer: buildDrawer(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: getFloatingActionButton(),
      bottomNavigationBar: getBottomNavigationBar(),
      body: _buildBody(context),
    );
  }

  Widget buildLoadingState() => Container(
        height: 0.75.sh,
        padding: const EdgeInsets.all(16),
        child: const Center(child: CircularProgressIndicator()),
      );

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: getBody(context),
    );
  }

  bool isDialogShowing = false;

  void hideDialog() {
    if (isDialogShowing == false) return;
    isDialogShowing = false;
    Navigator.of(context).pop();
  }

  Color getBackGroundColor(context) => Theme.of(context).scaffoldBackgroundColor;
  // Color getBackGroundColor(context) => AppColors.white;

  Widget getBody(BuildContext context);

  String? get backgroundImagePath => null;

  @override
  void didChangeDependencies() => super.didChangeDependencies();

  @override
  void didUpdateWidget(T oldWidget) => super.didUpdateWidget(oldWidget);

  void openDrawer() => _scaffoldKey.currentState?.openDrawer();

  Widget? buildDrawer() => null;

  Widget? getBottomNavigationBar() => null;

  PreferredSizeWidget? getAppBar(BuildContext context) {
    final appBarTheme = AppBarTheme.of(context);
    if (appBarTitle == null) return null;
    return AppBar(
      title: AppText(appBarTitle!, color: appBarTheme.titleTextStyle?.color),
    );
  }

  String? get appBarTitle => null;

  Widget? getFloatingActionButton() => null;

  GlobalKey<ScaffoldState> get getScreenKey => _scaffoldKey;

  void showSnackBar({
    required String title,
    String? message,
    String? actionLabel,
    VoidCallback? onTapAction,
    Color? backgroundColor,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          children: [
            AppText(title, color: textColor),
            if (message != null) AppText(message, color: textColor),
          ],
        ),
        action: SnackBarAction(
          label: actionLabel ?? '',
          onPressed: onTapAction ?? () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
        backgroundColor: backgroundColor ?? context.primaryColor,
        duration: duration,
      ),
    );
  }

  void hideSnack() => ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
