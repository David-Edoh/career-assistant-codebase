import 'package:fotisia/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../../widgets/image_card.dart';


class ErrorCardTile extends StatelessWidget {
  final String imageUrl;
  final String link;
  final String description;


  ErrorCardTile({super.key, required this.imageUrl, required this.link, required this.description,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: ImageCard(
              imageUrl: 'https://images.unsplash.com/photo-1589330694653-ded6df03f754?q=80&w=2116&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              url: link.toString().fixWhiteSpaceInUrl().removeWwwFromUrl(),
              description: description,
            ),
          ),
        ],
      ),
    );
  }
}