import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_button_widget.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_email_widget.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_gender_widget.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_name_widget.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_password_widget.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_phone_widget.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_repeat_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widget/terms_and_condition_widget.dart';

class FormCitizenReg extends StatefulWidget {
  const FormCitizenReg({super.key});

  @override
  State<FormCitizenReg> createState() => _FormCitizenRegState();
}

class _FormCitizenRegState extends State<FormCitizenReg> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;

  late final TextEditingController _lastNameController;

  late final TextEditingController _emailController;

  late final TextEditingController _phoneController;

  late final TextEditingController _passwordController;

  late final TextEditingController _repeatPasswordController;
  late final TextEditingController _policeIdController;
  late final TextEditingController _organizationController;

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    _policeIdController = TextEditingController();
    _organizationController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _policeIdController.dispose();
    _organizationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int interval = 120;
    final int period = 30;
    final duration = Duration(milliseconds: interval);
    final delay0 = Duration(milliseconds: interval * 0);
    final delay1 = Duration(milliseconds: interval * 1 - (period * 1));
    final delay2 = Duration(milliseconds: interval * 2 - (period * 2));
    final delay3 = Duration(milliseconds: interval * 3 - (period * 3));
    final delay4 = Duration(milliseconds: interval * 4 - (period * 4));
    final delay5 = Duration(milliseconds: interval * 5 - (period * 5));
    final delay6 = Duration(milliseconds: interval * 6 - (period * 6));

    List<Effect<dynamic>>? effects = [
      SlideEffect(
          duration: duration, begin:  const Offset(0.0, -0.2), end: Offset.zero),
      FadeEffect(duration: duration),
    ];
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RegNameWidget(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController)
              .animate(
            delay: delay0,
            effects: effects,
            key: UniqueKey(),
          ),
          _itemSeparator(),
          RegEmailWidget(emailController: _emailController).animate(
            delay: delay1,
            effects: effects,
            key: UniqueKey(),
          ),
          _itemSeparator(),
          RegPhoneWidget(
            phoneController: _phoneController,
          ).animate(
            delay: delay2,
            effects: effects,
            key: UniqueKey(),
          ),
          _itemSeparator(),
          const RegGenderWidget().animate(delay: delay3, effects: [
            SlideEffect(duration: duration),
            FadeEffect(duration: duration),
          ]).animate(
            delay: delay3,
            effects: effects,
            key: UniqueKey(),
          ),
          _itemSeparator(),
          RegPasswordWidget(
            passwordController: _passwordController,
          ).animate(
            delay: delay4,
            effects: effects,
            key: UniqueKey(),
          ),
          _itemSeparator(),
          RegRepeatPasswordWidget(
                  passwordController: _passwordController,
                  repeatPasswordController: _repeatPasswordController)
              .animate(
            delay: delay5,
            effects: effects,
            key: UniqueKey(),
          ),
          _itemSeparator(),
          const TermsAndConditionWidget().animate(
            delay: delay6,
            effects: effects,
            key: UniqueKey(),
          ),
          _itemSeparator(),
          RegButtonWidget(
                  formKey: _formKey,
                  emailController: _emailController,
                  policeIdController: _policeIdController,
                  organizationController: _organizationController,
                  passwordController: _passwordController,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  phoneController: _phoneController)
              .animate(key: UniqueKey(), delay: delay5, effects: effects),
        ],
      ),
    );
  }

  Widget _itemSeparator() => 12.gapH;
}
