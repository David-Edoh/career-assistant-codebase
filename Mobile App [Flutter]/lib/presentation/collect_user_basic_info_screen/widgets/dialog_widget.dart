import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../bloc/collect_user_basic_info_bloc.dart';
import '../models/education_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_icon_button.dart';

import '../models/collect_user_basic_info_model.dart';

// ignore: must_be_immutable
class CustomDialogWidget extends StatelessWidget {
  CustomDialogWidget(
      this.educationItemModelObj, {
        Key? key,
      }) : super(
    key: key,
  );

  EducationItemModel educationItemModelObj;

  static Widget builder(BuildContext context) {
    return BlocProvider<CollectBasicUserInfoBloc>(
        create: (context) => CollectBasicUserInfoBloc(CollectBasicUserInfoState(hobbiesController: TextfieldTagsController()))
          ..add(InitializeCollectBasicUserInfoEvent()),
        child: CustomDialogWidget(EducationItemModel(itemId: 0, itemType: '')));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectBasicUserInfoBloc, CollectBasicUserInfoState>(
        builder: (context, state)
    {
      return AlertDialog(
        title: const Text(
            'Delete'),
        content:
        const Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, 'Cancel'),
            child:
            const Text('Cancel'),
          ),
          TextButton(
            onPressed:
                () {
              context.read<CollectBasicUserInfoBloc>().add(
                DeleteItemEvent(
                  itemId: educationItemModelObj.itemId,
                  itemType: educationItemModelObj.itemType,
                  onDeleteItemError: () {
                    Fluttertoast.showToast(msg: "Failed Deleting Item", toastLength: Toast.LENGTH_LONG);
                  },
                  onDeleteItemSuccess: () {
                    Fluttertoast.showToast(msg: "Item Deleted Successfully", toastLength: Toast.LENGTH_LONG);
                    Navigator.pop(context, 'Delete');
                  },
                ),
              );
            },
            child:
            const Text('Delete'),
          ),
        ],
      );
    });
  }
}
