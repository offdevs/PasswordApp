class AppException implements Exception {
  final String msj;
  final int? statusCode;

  AppException({required this.msj, this.statusCode});
}
