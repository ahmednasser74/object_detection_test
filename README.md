<p align="center">
<a href="https://postimg.cc/Kk4V8NVg"><img src="https://i.postimg.cc/Kk4V8NVg/app-icon-removebg-preview.jpg" style="height:200px;"/></a>
<p>

# 🏆 Technical Assessment - Flutter Developer  

## 📌 Objective  
This assessment evaluates the candidate's ability to create a Flutter application integrating:  
- 🎯 **Object Detection** (using the device camera)  
- 📢 **Real-time User Guidance** (providing feedback based on object position)  
- 📸 **Auto-Capture** (automatically capturing an image when the object is in focus)  
- 📱 **Responsive UI** (supporting both portrait and landscape orientations)  

---

## 🎥 Video Preview

Check out this [Video Preview](https://drive.google.com/file/d/1sc6XC8g3SmZEbpVrr9S4tBrek0Q1Uyzr/view?usp=sharing) of the mobile app implementation.


## 🚀 Running the Application  
Follow the standard steps to run a Flutter application:  

```sh
# Clone the repository
git clone https://github.com/ahmednasser74/object_detection_test.git
cd object_detection_test

# Install dependencies
flutter pub get

# Run the app
flutter run
```
## 🛠️ Faced Challenges

During the development of this application, several challenges were encountered:

1. **Finding AI Model Fit Requirement**:
    - Identifying an AI model that met the requirements for accurate and efficient object detection was challenging. Extensive research and testing were necessary to find a model that balanced performance and accuracy for real-time use.

2. **Real-time Object Detection Performance**:
    - Ensuring smooth and accurate object detection while maintaining real-time performance was challenging. Optimizing the TensorFlow Lite model and managing camera frame processing efficiently were crucial.

## 📦 Dependencies

| Dependency | Version | Purpose |
|------------|---------|---------|
| [`camera`](https://pub.dev/packages/camera) | `^0.11.0` | Access the device camera for real-time object detection. |
| [`tflite_v2`](https://pub.dev/packages/tflite_v2) | `^1.0.0` | Enables TensorFlow Lite model inference for object detection. |
| [`an_core_ui`](https://github.com/ahmednasser74/an_core_ui) | `Custom` | A **custom package** (developed by me) for shared UI components. Explore it [here](https://github.com/ahmednasser74/an_core_ui). |
| [`get_it`](https://pub.dev/packages/get_it) | `^8.0.2` | Dependency injection for managing app services. |
| [`injectable`](https://pub.dev/packages/injectable) | `^2.1.0` | Generates dependency injection code. |
| [`json_annotation`](https://pub.dev/packages/json_annotation) | `^4.8.1` | Helps define JSON serialization models. |
| [`json_serializable`](https://pub.dev/packages/json_serializable) | `^6.7.1` | Auto-generates JSON serialization logic. |
| [`provider`](https://pub.dev/packages/provider) | `^6.1.2` | **State management** (required for this assessment). |
