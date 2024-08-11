import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fotisia/core/app_export.dart';
import '../models/ChatSession.dart';
import 'audio_note.dart';
import 'chat_provider.dart';

class MultiChatWidget extends StatefulWidget{
  MultiChatWidget({
        super.key,
    required this.audioNotes,
    required this.saveAudio,
  });
  List<AudioNote> audioNotes;
  Function saveAudio;

  @override
  _MultiChatWidget createState() => _MultiChatWidget();
}

class _MultiChatWidget extends State<MultiChatWidget> {
   late Map<String, dynamic> userData = {};
   final ScrollController _controller = ScrollController();
   bool _showArrowButton = false;
   late List<Map<String, dynamic>> allMessages = [];

  @override
  void initState() {
    super.initState();

    for(ChatSession session in context.read<ChatProvider>().chatMessages){
      allMessages = allMessages + session.chatHistory;
    }

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isBottom = _controller.position.pixels == 0;
        if (isBottom) {
          print('At the bottom');
          setState(() {
            _showArrowButton = false;
          });
        } else if(_showArrowButton == false) {
          print('At the top');
          setState(() {
            _showArrowButton = true;
          });
        }
      } else if(_showArrowButton == false) {
        setState(() {
          _showArrowButton = true;
        });
      }
    });

    getUser();
  }

  Future<void> getUser()async{
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    setState(() {
      userData = json.decode(jsonString.toString());
    });
  }

   // This is what you're looking for!
   void _scrollToBottom() {
     if (_controller.hasClients) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         // Check if the current position is already at the bottom
         if (_controller.position.pixels != 0) {
           _controller.animateTo(
             0,
             curve: Curves.ease,
             duration: const Duration(milliseconds: 300),
           );
         }
       });
     }
   }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      floatingActionButton: _showArrowButton ? Semantics(
        label: "Button: scroll to the bottom of your chat with Sia",
        child: FloatingActionButton(
          onPressed: () { _scrollToBottom(); },
          child: Icon(Icons.arrow_downward, color: Colors.white, semanticLabel: "Button, scroll to the bottom of your chat with Sia",),
        ),
      ) : Container(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            context.read<ChatProvider>().chatMessages.isNotEmpty ?  Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 24, top: 0, right: 24, bottom: 28),
                  child: SizedBox(
                    height: mediaQueryData.size.height * 0.62,
                    child: allMessages.reversed.isNotEmpty ? allMessages.reversed.isNotEmpty ? ListView.builder(
                      controller: _controller,
                      reverse: true,
                      itemCount: allMessages.reversed.length,
                      itemBuilder: (context, index) {
                        final message = allMessages.reversed.toList()[index];
                        return message['role'] == 'model' ?
                        Column(
                          children: [
                            SizedBox(height: mediaQueryData.size.height * 0.03,),
                            Padding(
                                padding: getPadding(right: 80),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          height: getSize(32),
                                          width: getSize(32),
                                          child: Stack(
                                              // alignment: Alignment.bottomRight,
                                              children: [
                                                CustomImageView(
                                                    imagePath:
                                                    ImageConstant.imgAvatar32x32,
                                                    height: getSize(32),
                                                    width: getSize(32),
                                                    radius: BorderRadius.circular(getHorizontalSize(16)),
                                                    alignment: Alignment.center
                                                ),
                                                Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                        height: getSize(8),
                                                        width: getSize(8),
                                                        decoration: BoxDecoration(
                                                            color: appTheme.tealA700,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                getHorizontalSize(
                                                                    4)),
                                                            border: Border.all(
                                                                color: theme
                                                                    .colorScheme
                                                                    .onPrimaryContainer
                                                                    .withOpacity(1),
                                                                width:
                                                                getHorizontalSize(1)
                                                            )
                                                        )
                                                    )
                                                )
                                              ])
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: getMargin(left: 12),
                                              padding: getPadding(
                                                  left: 12,
                                                  top: 10,
                                                  right: 12,
                                                  bottom: 10),
                                              decoration: AppDecoration.fillGray.copyWith(
                                                  borderRadius: BorderRadiusStyle
                                                      .customBorderTL241),
                                              child: Container(
                                                  width: getHorizontalSize(164),
                                                  margin: getMargin(top: 4, right: 14),
                                                  child: Text(message['parts'][0]['text']!,
                                                      // maxLines: 2,
                                                      // overflow: TextOverflow.ellipsis,
                                                      style: CustomTextStyles
                                                          .titleSmallGray600
                                                          .copyWith(height: 1.57)))),
                                          // Padding(
                                          //   padding: getPadding(top: 6, left: 12),
                                          //   child: Text("lbl_15_42_pm".tr, style: CustomTextStyles.labelMediumBluegray300),
                                          // ),
                                        ],
                                      )
                                    ])
                            ),
                          ],
                        ) : Column(
                          children: [
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: getPadding(left: 97, top: 26),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                              child: Container(
                                                  alignment: AlignmentDirectional.center,
                                                  margin: getMargin(left: 12),
                                                  padding: getPadding(
                                                      left: 12,
                                                      top: 10,
                                                      right: 12,
                                                      bottom: 10),
                                                  decoration: AppDecoration.fillPrimary.copyWith(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(
                                                          getHorizontalSize(24.00),
                                                        ),
                                                        topRight: Radius.circular(
                                                          getHorizontalSize(24.00),
                                                        ),
                                                        bottomLeft: Radius.circular(
                                                          getHorizontalSize(24.00),
                                                        ),
                                                      )
                                                  ),
                                                  child: Container(
                                                      width: getHorizontalSize(164),
                                                      margin: getMargin(top: 4, right: 14),
                                                      child: Text(message['parts'][0]['text']!,
                                                          style: CustomTextStyles.titleSmallGray5001_1)
                                                  )
                                              )
                                          ),
                                          CustomImageView(
                                              url: userData["picturePath"] != null && userData["picturePath"] != "null" && userData["picturePath"].toString().isNotEmpty ? userData["picturePath"] : "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
                                              height: getSize(32),
                                              width: getSize(32),
                                              alignment: Alignment.center,
                                              radius: BorderRadius.circular(getHorizontalSize(16)),
                                              margin: getMargin(left: 12, top: 7)
                                          )
                                        ])
                                )
                            ),
                            // SizedBox(height: mediaQueryData.size.height * 0.03,)
                            // Align(
                            //     alignment: Alignment.centerRight,
                            //     child: Padding(
                            //         padding: getPadding(top: 6, right: 44),
                            //         child: Text("lbl_15_42_pm".tr,
                            //             style: CustomTextStyles
                            //                 .labelMediumBluegray300))),
                          ],
                        );
                      },
                    ) : SizedBox(
                            height: mediaQueryData.size.height * 0.2,
                            child:  const Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("This session has no conversation", style: TextStyle(fontWeight: FontWeight.bold)),
                                  // Text("Your personal career coach and assistant."),
                                ],
                              ),
                            ),
                          ) : const Center(child: Text("No conversation in this session")),

                  )
            ) : SizedBox(
              height: mediaQueryData.size.height * 0.65,
              child:   Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    if(widget.audioNotes.isEmpty)
                      const Text("Your conversation history is empty", style: TextStyle(fontWeight: FontWeight.bold)),
                    // Text("Your personal career coach and assistant."),

                  ],
                ),
              ),
            ),

            if(widget.audioNotes.isNotEmpty)
              SizedBox(
              height: mediaQueryData.size.height * 0.15,
              child: Column(
                children: [
                  const Center(
                    child: Text("Voice message from Sia", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  AudioNoteWidget(audioNote: widget.audioNotes.last, saveAudio: widget.saveAudio,),
                ],
              ),
              // ListView.builder(
              //   itemCount: widget.audioNotes.length,
              //   itemBuilder: (context, index) {
              //     return AudioNoteWidget(audioNote: widget.audioNotes[index], saveAudio: widget.saveAudio,);
              //   },
              // ),
            ),
          ],
        ),
      )
    );

  }
}