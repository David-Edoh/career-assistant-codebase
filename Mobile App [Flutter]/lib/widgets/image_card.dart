import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String url;
  final String description;

  ImageCard({required this.imageUrl, required this.url, required this.description});

  void _launchURL() async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: SizedBox(
        // height: MediaQuery.of(context).size.height * 0.45,
        child: Card(
          margin: EdgeInsets.zero,
          shadowColor: Colors.black,
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),

          ),
          child: Container(
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Positioned.fill(
                //   child: Container(
                //     color: Colors.white.withOpacity(0.3),
                //   ),
                // ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Tap to Open',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 20.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      Column(
                        children: [
                          const SizedBox(height: 50,),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  description,
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold
                                    )
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
