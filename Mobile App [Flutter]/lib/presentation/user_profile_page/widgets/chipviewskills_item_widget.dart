import '../models/chipviewskills_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';

// ignore: must_be_immutable
class ChipviewskillsItemWidget extends StatelessWidget {
  ChipviewskillsItemWidget(
    this.chipviewskillsItemModelObj, {
    Key? key,
    this.onSelectedChipView,
  }) : super(
          key: key,
        );

  ChipviewskillsItemModel chipviewskillsItemModelObj;

  Function(bool)? onSelectedChipView;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: getPadding(
        left: 16,
        top: 14,
        right: 16,
        bottom: 14,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        chipviewskillsItemModelObj.skillsoneTxt,
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: chipviewskillsItemModelObj.isSelected,
      backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      selectedColor: Colors.transparent,
      shape: chipviewskillsItemModelObj.isSelected
          ? RoundedRectangleBorder(
              side: BorderSide(
                color: appTheme.blueGray5001,
                width: getHorizontalSize(1),
              ),
              borderRadius: BorderRadius.circular(
                getHorizontalSize(22),
              ),
            )
          : RoundedRectangleBorder(
              side: BorderSide(
                color: appTheme.blueGray50,
                width: getHorizontalSize(1),
              ),
              borderRadius: BorderRadius.circular(
                getHorizontalSize(22),
              ),
            ),
      onSelected: (value) {
        onSelectedChipView?.call(value);
      },
    );
  }
}
