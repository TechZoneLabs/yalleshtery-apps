import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helper/shared_helper.dart';
import '../utils/constants_manager.dart';

abstract class ApiServices {
  Future<Map<String, dynamic>> get({
    required String file,
    required String action,
  });
  Future<Map<String, dynamic>> post({
    required String file,
    required String action,
    required Map<String, dynamic> body,
  });
}

class ApiServicesImpl implements ApiServices {
  final AppShared appShared;

  ApiServicesImpl(this.appShared);
  @override
  Future<Map<String, dynamic>> get(
      {required String file, required String action}) async {
    var response = await http.get(
      Uri.parse('${AppConstants.apiUrl}/$file?action=$action'),
      headers: await _header(),
    );
    return const JsonDecoder().convert(utf8.decode(response.bodyBytes));
  }

  @override
  Future<Map<String, dynamic>> post(
      {required String file,
      required String action,
      required Map<String, dynamic> body}) async {
    var response = await http.post(
      Uri.parse('${AppConstants.apiUrl}/$file?action=$action'),
      body: jsonEncode(body),
      headers: await _header(),
    );
    return const JsonDecoder().convert(utf8.decode(response.bodyBytes));
  }

  Future<Map<String, String>> _header() async {
    String clientToken = appShared.getVal(AppConstants.userTokenKey) ?? '0';
    String lang = appShared.getVal(AppConstants.langKey) ??
        AppConstants.arabic.languageCode;
    return {
      "Content-Type": "application/json",
      "Affiliator-Token": AppConstants.affiliatorToken,
      "User-Token": clientToken,
      "Front-Lang": lang,
    };
  }
}
