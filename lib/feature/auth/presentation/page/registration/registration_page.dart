/*
ui : registration page ui
*/

import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:app/feature/auth/presentation/page/registration/forms/form_ambulance_reg.dart';
import 'package:app/feature/auth/presentation/page/registration/forms/form_citizen_reg.dart';
import 'package:app/feature/auth/presentation/page/registration/forms/form_fire_service_reg.dart';
import 'package:app/feature/auth/presentation/page/registration/forms/form_police_reg.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_error_text_widget.dart';
import 'package:app/feature/auth/presentation/page/registration/reg_user_type_widget.dart';
import 'package:app/feature/auth/presentation/provider/registration_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/router/routes.dart';
import '../../../../../core/utils/enums/user_type.dart';
import '../../../../../shared/presentation/widget/custom_app_bar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController policeIdController;
  late final TextEditingController organizationController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController repeatPasswordController;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    policeIdController = TextEditingController();
    organizationController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();

    context.read<RegistrationProvider>().resetAll();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    policeIdController.dispose();
    organizationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            CustomAppBar(
              title: context.language.registration,
              color: Colors.white,
            ),
            Expanded(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: Styles.horizontalPadding,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 24.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: Styles.boxShadow()),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                            text: context.language
                                                    .selectHowYouWantToJoinWith,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                height: 1,
                                                color:
                                                    context.colorScheme.primary,
                                                fontWeight: FontWeight.normal)),
                                      ]),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          height: 1,
                                          color: AppColors.colorBlack,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            8.gapH,
                            _userType(context),
                          ],
                        ),
                      ),
                      20.gapH,
                      _formByUserType(),
                      8.gapH,
                      const RegErrorTextWidget(),
                      32.gapH,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.language.alreadyAMember,
                            style: TextStyle(
                                color: AppColors.colorAppGrey, fontSize: 14.sp),
                          ),
                          4.gapW,
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              context.goNamed(Routes.login);
                            },
                            child: Text(
                              context.language.login,
                              style: TextStyle(
                                  color: AppColors.colorAppBlueDark,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      40.gapH,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userType(BuildContext ctx) =>
      Selector<RegistrationProvider, UserType?>(
        selector: (_, provider) => provider.selectedUserType,
        builder: (_, value, __) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: RegUserTypeWidget(
              userType: UserType.citizen,
              isSelected: value == UserType.citizen,
              title: ctx.language.citizen,
            )),
            8.gapW,
            Expanded(
                child: RegUserTypeWidget(
              userType: UserType.police,
              isSelected: value == UserType.police,
              title: ctx.language.police,
            )),
            8.gapW,
            Expanded(
                child: RegUserTypeWidget(
              userType: UserType.fireService,
              isSelected: value == UserType.fireService,
              title: ctx.language.fire_service,
            )),
            8.gapW,
            Expanded(
                child: RegUserTypeWidget(
              userType: UserType.ambulance,
              isSelected: value == UserType.ambulance,
              title: ctx.language.ambulance,
            )),
          ],
        ),
      );

  Widget _formByUserType() {
    return Form(
      key: _formKey,
      child: AnimatedSize(
        duration:  const Duration(milliseconds: 300),
        child: Selector<RegistrationProvider, UserType?>(
          builder: (_, value, __) {
            Widget child =  const SizedBox(
              width: double.infinity,
            );
            if (value == UserType.citizen) {
              child =  const FormCitizenReg();
            } else if (value == UserType.police) {
              child =  const FormPoliceReg();
            } else if (value == UserType.fireService) {
              child =  const FormFireServiceReg();
            } else if (value == UserType.ambulance) {
              child =  const FormAmbulanceReg();
            }
            return child;
          },
          selector: (_, provider) => provider.selectedUserType,
        ),
      ),
    );
  }
}
