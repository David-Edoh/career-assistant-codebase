import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fotisia/presentation/search_screen/bloc/search_bloc.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fotisia/widgets/photo_grid.dart';
// import 'package:share_plus/share_plus.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../widgets/floating-hearts/widgets/floating-hearts.dart';
import '../../../widgets/floating-hearts/widgets/heart-button.dart';
import '../../home_container_screen/bloc/home_container_bloc.dart';
import '../models/get_feeds_resp.dart';
import '../models/listlogo_one_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_icon_button.dart';
import 'package:path/path.dart' as p;
import 'package:appinio_video_player/appinio_video_player.dart';


// ignore: must_be_immutable
class ListlogoOneItemWidget extends StatefulWidget {
  ListlogoOneItemWidget(
    this.listlogoOneItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  ListlogoOneItemModel listlogoOneItemModelObj;

  @override
  State<ListlogoOneItemWidget> createState() => _ListlogoOneItemWidgetState();
}

class _ListlogoOneItemWidgetState extends State<ListlogoOneItemWidget> {
  final CarouselController _carouselController = CarouselController();
  int _currentCarouselPage = 0;
  late List<VideoPlayerController> vidCTRLs = <VideoPlayerController>[];
  bool liked = false;
  bool immediateIncrement = false;
  final _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    liked = false;

    if(widget.listlogoOneItemModelObj.images != null){
      for(int i = 0; i < widget.listlogoOneItemModelObj.images!.length; i++){
        // widget.listlogoOneItemModelObj.images![0].
        if(UrlTypeHelper.getType(widget.listlogoOneItemModelObj.images![i].toString()) == UrlType.VIDEO){
          vidCTRLs.add(
              VideoPlayerController.networkUrl(Uri.parse(widget.listlogoOneItemModelObj.images![i]), videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
                ..initialize().then((_) {
                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                  setState(() {});
                })
          );
        }
      }
    }

  }

  @override
  void dispose() {
    vidCTRLs?.forEach((controller) => controller?.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeContainerBloc, HomeContainerState>(
        builder: (context, state) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: CustomIconButton(
                    height: getSize(50),
                    width: getSize(50),
                    margin: getMargin(
                      bottom: 62,
                    ),
                    padding: getPadding(
                      all: 4,
                    ),
                    decoration: IconButtonStyleHelper.fillGrayTL16,
                    child: CustomImageView(
                      url: widget.listlogoOneItemModelObj.profilePicture,
                      radius: BorderRadius.circular(getHorizontalSize(44)),
                    ),
                  ),
                ),
                Container(
                  // height: getVerticalSize(90),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.65,
                  margin: getMargin(
                    left: 12,
                    top: 4,
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.listlogoOneItemModelObj.firstName} ${widget.listlogoOneItemModelObj.lastName}",
                                            style: CustomTextStyles.titleSmallPrimaryBold,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              getTimeAgo(widget.listlogoOneItemModelObj.post!.updatedAt.toString()),
                                              style: CustomTextStyles.labelLargeBluegray300,
                                            ),
                                          ),
                                        ],
                                  ),

