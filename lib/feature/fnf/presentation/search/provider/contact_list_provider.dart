import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/enums/operation_state.dart';

final contactListProvider =
    StateNotifierProvider<ContactNotifier, ContactState>(
        (ref) => ContactNotifier());

class ContactState {
  final List<Contact> allContacts;
  final List<Contact> filteredContacts;
  final OperationState state;

  ContactState({
    required this.allContacts,
    required this.filteredContacts,
    required this.state,
  });

  ContactState copyWith({
    List<Contact>? allContacts,
    List<Contact>? filteredContacts,
    OperationState? state,
  }) {
    return ContactState(
      allContacts: allContacts ?? this.allContacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      state: state ?? this.state,
    );
  }

  factory ContactState.initial() => ContactState(
        allContacts: [],
        filteredContacts: [],
        state: OperationState.idle,
      );
}

class ContactNotifier extends StateNotifier<ContactState> {
  ContactNotifier() : super(ContactState.initial());

  Future<void> populateContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      state = state.copyWith(state: OperationState.error);
      return;
    }
    state = state.copyWith(state: OperationState.waiting);
    try {
      final list = await FlutterContacts.getContacts(withProperties: true);
      state = state.copyWith(
        allContacts: list,
        filteredContacts: list,
        state: OperationState.success,
      );
    } catch (_) {
      state = state.copyWith(state: OperationState.error);
    }
  }

  void filterContacts(String? searchText) {
    if (searchText == null || searchText.trim().isEmpty) {
      state = state.copyWith(filteredContacts: state.allContacts);
      return;
    }

    final query = searchText.toLowerCase();
    final filtered = state.allContacts.where((contact) {
      final nameMatch = contact.displayName.toLowerCase().contains(query);
      final numberMatch = contact.phones.any(
        (phone) => phone.normalizedNumber.toLowerCase().contains(query),
      );
      return nameMatch || numberMatch;
    }).toList();

    state = state.copyWith(filteredContacts: filtered);
  }
}
