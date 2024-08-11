import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/presentation/resume_maker_screen/widgets/resume_edit_stt.dart';
import 'package:path/path.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'delete_bin.dart';
import 'expandable_menu.dart';
import 'package:provider/provider.dart';


/// The message box widget which will be used by the user to send/record
/// message
class SiaResumeSection extends StatefulWidget {
  SiaResumeSection({super.key, required this.jobTitle, required this.jobCompany, required this.resumeEditInstructionsInputController, required this.sendInstruction});

  String jobTitle;
  String jobCompany;
  TextEditingController resumeEditInstructionsInputController;
  Function sendInstruction;

  @override
  State<SiaResumeSection> createState() => _SiaResumeSectionState();
}

class _SiaResumeSectionState extends State<SiaResumeSection> {
  double _scale = 1.0;
  double childOffset = 0;
  bool _isRecording = false;
  bool voiceMessageDeleted = false;
  bool userIsTyping = true;
  ExpandableMenuController expandableMenuController  = ExpandableMenuController();
  Offset deletePosition = Offset(50, 714);
  final DeleteAnimationController _controller = DeleteAnimationController();
  String entireResponse = "";


  @override
  void dispose() {
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTextField();
    openSiaMessageBox();
  }

  void openSiaMessageBox()async{
    await Future.delayed(const Duration(milliseconds: 1500));
    expandableMenuController.open();
  }

  Future<void> initTextField() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      userIsTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final speechProvider = Provider.of<SpeechToTextProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpandableMenu(
        controller: expandableMenuController,
        backgroundColor: Colors.black.withOpacity(0.1),
        iconColor: Colors.black.withOpacity(0.6),
        width: 25.0,
        height: 46.0,
        onClick: () async {
          if(userIsTyping){
            //   Add a delay
            await Future.delayed(const Duration(milliseconds: 800));
          }
          setState(() {
            userIsTyping = !userIsTyping;
          });
        },
        items: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                // height: MediaQuery.of(context).size.height * 0.1,
                child: CustomTextFormField(
                    controller: widget.resumeEditInstructionsInputController,
                    hintText: "instruct Sia...".tr,
                    hintStyle: CustomTextStyles.labelLargeGray600,
                    textInputAction: TextInputAction.done,
                    contentPadding: getPadding(
                        left: 10, top: 15, right: 30, bottom: 15),
                    borderDecoration: TextFormFieldStyleHelper.fillGray,
                    fillColor: appTheme.gray20001
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(widget.resumeEditInstructionsInputController.text.isNotEmpty){
                    widget.sendInstruction(widget.resumeEditInstructionsInputController.text);
                  }
                },//
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: const BorderRadius.all(Radius.circular(25))),
                  child: Icon(Icons.send, color: Colors.black.withOpacity(0.7), size: 15,),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  String formatDuration(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;
    final int secs = seconds % 60;

    final String hoursStr = hours.toString().padLeft(2, '0');
    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = secs.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

}