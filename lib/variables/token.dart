import 'dart:convert';

import 'package:dio/dio.dart';

class ApiToken {
  static String token =
      "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlWnBNd0VPZDRsTUFLcjVDYmtHN3VOd1JucjVLR2h5bWJZVFlXNVV6Nk1rIn0.eyJleHAiOjE2ODQyMjAzMTEsImlhdCI6MTY4Mzk2MTExMSwianRpIjoiNDBjM2RmNjgtM2ZlZi00ZWJkLWIzZTUtZjVhMGM2OTQzMTlhIiwiaXNzIjoiaHR0cHM6Ly9hY2NvdW50LXFhLmZ5eHQuY29tL2F1dGgvcmVhbG1zL3plcm8tZHJhbWEiLCJhdWQiOlsidGVzdC1sb2dpbi1zIiwicmVhbG0tbWFuYWdlbWVudCIsImJyb2tlciIsImFjY291bnQiXSwic3ViIjoibmF2aW4uYSsxQGJ1aWxkaW5nYmxvY2tzLmxhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoidGVzdC1sb2dpbi1zIiwic2Vzc2lvbl9zdGF0ZSI6IjRjNmFmODQ4LTEzYjQtNDMyNi05MWYzLTJhZGNmYWJmYzBjNCIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiKiIsImh0dHA6Ly9sb2NhbGhvc3Q6NDIwMCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy16ZXJvLWRyYW1hIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InJlYWxtLW1hbmFnZW1lbnQiOnsicm9sZXMiOlsidmlldy1pZGVudGl0eS1wcm92aWRlcnMiLCJ2aWV3LXJlYWxtIiwibWFuYWdlLWlkZW50aXR5LXByb3ZpZGVycyIsImltcGVyc29uYXRpb24iLCJyZWFsbS1hZG1pbiIsImNyZWF0ZS1jbGllbnQiLCJtYW5hZ2UtdXNlcnMiLCJxdWVyeS1yZWFsbXMiLCJ2aWV3LWF1dGhvcml6YXRpb24iLCJxdWVyeS1jbGllbnRzIiwicXVlcnktdXNlcnMiLCJtYW5hZ2UtZXZlbnRzIiwibWFuYWdlLXJlYWxtIiwidmlldy1ldmVudHMiLCJ2aWV3LXVzZXJzIiwidmlldy1jbGllbnRzIiwibWFuYWdlLWF1dGhvcml6YXRpb24iLCJtYW5hZ2UtY2xpZW50cyIsInF1ZXJ5LWdyb3VwcyJdfSwiYnJva2VyIjp7InJvbGVzIjpbInJlYWQtdG9rZW4iXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJ2aWV3LWFwcGxpY2F0aW9ucyIsInZpZXctY29uc2VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwiZGVsZXRlLWFjY291bnQiLCJtYW5hZ2UtY29uc2VudCIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSB0ZXN0LWxvZ2luLXMiLCJzaWQiOiI0YzZhZjg0OC0xM2I0LTQzMjYtOTFmMy0yYWRjZmFiZmMwYzQiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwidXNlcl9pZCI6ImVhYTVkNDdlLWRhNjAtNDkzNC1hMmY1LWYzZGM1NTlmOGFhOCIsIm5hbWUiOiJOYXZpbiBBbnRvbnkgUkIiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuYXZpbi5hKzFAYnVpbGRpbmdibG9ja3MubGEiLCJnaXZlbl9uYW1lIjoiTmF2aW4iLCJmYW1pbHlfbmFtZSI6IkFudG9ueSBSQiIsImVtYWlsIjoibmF2aW4uYSsxQGJ1aWxkaW5nYmxvY2tzLmxhIiwidXNlcl9pZF9yZW1vdGUiOiJjNDBkZmYyMC1mNjk1LTQ2ZjItYmVjYS1jMDZmNTVjNDhlMDkifQ.64LIjsCtE83q49bTAxlT5HsRjsAuhR-0ir2LLvVrZCr7NrMYsUtsltOPyb5xIuX32V6hglN0d-skrU5eOoW0un5e4w098BlRsgqaCCrScordRI4DsdI0QSTJ-aXvPN8vitSWLddeKV0-Yg6WU3reuRZnBr3Xmg_l7qCUNpy7oHdto8WkqkSszbUW7nfbI5fsak96OetRs9khYAloP62LDM6s78iBHHAgss4PuaoxMxK5syI1GippGWlL2cCyWw7yj8B9Rqgf_nZg2SByQQz9l3w04EiQc7Pki11hiEMNHNNG_p12UOPMWwxc5VMALMYzSSPzH7DFLPMM1K0zz5abQw";
  static String token1 = "";
  Future<void> GetToken() async {
    try {
      Dio dio = Dio();
      final response = await dio.post("https://devapifyxt.com/v1/login/",
          data: jsonEncode(<String, String>{
            'email': 'navin.a+1@buildingblocks.la',
            'password': 'Admin12345',
          }),
          options: Options(headers: {
            'source': 'android',
            'content-type': 'application/json'
          }));

      if (response.statusCode == 200) {
        token1 = response.data['token'];
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
