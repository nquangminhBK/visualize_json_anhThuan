import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visualize_the_json_web/animated_clickable_widget.dart';

class DialogSetupEmailsOrder extends StatefulWidget {
  const DialogSetupEmailsOrder({required this.currentOrder, required this.onSubmit, Key? key})
      : super(key: key);
  final List<String> currentOrder;
  final Function onSubmit;

  @override
  State<DialogSetupEmailsOrder> createState() => _DialogSetupEmailsOrderState();
}

class _DialogSetupEmailsOrderState extends State<DialogSetupEmailsOrder> {
  TextEditingController textEditingController = TextEditingController();
  String text = "";
  @override
  void initState() {
    String initString = "";
    widget.currentOrder.forEach((element) {
      if (initString.isEmpty) {
        initString = element;
      } else {
        initString = "$initString\n$element";
      }
    });
    textEditingController.text = initString;
    text = initString;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          width: Get.width > 500 ? 500 : double.infinity,
          height: Get.height * 0.67,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
          padding: const EdgeInsets.all(20),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    controller: textEditingController,
                    onChanged: (text) {
                      this.text = text;
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
                ),
                AnimatedClickableWidget(
                    color: Colors.transparent,
                    onPress: () {
                      widget.onSubmit(text);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.withOpacity(0.3),
                      ),
                      padding: const EdgeInsets.only(top: 14, bottom: 14),
                      child: const Center(child: Text("Save the order")),
                    ))
              ],
            ),
          )),
    );
  }
}
