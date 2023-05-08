import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:visualize_the_json_web/screens/main_screen/dialog_setup_emails_order.dart';
import 'package:visualize_the_json_web/screens/main_screen/main_screen_controller.dart';

import '../../animated_clickable_widget.dart';
import '../../model/model_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<MainScreenController>(
            builder: (controller) {
              return Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: Get.height,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: InputJsonText(
                            onTextChange: (text) {
                              controller.onInputJson(text);
                            },
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          padding: const EdgeInsets.all(10),
                          width: Get.width,
                          height: 80,
                          child: Row(
                            children: [
                              AnimatedClickableWidget(
                                onPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogSetupEmailsOrder(
                                            currentOrder: controller.emailOrder,
                                            onSubmit: (text) {
                                              controller.saveEmailOrder(text);
                                              Get.back();
                                              Get.showSnackbar(const GetSnackBar(
                                                message: 'Setup successfully',
                                                duration: Duration(seconds: 2),
                                              ));
                                            });
                                      });
                                },
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.deepPurple.withOpacity(0.3)),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: const [Icon(Icons.settings), Text('Setup the order')],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(width: 1, color: Colors.grey),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  autofocus: true,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (text) {
                                    controller.saveFormatterString(text);
                                  },
                                  style: const TextStyle(color: Colors.black),
                                  textAlign: TextAlign.left,
                                  cursorColor: Colors.grey,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: "format time before copy",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              AnimatedClickableWidget(
                                onPress: () {
                                  if (controller.copiedString.isEmpty) {
                                    Get.showSnackbar(const GetSnackBar(
                                      message: 'Input the Json first',
                                      duration: Duration(seconds: 2),
                                    ));
                                    return;
                                  }
                                  Clipboard.setData(ClipboardData(text: controller.copiedString))
                                      .then(
                                    (_) {
                                      Get.showSnackbar(const GetSnackBar(
                                        message: 'Copied',
                                        duration: Duration(seconds: 2),
                                      ));
                                    },
                                  );
                                },
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green.withOpacity(0.3)),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.copy_rounded),
                                      Text('Copy the tracked time by saved order')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: controller.uiData.isNotEmpty
                                ? VisualizeContainer(
                                    trackerHours: controller.uiData,
                                  )
                                : Container())
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}

class InputJsonText extends StatelessWidget {
  const InputJsonText({required this.onTextChange, Key? key}) : super(key: key);
  final Function onTextChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: double.infinity,
      child: TextField(
        autofocus: true,
        maxLines: null,
        textInputAction: TextInputAction.done,
        onChanged: (text) {
          onTextChange(text);
        },
        style: const TextStyle(color: Colors.black, height: 2),
        textAlign: TextAlign.left,
        cursorColor: Colors.grey,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

class VisualizeContainer extends StatelessWidget {
  const VisualizeContainer({required this.trackerHours, Key? key}) : super(key: key);

  final List<TrackedHours> trackerHours;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          TrackedHours trackedHour = trackerHours[index];
          Duration duration = Duration(seconds: trackedHour.trackedSecs?.toInt() ?? 0);
          String formattedTime = duration.toString().split('.').first;
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue.withOpacity(0.2)),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        trackedHour.developerName ?? "",
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        trackedHour.developerEmail ?? "",
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Project Name:",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      trackedHour.projectName ?? "",
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                )),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "tracked time",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${trackedHour.trackedSecs}s - $formattedTime" ,
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          );
        },
        itemCount: trackerHours.length,
      ),
    );
  }
}
