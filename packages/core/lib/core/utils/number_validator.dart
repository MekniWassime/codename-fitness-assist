String? numberValidator(
  String? value, {
  bool positive = false,
  bool nonZero = false,
  bool required = false,
}) {
  if (required && (value?.isEmpty ?? true)) return "this field is required";
  final number = double.tryParse(value ?? "0");
  if (number == null) return "please enter a valid number";
  if (nonZero && number == 0) return "please enter a non zero value";
  if (positive && number < 0) return "please enter a positive number";
  return null;
}
