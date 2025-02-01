import 'package:an_core_ui/an_core_ui.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/index.dart';
import '../provider/index.dart';

class ObjectSelectionScreen extends BaseStatefulWidget {
  const ObjectSelectionScreen({super.key});

  @override
  BaseState<ObjectSelectionScreen> createState() => _ObjectSelectionScreenState();
}

class _ObjectSelectionScreenState extends BaseState<ObjectSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final ObjectSelectionProvider objectsProvider;

  PreferredSizeWidget? getAppBar(BuildContext context) {
    return AppBar(
      actions: [Assets.images.appIcon.image(width: 20, height: 20), 8.widthBox],
      title: const AppText('Select Object to Detect'),
    );
  }

  @override
  void initState() {
    super.initState();
    objectsProvider = context.read<ObjectSelectionProvider>();
    objectsProvider.getLabelsList();
  }

  @override
  Widget? getFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () => _navigateToObjectDetection(),
      label: AppText('General Detection', size: 12.sp, color: AppColors.white),
      icon: const Icon(Icons.camera, color: AppColors.white),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return Consumer<ObjectSelectionProvider>(
      builder: (context, provider, child) {
        final filteredList = provider.objectList.where((object) => object.toLowerCase().contains(provider.searchText.toLowerCase())).toList();
        return Column(
          children: [
            _searchBar(),
            8.heightBox,
            Expanded(
              flex: 1,
              child: ListView.separated(
                itemCount: filteredList.length,
                separatorBuilder: (BuildContext context, int index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(),
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: AppText(filteredList[index].toCamelCase),
                    onTap: () => _navigateToObjectDetection(filteredList[index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToObjectDetection([String? objectName]) async {
    final cameras = await availableCameras();
    context.pushNamed(
      Routes.cameraDetectionScreen,
      arguments: (objectName: objectName, cameras: cameras),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppTextFieldWidget(
        controller: _searchController,
        onChanged: (v) {
          /// Debounce search
          Future.delayed(
            const Duration(milliseconds: 500),
            () => onSubmitSearch(_searchController.text),
          );
        },
        dispose: false,
        labelText: 'Object Search...',
        prefixIcon: const Icon(Icons.search, color: AppColors.greyColor),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => onSubmitSearch(value),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: AppColors.greyColor),
          onPressed: () {
            if (_searchController.text.isEmpty) {
              FocusScope.of(context).requestFocus(FocusNode());
              return;
            }
            _searchController.clear();
            onSubmitSearch('');
          },
        ),
      ),
    );
  }

  void onSubmitSearch(String value) {
    objectsProvider.updateSearchText(value);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
