part of 'create_proyect_cubit.dart';

class CreateProjectState {
  final String name;
  final int indexColor;
  final bool isNameValid;
  final bool isColorValid;
  final bool isSubmitting;
  CreateProjectState({
    required this.name,
    required this.indexColor,
    required this.isNameValid,
    required this.isColorValid,
    required this.isSubmitting,
  });
  //copyWith
  CreateProjectState copyWith({
    String? name,
    int? indexColor,
    bool? isNameValid,
    bool? isColorValid,
    bool? isSubmitting,
  }) {
    return CreateProjectState(
      name: name ?? this.name,
      indexColor: indexColor ?? this.indexColor,
      isNameValid: isNameValid ?? this.isNameValid,
      isColorValid: isColorValid ?? this.isColorValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
