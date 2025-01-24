import 'package:dogs/src/utils/exports.dart';

class HttpServices {
  static final Dio _deo = Dio();
  static final Options _options = Options(
      contentType: 'application/json',
      validateStatus: (int? statusCode) => true);

  static Future<Response>? getMethod({required String path}) async =>
      await _deo.get(path, options: _options);

  static Future<Response>? postMethod({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    FormData formData = FormData.fromMap(body);

    return await _deo.post(path, data: formData, options: _options);
  }
}