                                  widget.listlogoOneItemModelObj.post?.userId == state.thisUser?.id ? PopupMenuButton<int>(
                                    // color: Colors.white,
                                    offset: const Offset(10, 20),
                                    elevation: 2,
                                    itemBuilder: (context) => [
                                      // popupmenu item 1
                                      PopupMenuItem(
                                        onTap: (){
                                          context.read<SearchBloc>().add(DeletePostEvent(postId: widget.listlogoOneItemModelObj.post?.id));
                                        },
                                        value: 1,
                                        // row has two child icon and text.
                                        child: const Row(
                                          children: [
                                            Icon(Icons.delete),
                                            SizedBox(
                                              // sized box with width 10
                                              width: 10,
                                            ),
                                            Text("Delete", style: TextStyle(color: Colors.black),)
                                          ],
                                        ),
                                      ),

                                    ],
                                  ) : Container()
                                ],
                              ),
                            widget.listlogoOneItemModelObj.commentText != null ? Padding(
                              padding: getPadding(
                                top: 7,
                              ),
                              child: Text(
                                widget.listlogoOneItemModelObj.commentText ?? "",
                                style: TextStyle(color: Colors.black),
                                // style: theme.textTheme.labelLarge,
                              ),
                            ) : Container(),

                            (widget.listlogoOneItemModelObj.images != null && widget.listlogoOneItemModelObj.images!.isNotEmpty) ? SizedBox(
                              // height: 350,
                              child: Padding(
                                padding: getPadding(
                                  top: 7,
                                ),
                                child:
                                Stack(
                                  children: [
                                    CarouselSlider(
                                      carouselController: _carouselController,
                                      options: CarouselOptions(
                                        height: 500.0,
                                        // width: MediaQuery.of(context).size.width * 0.8,
                                        initialPage: 0,
                                        viewportFraction: 1,
                                        enableInfiniteScroll: false,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.3,
                                        clipBehavior: Clip.hardEdge,
                                        onPageChanged: (index, reason) {
                                          // context.read<HomeContainerBloc>().add(SetActiveCarouselMedia(activePage: index));
                                          setState(() {
                                            _currentCarouselPage = index;
                                          });
                                        }
                                      ),
                                      items: (widget.listlogoOneItemModelObj.images ?? [])?.asMap().entries.map((entry) =>
                                          Center(
                                            // (UrlTypeHelper.getType(entry.value.toString()) == UrlType.IMAGE)
                                            child: (UrlTypeHelper.getType(entry.value.toString()) == UrlType.IMAGE) ? CustomImageView(
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              fit: BoxFit.fitWidth,
                                              url: entry.value.toString(),
                                              // height: 90.0,
                                            ) : (vidCTRLs != null && vidCTRLs.isNotEmpty && vidCTRLs.firstWhere((element) => element.dataSource == entry.value.toString()).value.isInitialized) ?  AspectRatio(
                                              aspectRatio: vidCTRLs.firstWhere((element) => element.dataSource == entry.value.toString()).value.aspectRatio,
                                              child:  CustomVideoPlayer(
                                                  customVideoPlayerController: CustomVideoPlayerController(
                                                    context: context,
                                                    videoPlayerController: vidCTRLs.firstWhere((element) => element.dataSource == entry.value.toString()),
                                                  )
                                              ),
                                            ) : Text(vidCTRLs!.length.toString()),

                                          )
                                      ).toList(),
                                    ),
                                    Positioned(
                                      // bottom: 0.0,
                                      // left: 0.0,
                                      right: 0.0,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(90, 0, 0, 0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: Text(
                                            '${(_currentCarouselPage ?? 0) + 1}/${widget.listlogoOneItemModelObj.images!.length}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 0.0,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: widget.listlogoOneItemModelObj.images!.asMap().entries.map((entry) {
                                              return GestureDetector(
                                                onTap: () => _carouselController.animateToPage(entry.key),
                                                child: Container(
                                                  width: 6.0,
                                                  height: 6.0,
                                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey
                                                          .withOpacity(_currentCarouselPage == entry.key ? 0.9 : 0.4)),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                              ),
                            ) : Container(),

                            // Row of icons for like, share, and comment
                            Padding(
                              padding: getPadding(top: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       (widget.listlogoOneItemModelObj!.reaction == null && !liked) ? SizedBox(
                                         width: 30,
                                         child: HeartButton(context2: context, postId: int.parse(widget.listlogoOneItemModelObj!.id.toString()),
                                             setActiveHeart: () {
                                                setState(() {liked = true; immediateIncrement=true;});
                                                },
                                             getUpdatedPost: () async {
                                               const storage = FlutterSecureStorage();
                                               String? jsonString = await storage.read(key: "userData");
                                               Map<String, dynamic> userData = json.decode(jsonString.toString());
                                               String path = "api/post/${widget.listlogoOneItemModelObj!.id}";

                                               await _apiClient.getData(
                                                 headers: {
                                                   'Content-Type': 'application/json',
                                                   'Authorization': "Bearer ${userData['accessToken']}"
                                                 },
                                                 path: path,
                                                 showLoading: false,
                                                 useCache: false,
                                               ).then((value) async {
                                                 Post post = Post.fromJson(value);

                                                 widget.listlogoOneItemModelObj!.reaction = post.reaction;
                                                 widget.listlogoOneItemModelObj!.reactions = List.from(widget.listlogoOneItemModelObj!.reactions ?? <Reaction>[])
                                                   ..add(post.reaction!);

                                                 setState(() {
                                                   immediateIncrement = false;
                                                 });

                                                 widget.listlogoOneItemModelObj!.post!.reaction = post.reaction;
                                                 widget.listlogoOneItemModelObj!.post!.reactions = List.from(widget.listlogoOneItemModelObj!.reactions ?? <Reaction>[])
                                                   ..add(post.reaction!);

                                                 //update posts list
                                                 int index = widget.listlogoOneItemModelObj!.posts!.indexWhere((post) => post.id == widget.listlogoOneItemModelObj!.post!.id);
                                                 widget.listlogoOneItemModelObj!.posts![index] = widget.listlogoOneItemModelObj!.post!;

                                                 context.read<SearchBloc>().add(UpdatePostEvent(posts: widget.listlogoOneItemModelObj!.posts!));

                                               });
                                             })
                                       ) :
                                       SizedBox(
                                         width: 30,
                                         child: RawMaterialButton(
                                           onPressed: () async {
                                             const storage = FlutterSecureStorage();
                                             String? jsonString = await storage.read(key: "userData");
                                             Map<String, dynamic> userData = json.decode(jsonString.toString());

                                             context.read<HomeContainerBloc>().add(DeletePostReactionEvent(reactionId: widget.listlogoOneItemModelObj!.reaction != null ? widget.listlogoOneItemModelObj!.reaction?.id : widget.listlogoOneItemModelObj.reaction?.id));

                                             widget.listlogoOneItemModelObj!.reaction = null;
                                             widget.listlogoOneItemModelObj!.reactions = List.from(widget.listlogoOneItemModelObj!.reactions ?? <Reaction>[])
                                               ..removeWhere((reaction) => reaction.userId == int.parse(userData["id"]));

                                             setState(() {
                                               liked = false;
                                             });

                                             widget.listlogoOneItemModelObj!.post!.reaction = null;
                                             widget.listlogoOneItemModelObj!.post!.reactions = List.from(widget.listlogoOneItemModelObj!.reactions ?? <Reaction>[])
                                               ..removeWhere((reaction) => reaction.userId == int.parse(userData["id"]));

                                             //update posts list
                                             int index = widget.listlogoOneItemModelObj!.posts!.indexWhere((post) => post.id == widget.listlogoOneItemModelObj!.post!.id);
                                             widget.listlogoOneItemModelObj!.posts![index] = widget.listlogoOneItemModelObj!.post!;

                                             context.read<SearchBloc>().add(UpdatePostEvent(posts: widget.listlogoOneItemModelObj!.posts!));

                                           },
                                           child: CustomImageView(
                                             svgPath: ImageConstant.heartFill, //Like button
                                             height: getSize(25),
                                             width: getSize(25),
                                             margin: getMargin(right: 3),
                                           ),
                                         ),
                                       ),
                                       Text((widget.listlogoOneItemModelObj!.reactions != null) ? (widget.listlogoOneItemModelObj!.reactions!.length + (immediateIncrement ? 1 : 0)).toString() : "${0 + (immediateIncrement ? 1 : 0)}")
                                     ],
                                   ),
                                   // TextButton(
                                   //   onPressed: () {
                                   //     context.read<HomeContainerBloc>().add(TogglePanelController(postId: int.parse(widget.listlogoOneItemModelObj.id ?? "-1")));
                                   //
                                   //   },
                                   //   child: Row(
                                   //     children: [
                                   //       CustomImageView(
                                   //         svgPath: ImageConstant.speechBubble, //Comment button
                                   //         height: getSize(20),
                                   //         width: getSize(20),
                                   //         color: Colors.black.withOpacity(0.6),
                                   //         margin: getMargin(right: 5),
                                   //       ),
                                   //       Center(
                                   //         child: Text(
                                   //           (widget.listlogoOneItemModelObj.comments != null) ? widget.listlogoOneItemModelObj.comments!.length.toString() : "0",
                                   //          style: TextStyle(
                                   //            color: Colors.black.withOpacity(0.6),
                                   //            fontSize: 14,
                                   //            // fontFamily: ,
                                   //          ),
                                   //         ),
                                   //       )
                                   //     ],
                                   //   ),
                                   // ),

                                   // TextButton(
                                   //   onPressed: (){
                                   //     Share.share('check out my website https://example.com', subject: 'Look what I made!');
                                   //   },
                                   //   child: CustomImageView(
                                   //     svgPath: ImageConstant.share, //Share button
                                   //     height: getSize(20),
                                   //     width: getSize(20),
                                   //     color: Colors.black.withOpacity(0.6),
                                   //     margin: getMargin(right: 20),
                                   //   ),
                                   // ),

                                 ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding (
                padding: getPadding(top: 15, bottom: 7.5),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                        height: getVerticalSize(1),
                        thickness: getVerticalSize(1),
                        color: appTheme.indigo50)
                )
            ),
          ],
        ),
        Positioned(
            right:  MediaQuery.of(context).size.width*0.1,
            bottom:  MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).size.height*0.1,
            child:  state.activePost == int.parse(widget.listlogoOneItemModelObj!.id.toString()) ? FloatingHeartsWidget(context2: context) : Container(),
        ),
      ],
    );
  });
  }
  String getTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'second' : 'seconds'} ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else  {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    }
    // else {
    //   return DateFormat.yMd().add_jms().format(dateTime);
    // }
  }
}

