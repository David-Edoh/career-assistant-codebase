import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '../../../data/models/HomePage/career_suggestion_resp.dart';
import '../../../widgets/footprint_icon.dart';
import '../../../widgets/image_card.dart';

class CertificationsRow extends StatelessWidget {
  final String description;
  final String subject;
  final List<SuggestedCertification> certifications;

  CertificationsRow({
    required this.description,
    required this.subject,
    required this.certifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: DotSection(),
          ),
          Text(subject, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Pre Duration: $learningDuration streak."),
              Text(
                "(This is optional)",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Description:",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text('$description',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
          SizedBox(height: 8),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              padEnds: false,
              enlargeFactor: 0.3,
              // clipBehavior: Clip.none,
            ),
            items: certifications.map((cert) {
              return _getUrlValid( cert.url.toString().fixWhiteSpaceInUrl().removeWwwFromUrl())
                  ? Semantics(
                label: "Button with image for An optional Certificate I suggest you get: ${cert.certificationName}",
                  child: CertificationTile(certification: cert)
              )
                  : Text(cert.url.toString());
            }).toList(),
          ),
        ],
      ),
    );
  }

  bool _getUrlValid(String url) {
    bool _isUrlValid =
    AnyLinkPreview.isValidLink(url, protocols: ['http', 'https']);
    return _isUrlValid;
  }
}

class CertificationTile extends StatelessWidget {
  final SuggestedCertification certification;

  CertificationTile({super.key, required this.certification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: AnyLinkPreview(
              displayDirection: UIDirection.uiDirectionVertical,
              link: certification.url
                  .toString()
                  .fixWhiteSpaceInUrl()
                  .removeWwwFromUrl(),
              backgroundColor: Colors.white,
              errorBody: 'Show my custom error body',
              errorTitle: 'Next one is youtube link, error title',
              errorWidget: ImageCard(
                imageUrl: 'https://images.unsplash.com/photo-1589330694653-ded6df03f754?q=80&w=2116&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                url: certification.url.toString().fixWhiteSpaceInUrl().removeWwwFromUrl(),
                description: certification.certificationName,
              ),
              // Container(
              //   color: Colors.white,
              //   child: Center(child: Text(certification.url.toString().fixWhiteSpaceInUrl().removeWwwFromUrl())),
              // ),
              // // errorImage: _errorImage,
            ),
          ),
        ],
      ),
    );
  }
}

