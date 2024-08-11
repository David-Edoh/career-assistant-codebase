import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../presentation/home_container_screen/bloc/home_container_bloc.dart';
import '../provider/floating-hearts-provider.dart';

class HeartButton extends StatelessWidget {

  HeartButton({
      super.key,
      this.context2,
      this.postId,
      this.getUpdatedPost,
      this.setActiveHeart,
  });

  BuildContext? context2;
  int? postId;
  Function? getUpdatedPost;
  Function? setActiveHeart;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () async {
        context.read<HomeContainerBloc>().add(TogglePostReactionEvent(postId: postId));
        setActiveHeart!();
        FloatingHeartsProvider floatingHeartsProvider = context2!.read<FloatingHeartsProvider>();
        for(int i = 0; i < 15; i++){
          await Future.delayed(const Duration(milliseconds: 150));
          floatingHeartsProvider.addHeart();
        }
        getUpdatedPost!();
      },
      elevation: 2.0,
      shape: const CircleBorder(),
      child: Icon(
        semanticLabel: "React to this article with a heart",
        Icons.favorite_border_outlined,
        color: Colors.black.withOpacity(0.6),
        size: size.width * 0.06,
      ),
    );
  }
}
