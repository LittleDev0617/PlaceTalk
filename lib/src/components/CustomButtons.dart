import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton(
      {super.key, required this.itemList, required this.customOnChanged});

  final Map<String, Map<String, dynamic>> itemList;
  final void Function(String?) customOnChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
        underline: const SizedBox.shrink(),
        dropdownStyleData: DropdownStyleData(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          offset: const Offset(0, -5),
        ),
        isExpanded: true,
        hint: Text(
          '내 주변 핫플',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        items: itemList.keys.toList().map((String itemText) {
          return DropdownMenuItem<String>(
            value: itemText,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: .5,
                    color: const Color(0xff707070).withOpacity(.5),
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width * .75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${DateFormat('M.d').format(itemList[itemText]!['startDate'])}~${DateFormat('M.d').format(itemList[itemText]!['endDate'])}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffff7d7d),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          customOnChanged(newValue);
        });
  }
}

class CustomIconText extends StatelessWidget {
  final Icon icons;
  final String text;

  const CustomIconText({super.key, required this.icons, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icons,
        const SizedBox(width: 3),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class CustomIconTextButton extends StatelessWidget {
  final Widget iconButton;
  final String text;

  const CustomIconTextButton(
      {super.key, required this.iconButton, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconButton,
        const SizedBox(width: 3),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
