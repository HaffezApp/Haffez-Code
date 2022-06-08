import 'package:haffez/utils/assets.dart';

enum Gender {
  male,
  female,
}

extension GenderExtension on Gender {
  String get icon {
    switch (this) {
      case Gender.male:
        return Assets.shared.icMale;
      case Gender.female:
        return Assets.shared.icFemale;
    }
  }
}
