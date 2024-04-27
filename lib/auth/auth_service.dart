import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String loginUrl =
      'https://dev-password-manager.up.railway.app/api/v1/accounts/login';
  static const String refreshTokenUrl =
      'https://dev-password-manager.up.railway.app/api/v1/token/refresh';
  static const String logoutUrl =
      'https://dev-password-manager.up.railway.app/api/v1/accounts/logout';
  static const String registerUrl =
      'https://dev-password-manager.up.railway.app/api/v1/accounts/user';
  static const String forgotPasswordUrl =
      'https://dev-password-manager.up.railway.app/api/v1/accounts/reset-password';
  static const String resetPasswordUrl =
      'https://dev-password-manager.up.railway.app/api/v1/accounts/confirm-password-reset';

  final storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final String apiKey = dotenv.env['API_KEY']!;

    try {
      final response = await http.post(
        Uri.parse('$loginUrl/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': apiKey,
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Save tokens securely
        await storage.write(key: 'token', value: data['token']);
        await storage.write(key: 'userId', value: data['user']);

        return true;
      } else {
        // Failed login
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    final String apiKey = dotenv.env['API_KEY']!;
    try {
      final response = await http.post(
        Uri.parse('$registerUrl/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': apiKey,
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);

        // Save tokens securely
        await storage.write(key: 'token', value: data['token']);
        await storage.write(key: 'userId', value: data['id']);
        // Log in the user after successful sign-up
        //final bool loginSuccess = await login(email, password);
        return true;
      } else if (response.statusCode == 409) {
        // User already exists
        // Show a dialog informing the user
        return true;
      } else {
        // Failed sign-up
        return false;
      }
    } catch (e) {
      // Error occurred during sign-up

      return false;
    }
  }

  // Verify email address
  Future<bool> verifyEmail(String email, String verificationCode) async {
    final String apiKey = dotenv.env['API_KEY']!;
    final userId = await storage.read(key: 'userId');

    try {
      final response = await http.post(
        Uri.parse('$registerUrl/$userId/confirm-code/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': apiKey,
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'verification_code': verificationCode,
        }),
      );
      if (response.statusCode == 200) {
        // If email verification is successful, log in the user
        return true;
      } else {
        // Failed to verify email
        return false;
      }
    } catch (e) {
      // Error occurred during email verification

      return false;
    }
  }

  //forgot password
  Future<bool> forgotPassword(String email) async {
    final String apiKey = dotenv.env[
        'API_KEY']!; // Get the API key from the .env file using the dotenv package
    try {
      final response = await http.post(
        Uri.parse('$forgotPasswordUrl/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': apiKey,
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Failed to send password reset email
        return false;
      }
    } catch (e) {
      // Error occurred during password reset

      return false;
    }
  }

  //reset password
  Future<bool> resetPassword(
      String email, String newPassword, String verificationCode) async {
    final String apiKey = dotenv.env['API_KEY']!;
    try {
      final response = await http.post(
        Uri.parse('$resetPasswordUrl/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': apiKey,
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'new_password': newPassword,
          'verification_code': verificationCode,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Failed to reset password
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //logout
  Future<bool> logout() async {
    final String apiKey = dotenv.env['API_KEY']!;
    try {
      final response = await http.post(
        Uri.parse('$logoutUrl/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': apiKey,
        },
      );

      if (response.statusCode == 200) {
        await storage.delete(key: 'token');
        await storage.delete(key: 'userId');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Error occurred during logout

      return false;
    }
  }

  Future<String> refreshToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$refreshTokenUrl/'),
      body: jsonEncode({'refreshToken': refreshToken}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final newToken = responseData['token'];
      // Store new token securely
      await storage.write(key: 'token', value: newToken);
      return newToken;
    } else {
      throw Exception('Failed to refresh token: ${response.statusCode}');
    }
  }

  bool isTokenExpired(String token) {
    final expiryTime = parseExpiryTimeFromToken(token);
    return DateTime.now().isAfter(expiryTime);
  }

  DateTime parseExpiryTimeFromToken(String token) {
    // JWT tokens are typically composed of three parts separated by dots
    List<String> parts = token.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid JWT token');
    }

    // Decode the second part of the token (payload)
    String payloadString = parts[1];
    String normalizedPayload =
        payloadString.replaceAll('-', '+').replaceAll('_', '/');
    String decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));

    // Parse the payload as JSON
    Map<String, dynamic> payloadJson = json.decode(decodedPayload);

    // Extract the expiration time ('exp' claim) from the payload
    dynamic exp = payloadJson['exp'];
    if (exp == null || !(exp is num)) {
      throw const FormatException(
          'Invalid JWT token: missing or invalid "exp" claim');
    }

    // Convert the expiration timestamp to a DateTime object
    DateTime expiryTime =
        DateTime.fromMillisecondsSinceEpoch((exp * 1000).toInt());

    return expiryTime;
  }

  Future<String?> getValidToken() async {
    final token = await storage.read(key: 'token');
    final refreshToken = await storage.read(key: 'refreshToken');

    if (token != null && !isTokenExpired(token)) {
      return token;
    } else if (refreshToken != null) {
      final newToken = await refreshToken;
      return newToken;
    } else {
      return null; // No valid token or refresh token available
    }
  }
}
