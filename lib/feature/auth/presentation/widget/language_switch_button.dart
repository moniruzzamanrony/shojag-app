import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/settings/presentation/provider/settings_provider.dart';
import 'package:app/shared/domain/entity/language_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LanguageSwitchButton extends StatefulWidget {
  const LanguageSwitchButton({super.key});

  @override
  State<LanguageSwitchButton> createState() => _LanguageSwitchButtonState();
}

class _LanguageSwitchButtonState extends State<LanguageSwitchButton> {

  @override
  Widget build(BuildContext context) {
    return Selector<SettingsProvider, LanguageEntity>(
      selector: (_, provider) => provider.language,
      builder: (_, language, __) => AnimatedToggleSwitch<int>.size(
        height: 32.h,
        current: language.locale == 'en' ? 1 : 2,
        borderWidth: 0,
        style: ToggleStyle(
            borderColor: Colors.transparent,
            backgroundColor: Colors.white,
            indicatorColor: context.colorScheme.primary.shade(200)),
        indicatorSize: Size.fromWidth(52.w),
        iconBuilder: (v) {
          final isSelected = (language.locale == 'en' ? 1 : 2) == v;
          return Text(
            v == 1 ? 'English' : 'বাংলা',
            style: TextStyle(
                fontSize: 12.sp,
                height: 1.2,
                color: isSelected ? context.colorScheme.primary : null,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w300),
          );
        },
        selectedIconScale: 1,
        onChanged: (i) {
          Provider.of<SettingsProvider>(context, listen: false)
              .saveLanguage(i == 1 ? 'en' : 'bn');
        },
        values:  const [1, 2],
      ),
    );
  }
}
