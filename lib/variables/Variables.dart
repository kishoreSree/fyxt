import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fyxt/variables/token.dart';

class Variables {
  static const int _selectedindex = 0;
}

class dashData {
  static final Map<String, int> ApiDatas = {};
  var _selectedindex = 0;
  final token =
      "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlWnBNd0VPZDRsTUFLcjVDYmtHN3VOd1JucjVLR2h5bWJZVFlXNVV6Nk1rIn0.eyJleHAiOjE2ODQzODQyOTIsImlhdCI6MTY4NDEyNTA5MiwianRpIjoiYWViMjgxMmYtNGFmZC00ZDY0LWIyOGEtM2Q0ZWZlYzQ2YzU5IiwiaXNzIjoiaHR0cHM6Ly9hY2NvdW50LXFhLmZ5eHQuY29tL2F1dGgvcmVhbG1zL3plcm8tZHJhbWEiLCJhdWQiOlsidGVzdC1sb2dpbi1zIiwicmVhbG0tbWFuYWdlbWVudCIsImJyb2tlciIsImFjY291bnQiXSwic3ViIjoibmF2aW4uYSsxQGJ1aWxkaW5nYmxvY2tzLmxhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoidGVzdC1sb2dpbi1zIiwic2Vzc2lvbl9zdGF0ZSI6ImNhNTk1N2U0LTNkZWMtNDY0Yy04YzNjLWEwZWFjY2RmNzhlMCIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiKiIsImh0dHA6Ly9sb2NhbGhvc3Q6NDIwMCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy16ZXJvLWRyYW1hIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InJlYWxtLW1hbmFnZW1lbnQiOnsicm9sZXMiOlsidmlldy1pZGVudGl0eS1wcm92aWRlcnMiLCJ2aWV3LXJlYWxtIiwibWFuYWdlLWlkZW50aXR5LXByb3ZpZGVycyIsImltcGVyc29uYXRpb24iLCJyZWFsbS1hZG1pbiIsImNyZWF0ZS1jbGllbnQiLCJtYW5hZ2UtdXNlcnMiLCJxdWVyeS1yZWFsbXMiLCJ2aWV3LWF1dGhvcml6YXRpb24iLCJxdWVyeS1jbGllbnRzIiwicXVlcnktdXNlcnMiLCJtYW5hZ2UtZXZlbnRzIiwibWFuYWdlLXJlYWxtIiwidmlldy1ldmVudHMiLCJ2aWV3LXVzZXJzIiwidmlldy1jbGllbnRzIiwibWFuYWdlLWF1dGhvcml6YXRpb24iLCJtYW5hZ2UtY2xpZW50cyIsInF1ZXJ5LWdyb3VwcyJdfSwiYnJva2VyIjp7InJvbGVzIjpbInJlYWQtdG9rZW4iXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJ2aWV3LWFwcGxpY2F0aW9ucyIsInZpZXctY29uc2VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwiZGVsZXRlLWFjY291bnQiLCJtYW5hZ2UtY29uc2VudCIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSB0ZXN0LWxvZ2luLXMiLCJzaWQiOiJjYTU5NTdlNC0zZGVjLTQ2NGMtOGMzYy1hMGVhY2NkZjc4ZTAiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwidXNlcl9pZCI6ImVhYTVkNDdlLWRhNjAtNDkzNC1hMmY1LWYzZGM1NTlmOGFhOCIsIm5hbWUiOiJOYXZpbiBBbnRvbnkgUkIiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuYXZpbi5hKzFAYnVpbGRpbmdibG9ja3MubGEiLCJnaXZlbl9uYW1lIjoiTmF2aW4iLCJmYW1pbHlfbmFtZSI6IkFudG9ueSBSQiIsImVtYWlsIjoibmF2aW4uYSsxQGJ1aWxkaW5nYmxvY2tzLmxhIiwidXNlcl9pZF9yZW1vdGUiOiJjNDBkZmYyMC1mNjk1LTQ2ZjItYmVjYS1jMDZmNTVjNDhlMDkifQ.jp7ndlzROIXJ8ISmekw6Pt9vHkbOkM7EmYTtpkDeEiWgLOTeL3nQCZPAW0edKgmLtt0UofTwUE6vJ7Pyoj72MnjC-nKINCa5r344DpwKyT24jEaglqAVTe_tTpijzfJqe6VJ69BvXxqdQViGWr9KpoknX2heLZPovTUBWDpOJlIKEQq8_zvfyarmXBw8QcLKjqDAKhcFYdW5DcpgXaGHJ6GvCX_8gY2wFjK5bX3dRL1WwFpUKJrn4KXu0lGdtIT9WoP3WUY-9FlSJJK-NRfXm7YD5Mj_Q4vnlqsKbD53t3ciOi7alKqDCfwgdVO3JbW1lrusI6RP51vPm9huMIzDtQ";
  String token1 = ApiToken.token1;
  Future<Map<String, dynamic>> getContentFordashboard() async {
    try {
      Dio dio = Dio();
      final response = await dio.get('https://web.devapifyxt.com/v1/dashboard/',
          data: jsonEncode(<String, String>{
            'email': 'navin.a+1@buildingblocks.la',
            'password': 'Admin12345',
          }),
          options: Options(headers: {
            'source': 'android',
            'Authorization': 'Bearer ${token1}',
            'content-type': 'application/json'
          }));

      if (response.statusCode == 200) {
        // print('Dashboard Response:${response.data}');
        response.data.forEach((key, value) {
          ApiDatas[key] = value as int;
        });
        print('api:${ApiDatas}');
        // print('Api length:${ApiDatas.length}');
        // print('baseUrl:${baseUrl}');
        return response.data;
      } else {
        print("failed");
      }
    } catch (e) {
      print('dash:${e.toString()}');
    }
    return {};
  }
}
