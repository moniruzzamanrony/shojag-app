import 'package:app/core/utils/extension/context_extension.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';

class FieldValidators {
  final BuildContext context;

  const FieldValidators(this.context);

  String? firstNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.firstNameIsRequired;
    }
    return null;
  }

  String? lastNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.lastNameIsRequired;
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.nameIsRequired;
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.emailIsRequired;
    }
    if (!EmailValidator.validate(value.trim())) {
      return context.language.emailShouldBeValid;
    }
    return null;
  }

  String? emailNullableValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (!EmailValidator.validate(value.trim())) {
      return context.language.emailShouldBeValid;
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.phoneNumberIsRequired;
    } else if (value.length != 11) {
      return context.language.phoneShouldBeElevenDigits;
    }
    return null;
  }

  String? phoneEmptyButNotInvalidValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    } else if (value.length != 11) {
      return context.language.phoneShouldBeElevenDigits;
    }
    return null;
  }

  String? genderValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.genderIsRequired;
    }
    return null;
  }

  String? thanaValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.thanaIsRequired;
    }
    return null;
  }

  String? policeIdValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.policeIdIsRequired;
    }
    return null;
  }

  String? fireStationValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.fireStationIsRequired;
    }
    return null;
  }

  String? hospitalAgencyValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.hospitalOrAgencyIsRequired;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.passwordIsRequired;
    } else if (value.length < 6) {
      return context.language.passwordShouldBeAtLeastCharacters(6);
    }
    return null;
  }

  String? repeatPasswordValidator(String? value, {String? anotherValue}) {
    if (value == null || value.trim().isEmpty) {
      return context.language.repeatPasswordIsRequired;
    } else if (value != anotherValue) {
      return context.language.passwordDidNotMatch;
    }
    return null;
  }

  String? emptyOrNullValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.language.canNotBeNullOrEmptyByField('');
    }
    return null;
  }

  String? customEmptyOrNullValidator(String? value,
      {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return context.language.canNotBeNullOrEmptyByField(fieldName);
    }
    return null;
  }
}
