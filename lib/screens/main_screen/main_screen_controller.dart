import 'dart:convert';

import 'package:get/get.dart';
import 'package:visualize_the_json_web/model/model_data.dart';

class MainScreenController extends GetxController {
  ModelData? modelData;
  Map<String, TrackedHours> uiData = {};
  String copiedString = "";



  onInputJson(String input) {
    dynamic json = null;
    try {
      json = jsonDecode(input);
    } catch (e) {}
    if (json != null) {
      modelData = ModelData.fromJson(json);
      uiData = mergeData(modelData?.data?.trackedHours ?? []);
      copiedString = getCopiedString(uiData);
      update();
      print(modelData?.success);
    }
  }

  Map<String, TrackedHours> mergeData(List<TrackedHours> input) {
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
    return result;
  }

  String getCopiedString(Map<String, TrackedHours> input) {
    String result = "";
    input.forEach((key, value) {
      if (result.isEmpty) {
        result = "${value.trackedSecs}";
      } else {
        result = "$result\n${value.trackedSecs}";
      }
    });
    return result;
  }
}
