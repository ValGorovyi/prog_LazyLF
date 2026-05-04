
enum ApiClientExeptionType { Network, Auth, Other, SessionExpired }
class ApiClientExeption implements Exception {
  final ApiClientExeptionType type;
  ApiClientExeption(this.type);
}