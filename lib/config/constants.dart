import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String incidentapiurl = dotenv.env["BASE_API_URL"] ?? "";
  static String mapsApiKey = dotenv.env["MAPS_API_KEY"] ?? "";
  static String mapsGeocodeUrl = dotenv.env["GEOCODE_URL"] ?? "";


}