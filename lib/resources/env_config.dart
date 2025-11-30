import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration class to access environment variables
/// All sensitive credentials should be loaded from .env file
class EnvConfig {
  // Firebase Configuration
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get firebaseAuthDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  static String get firebaseDatabaseUrl =>
      dotenv.env['FIREBASE_DATABASE_URL'] ?? '';
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  static String get firebaseMeasurementId =>
      dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '';

  // Google Apps Script APIs
  static String get apiEnviarSolpe => dotenv.env['API_ENVIAR_SOLPE'] ?? '';
  static String get apiFem => dotenv.env['API_FEM'] ?? '';
  static String get apiOeMes => dotenv.env['API_OE_MES'] ?? '';
  static String get apiFileUpload => dotenv.env['API_FILE_UPLOAD'] ?? '';
}

