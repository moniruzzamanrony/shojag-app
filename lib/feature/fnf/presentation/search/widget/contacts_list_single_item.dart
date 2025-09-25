import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/style/style.dart';

class ContactsListSingleItem extends StatelessWidget {
  final Contact item;
  final void Function(String number) onTap;

  const ContactsListSingleItem(
      {super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasNumber = item.phones.isNotEmpty;
    final hasNoNumber = !hasNumber;
    final hasOnlySingleNumber = hasNumber && (item.phones.length == 1);
    return Card(
      margin: Styles.horizontalPadding,
      color: context.colorScheme.primary.shade(240),
      elevation: 0,
      child: ListTile(
        onTap: hasNoNumber
            ? null
            : hasOnlySingleNumber
                ? () => onTap(item.phones.first.number)
                : () => _showMultipleNumberDialog(context),
        leading: _buildLeadingName(),
        titleTextStyle: TextStyle(
            fontSize: 14.sp,
            height: 1.0,
            fontWeight: FontWeight.normal,
            color: AppColors.colorBlack),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        title: Text(item.displayName),
        // subtitle: _buildSubTitle(),
        trailing: CircleAvatar(
          radius: 12.r,
          backgroundColor: context.colorScheme.onPrimary,
          child: FaIcon(FontAwesomeIcons.chevronRight,
              size: 12.sp, color: context.colorScheme.primary),
        ),
      ),
    );
  }

  CircleAvatar _buildLeadingName() {
    String data = '#';
    if (item.name.first.isNotEmpty) {
      data = item.name.first[0];
    } else if (item.name.middle.isNotEmpty) {
      data = item.name.middle[0];
    } else if (item.name.last.isNotEmpty) {
      data = item.name.last[0];
    }
    return CircleAvatar(
      radius: 16.r,
      child: Text(data.toUpperCase(),
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
    );
  }

  void _showMultipleNumberDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          final phones = item.phones;
          return AlertDialog(
            title: Text(item.displayName),
            backgroundColor: context.colorScheme.primary.shade(240),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: phones.length,
                  itemBuilder: (_, index) {
                    final phone = phones[index];
                    return ListTile(
                      onTap: () {
                        context.pop();
                        onTap(phone.number);
                      },
                      title: Text(phone.number),
                    );
                  }),
            ),
          );
        });
  }
}
