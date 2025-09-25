import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/enums/operation_state.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/fnf/presentation/search/provider/contact_list_provider.dart';
import 'package:app/feature/fnf/presentation/search/widget/contacts_list_single_item.dart';
import 'package:app/feature/fnf/presentation/search/widget/empty_contact_list_widget.dart';
import 'package:app/feature/fnf/presentation/search/widget/search_button_widget.dart';
import 'package:app/feature/fnf/presentation/search/widget/search_result_widget.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/skeleton_list.dart';
import '../provider/fnf_search_provider.dart';

class FnfSearchPage extends ConsumerStatefulWidget {
  const FnfSearchPage({super.key});

  @override
  ConsumerState<FnfSearchPage> createState() => _FnfSearchPageState();
}

class _FnfSearchPageState extends ConsumerState<FnfSearchPage> {
  String? searchText;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(contactListProvider.notifier).populateContacts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fnfSearchProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: HomeBackground(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: context.language.searchFnf),
              Expanded(
                child: CurvedTopRadiusToChild(
                  child: Column(
                    children: [
                      16.gapH,
                      SearchButtonWidget(searchController: _searchController),
                      _buildSearchResult(context, state),
                      8.gapH,
                      Expanded(child: _buildContactList(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResult(BuildContext context, FnfSearchState state) {
    switch (state.searchState) {
      case OperationState.waiting:
        return const Center(child: CircularProgressIndicator());
      case OperationState.done:
        if (state.searchResult == null) return const SizedBox.shrink();
        return Padding(
          padding: Styles.horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.language.searchResults,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.colorGrey,
                ),
              ),
              8.gapH,
              SearchResultWidget(model: state.searchResult!),
            ],
          ),
        );
      case OperationState.error:
        return Container(
          width: double.infinity,
          margin: Styles.horizontalPadding.copyWith(top: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            state.errorMessage ?? context.language.noUserFound,
            textAlign: TextAlign.center,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildContactList(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final contactState = ref.watch(contactListProvider).state;
        final contacts = ref.watch(contactListProvider).filteredContacts;

        // List<Contact> contacts;
        // if (filteredContacts.isEmpty) {
        //   contacts = ref.read(contactListProvider).allContacts;
        // } else {
        //   contacts = filteredContacts;
        // }

        if (contactState == OperationState.waiting) {
          final testContact = Contact(
            id: '1',
            displayName: 'Rahim Uddin',
            isStarred: true,
            name: Name(first: 'Rahim', middle: 'Hasan', last: 'Uddin'),
            phones: [Phone('+8801234567890')],
          );

          return SkeletonList(
            separator: Dimens.padding10,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ContactsListSingleItem(
              item: testContact,
              onTap: (_) {},
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Styles.horizontalPadding,
              child: Text(
                context.language.contacts,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.colorGrey,
                ),
              ),
            ),
            Padding(
              padding: Styles.horizontalPadding,
              child: const DottedLine(),
            ),
            8.gapH,
            if (contacts.isEmpty)
              const Expanded(child: EmptyContactListWidget())
            else
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 8.h),
                  itemCount: contacts.length,
                  separatorBuilder: (_, __) => 10.gapH,
                  itemBuilder: (_, index) {
                    final item = contacts[index];
                    return ContactsListSingleItem(
                      item: item,
                      onTap: (number) {
                        final cleaned =
                            number.isNotEmpty ? trimToElevenDigits(number) : '';
                        _searchController.text = cleaned;
                        if (cleaned.isEmpty) return;
                        _search(cleaned);
                      },
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  void _search(String number) {
    ref
        .read(fnfSearchProvider.notifier)
        .searchFnf(phoneNumber: number, token: context.apiToken);
  }
}
