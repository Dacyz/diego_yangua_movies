import 'package:dio/dio.dart';
import 'dart:convert';

/// The BaseProvider class is the base class for all API providers.
/// It provides common methods for making HTTP requests to the API.
abstract class BaseProvider {
  final String service = const String.fromEnvironment('BASE_URL');
  final dio = Dio();

  /// Makes a GET request to the specified endpoint.
  ///
  /// Parameters:
  ///   - endpoint: The endpoint to make the request to.
  ///
  /// Returns:
  ///   A Future that resolves to the response object.
  ///
  /// Throws:
  ///   - DioException if the response status code is not 200.
  Future<Response> get(String endpoint) async {
    final response = await dio.get('$service/$endpoint');
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response._asException();
    }
  }

  /// Makes a POST request to the specified endpoint with the given body.
  ///
  /// Parameters:
  ///   - endpoint: The endpoint to make the request to.
  ///   - body: The body of the request.
  ///
  /// Returns:
  ///   A Future that resolves to the response object.
  ///
  /// Throws:
  ///   - DioException if the response status code is not 201.
  Future<Response> post(String endpoint, Map<String, dynamic> body) async {
    final response = await dio.post(
      '$service/$endpoint',
      options: Options(contentType: 'application/json'),
      data: json.encode(body),
    );

    if (response.statusCode == 201) {
      return response;
    } else {
      throw response._asException();
    }
  }

  /// Makes a PUT request to the specified endpoint with the given body.
  ///
  /// Parameters:
  ///   - endpoint: The endpoint to make the request to.
  ///   - body: The body of the request.
  ///
  /// Returns:
  ///   A Future that resolves to the response object.
  ///
  /// Throws:
  ///   - DioException if the response status code is not 200.
  Future<Response> put(String endpoint, Map<String, dynamic> body) async {
    final response = await dio.put(
      '$service/$endpoint',
      options: Options(contentType: 'application/json'),
      data: json.encode(body),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw response._asException();
    }
  }

  /// Makes a DELETE request to the specified endpoint.
  ///
  /// Parameters:
  ///   - endpoint: The endpoint to make the request to.
  ///
  /// Returns:
  ///   A Future that resolves to the response object.
  ///
  /// Throws:
  ///   - DioException if the response status code is not 200.
  Future<Response> delete(String endpoint) async {
    final response = await dio.delete('$service/$endpoint');
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response._asException();
    }
  }
}

// Returns a DioException representing a bad response.
//
// Parameters:
//   - response: The response object associated with the exception.
//   - requestOptions: The request options associated with the exception.
//   - statusCode: The status code of the response, or -1 if not available.
//
// Returns:
//   A DioException object.
extension ResponseExtension on Response {
  DioException _asException() => DioException.badResponse(
        response: this,
        requestOptions: requestOptions,
        statusCode: statusCode ?? -1,
      );
}
