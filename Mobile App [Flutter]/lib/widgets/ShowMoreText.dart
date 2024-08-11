import 'package:flutter/material.dart';
import 'package:fotisia/widgets/DetectTextOverflow.dart';


class ShowMoreText extends StatefulWidget {
  // const ShowMoreText({super.key});

    final String text;
  final TextStyle? style;

  ShowMoreText({
    required this.text,
    this.style,
  });

  @override
  ShowMoreTextState createState() => ShowMoreTextState();
}

class ShowMoreTextState extends State<ShowMoreText> {
  bool isShowingMore = false;

  @override
  Widget build(BuildContext context) {
    final messageContent = Text(
      widget.text,
      maxLines: isShowingMore ? null : 3,
      overflow: isShowingMore ? null : TextOverflow.ellipsis,
      style: widget.style,
    );

    return DetectTextOverflowBuilder(
      textWidget: messageContent,
      builder: (context, willOverflow) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            messageContent,
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // if (willOverflow)
                willOverflow ? TextButton(
                    onPressed: () => setState(() {
                      isShowingMore = !isShowingMore;
                    }),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 48),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                      surfaceTintColor:Colors.white,
                    ),
                    child: Text(
                      isShowingMore ? 'Show Less' : 'Show More',
                      style: const TextStyle(
                        color: Colors.lightBlue
                      ),
                    ),
                  ) : Container(),
              ],
            ),
          ],
        );
      },
    );
  }
}
// class ShowMoreText extends StatefulWidget {
//   final String text;
//   final TextStyle? style;
//
//   ShowMoreText({
//     required this.text,
//     this.style,
//   });
//
//   @override
//   _ShowMoreTextState createState() => _ShowMoreTextState();
// }
//
// class _ShowMoreTextState extends State<ShowMoreText> {
//   bool showMore = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.text,
//           maxLines: showMore ? null : 3,
//           overflow: showMore ? null : TextOverflow.ellipsis,
//           style: widget.style,
//         ),
//         // if (widget.text.split('\n').length > 3)
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 showMore = !showMore;
//               });
//             },
//             style: ButtonStyle(
//               overlayColor: MaterialStateProperty.all<Color>(Colors.white),
//               padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
//             ),
//             child: Text(
//                 showMore ? 'Show Less' : 'Show More',
//               style: TextStyle(
//                 color: Colors.lightBlue
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }