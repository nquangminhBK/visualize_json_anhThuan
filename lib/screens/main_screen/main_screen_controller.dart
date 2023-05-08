import 'dart:convert';

import 'package:get/get.dart';
import 'package:visualize_the_json_web/model/model_data.dart';
import 'package:visualize_the_json_web/shared_preferences.dart';

class MainScreenController extends GetxController {
  String inputJson = "";
  ModelData? modelData;
  List<TrackedHours> uiData = [];
  String copiedString = "";
  List<String> emailOrder = [];

  @override
  void onInit() {
    emailOrder = List<String>.from(
        jsonDecode(Get.find<SharedPreferences>().getString("emailOrder") ?? "[]"));
    super.onInit();
  }

  saveEmailOrder(String input) {
    List<String> emails = input.trim().split("\n").map((e) => e.trim().toLowerCase()).toList();
    Get.find<SharedPreferences>().setString("emailOrder", jsonEncode(emails));
    print("minh check $emailOrder");
    emailOrder = emails;
    _convertDataAndSortByEmailOrder();
    update();
  }

  onInputJson(String input) {
    inputJson = input;
    _convertDataAndSortByEmailOrder();
  }

  void _convertDataAndSortByEmailOrder() {
    dynamic json;
    try {
      json = jsonDecode(inputJson);
    } catch (e) {}
    if (json != null) {
      modelData = ModelData.fromJson(json);
      uiData = [...mergeData(modelData?.data?.trackedHours ?? [])];
      uiData.sort((a, b) {
        int indexA = emailOrder.indexOf(a.developerEmail ?? "");
        int indexB = emailOrder.indexOf(b.developerEmail ?? "");
        if (indexA >= 0 && indexB >= 0) {
          return indexA.compareTo(indexB);
        } else if (indexA >= 0) {
          return -1;
        } else if (indexB >= 0) {
          return 1;
        } else {
          return (a.developerEmail ?? "").compareTo(b.developerEmail ?? "");
        }
      });
      copiedString = getCopiedString(uiData);
    }
    update();
  }

  List<TrackedHours> mergeData(List<TrackedHours> input) {
    Map<String, TrackedHours> result = {};
    for (var trackedHour in input) {
      String expertName = trackedHour.developerName ?? "";
      TrackedHours? currentTrackerHours = result[expertName];
      if (currentTrackerHours == null) {
        result[expertName] = trackedHour;
      } else {
        String currentProjectName = currentTrackerHours.projectName ?? "";
        currentProjectName = "$currentProjectName,  ${trackedHour.projectName}";
        int currentTrackedSec = currentTrackerHours.trackedSecs?.toInt() ?? 0;
        currentTrackedSec += (trackedHour.trackedSecs ?? 0).toInt();
        TrackedHours newTrackerHours = currentTrackerHours.copyWith(
            trackedSecs: currentTrackedSec, projectName: currentProjectName);
        result[expertName] = newTrackerHours;
      }
    }
    return result.values.toList();
  }

  String getCopiedString(List<TrackedHours> input) {
    String result = "";
    for (var value in input) {
      if (result.isEmpty) {
        result = "${value.trackedSecs}";
      } else {
        result = "$result\n${value.trackedSecs}";
      }
    }
    return result;
  }
}