enum UrlType { IMAGE, VIDEO, UNKNOWN }

class UrlTypeHelper {
  static List<String> _image_types = [
    'jpg',
    'jpeg',
    'jfif',
    'pjpeg',
    'pjp',
    'png',
    'svg',
    'gif',
    'apng',
    'webp',
    'avif'
  ];

  static List<String> _video_types = [
    "3g2",
    "3gp",
    "aaf",
    "asf",
    "avchd",
    "avi",
    "drc",
    "flv",
    "m2v",
    "m3u8",
    "m4p",
    "m4v",
    "mkv",
    "mng",
    "mov",
    "mp2",
    "mp4",
    "mpe",
    "mpeg",
    "mpg",
    "mpv",
    "mxf",
    "nsv",
    "ogg",
    "ogv",
    "qt",
    "rm",
    "rmvb",
    "roq",
    "svi",
    "vob",
    "webm",
    "wmv",
    "yuv"
  ];

  static UrlType getType(url) {
    try {
      Uri uri = Uri.parse(url);
      String extension = p.extension(uri.path).toLowerCase();
      if (extension.isEmpty) {
        return UrlType.UNKNOWN;
      }

      extension = extension.split('.').last;
      if (_image_types.contains(extension)) {
        return UrlType.IMAGE;
      } else if (_video_types.contains(extension)) {
        return UrlType.VIDEO;
      }
    } catch (e) {
      return UrlType.UNKNOWN;
    }
    return UrlType.UNKNOWN;
  }
}
