import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl =
      'https://dev-password-manager.up.railway.app/api/v1/accounts/login';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  final storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final String apiKey = dotenv.env['API_KEY']!;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/'),
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
        // Save tokens
        await storage.write(key: accessTokenKey, value: data['access_token']);
        await storage.write(key: refreshTokenKey, value: data['refresh_token']);

        return true;
      } else {
        // Failed login
        return false;
      }
    } catch (e) {
      // Error occurred during login
      print('Error: $e');
      return false;
    }
  }

  Future<bool> isTokenExpired() async {
    final accessToken = await storage.read(key: accessTokenKey);
    // Check if the access token is null or empty
    if (accessToken == null || accessToken.isEmpty) {
      // If access token is null or empty, consider it expired
      return true;
    } else {
      // Implement your token expiration logic here
      // For example, decode the access token (if it's a JWT) and check its expiry time
      // Return true if the token is expired, false otherwise
      // For illustration purposes, let's assume the token is a JWT and contains an 'exp' claim
      final decodedToken = _decodeJwt(accessToken);
      final expiryTime =
          decodedToken['exp']; // Assuming 'exp' contains the expiry timestamp
      final currentTime = DateTime.now().millisecondsSinceEpoch ~/
          1000; // Current time in seconds

      return expiryTime <
          currentTime; // Token is expired if expiry time is before current time
    }
  }

  // Example function to decode a JWT token (for illustration purposes)
  Map<String, dynamic> _decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw FormatException('Invalid JWT');
    }

    final payload = parts[1];
    final String normalizedPayload = base64Url.normalize(payload);
    final String decodedPayload =
        utf8.decode(base64Url.decode(normalizedPayload));
    return json.decode(decodedPayload);
  }

  // Function to log out if not using access token
  Future<void> logoutIfNotUsingAccessToken() async {
    final accessToken = await storage.read(key: accessTokenKey);
    final refreshToken = await storage.read(key: refreshTokenKey);

    // Check if both access token and refresh token are null
    if (accessToken == null && refreshToken == null) {
      // If both tokens are null, log out the user
      await logout();
    }
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: refreshTokenKey);
  }

  Future<void> logout() async {
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: refreshTokenKey);
  }
}
