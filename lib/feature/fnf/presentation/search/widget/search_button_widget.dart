import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/fnf/presentation/search/provider/contact_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/message_type.dart';
import '../../../../../core/utils/helper/helper_functions.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../core/utils/validator/field_validators.dart';
import '../provider/fnf_search_provider.dart';

class SearchButtonWidget extends ConsumerStatefulWidget {
  final TextEditingController searchController;

  const SearchButtonWidget({super.key, required this.searchController});

  @override
  ConsumerState<SearchButtonWidget> createState() => _SearchButtonWidgetState();
}

class _SearchButtonWidgetState extends ConsumerState<SearchButtonWidget> {
  late final GlobalKey<FormState> _formKey;

  late ValueNotifier<bool> _isSearchEnableNotifier;

  void _textFieldUpdater() {
    final input = widget.searchController.text;
    bool searchEnable = validate(input);
    ref.read(contactListProvider.notifier).filterContacts(input);
    if (_isSearchEnableNotifier.value != searchEnable) {
      _isSearchEnableNotifier.value = searchEnable;
    }
  }

  bool validate(String input) {
    if (input.isEmpty || input.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _isSearchEnableNotifier =
        ValueNotifier(validate(widget.searchController.text));
    widget.searchController.addListener(_textFieldUpdater);
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_textFieldUpdater);
    _isSearchEnableNotifier.dispose();
    _formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderSide = const BorderSide(color: Color(0xffe8eaf1));
    final focusedBorderSide = BorderSide(color: context.colorScheme.primary);
    final borderRadius = BorderRadius.circular(10.r);
    final border =
        OutlineInputBorder(borderRadius: borderRadius, borderSide: borderSide);
    return Padding(
      padding: Styles.horizontalPadding,
      child: Form(
        key: _formKey,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: TextFormField(
              controller: widget.searchController,
              maxLength: 11,
              validator: FieldValidators(context).phoneValidator,
              decoration: InputDecoration(
                  border: border,
                  isDense: true,
                  suffixIcon: ValueListenableBuilder(
                    valueListenable: _isSearchEnableNotifier,
                    builder: (_, isSearchEnable, __) => InkWell(
                      onTap: () => isSearchEnable ? _search(context) : null,
                      child: Container(
                        width: 44.r,
                        height: 44.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: isSearchEnable
                                ? context.colorScheme.primary
                                : context.colorScheme.primary.shade(180),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            )),
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: Dimens.iconSize20,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  focusedBorder: border.copyWith(borderSide: focusedBorderSide),
                  enabledBorder: border,
                  hintStyle: const TextStyle(color: AppColors.colorGreyLight),
                  hintText: context.language.searchNumber)),
        ),
      ),
    );
  }

  void _search(BuildContext context) async {
    hideAppKeyboard(context);
    if (!_formKey.currentState!.validate()) return;
    final number = widget.searchController.text;
    final token = context.apiToken;
    ref
        .read(fnfSearchProvider.notifier)
        .searchFnf(phoneNumber: number, token: token)
        .onError(
      (error, stackTrace) {
        if (context.mounted) {
          showAppSnackBar(context, error.toString(), type: MessageType.error);
        }
      },
    );
  }
}
