import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:visualize_the_json_web/model/model_data.dart';
import 'package:visualize_the_json_web/shared_preferences.dart';

class MainScreenController extends GetxController {
  String inputJson = "";
  List<TrackedHours> uiData = [];
  String copiedString = "";
  List<String> emailOrder = [];
  String formatterString = "";

  @override
  void onInit() {
    emailOrder = List<String>.from(
        jsonDecode(Get.find<SharedPreferences>().getString("emailOrder") ?? "[]"));
    formatterString = Get.find<SharedPreferences>().getString("formatterString") ?? "";
    update();
    super.onInit();
  }

  saveEmailOrder(String input) {
    List<String> emails = input.trim().split("\n").map((e) => e.trim().toLowerCase()).toList();
    Get.find<SharedPreferences>().setString("emailOrder", jsonEncode(emails));
    emailOrder = emails;
    uiData = _convertDataAndSortByEmailOrder(inputJson, emailOrder);
    copiedString = _getCopiedString(uiData, formatterString);
    update();
  }

  saveFormatterString(String input) {
    formatterString = input;
    Get.find<SharedPreferences>().setString("formatterString", input);
    copiedString = _getCopiedString(uiData, formatterString);
    update();
  }

  onInputJson(String input) {
    inputJson = input;
    uiData = _convertDataAndSortByEmailOrder(inputJson, emailOrder);
    copiedString = _getCopiedString(uiData, formatterString);
    update();
  }

  List<TrackedHours> _convertDataAndSortByEmailOrder(String inputJson, List<String> emailOrder) {
    List<TrackedHours> uiData = [];
    dynamic json;
    try {
      json = jsonDecode(inputJson);
    } catch (e) {}
    if (json != null) {
      ModelData? modelData = ModelData.fromJson(json);
      uiData = [..._mergeData(modelData.data?.trackedHours ?? [])];
      for (String email in emailOrder) {
        if (uiData.firstWhereOrNull((element) => element.developerEmail == email) == null) {
          uiData.add(TrackedHours(id: _generateARandomId(uiData),
              projectName: "Un-allocate",
              developerEmail: email,
              developerName: email,
              trackedSecs: 0));
        }
      }
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
    }
    return uiData;
  }

  List<TrackedHours> _mergeData(List<TrackedHours> input) {
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

  String _getCopiedString(List<TrackedHours> input, String formatterString) {
    String result = "";
    for (var value in input) {
      if (result.isEmpty) {
        result = formatTheTimeWithFormatterString("${value.trackedSecs}", formatterString);
      } else {
        result =
        "$result\n${formatTheTimeWithFormatterString("${value.trackedSecs}", formatterString)}";
      }
    }
    return result;
  }

  String formatTheTimeWithFormatterString(String input, String formatterString) {
    return formatterString.replaceAll("@", input);
  }

  int _generateARandomId(List<TrackedHours> uiData) {
    int maxInt = (pow(2, 32) - 1).toInt();
    int result = 0;
    do {
      result = Random().nextInt(maxInt + 1);
    } while (uiData.firstWhereOrNull((element) => element.id == result) != null);
    return result;
  }
}
