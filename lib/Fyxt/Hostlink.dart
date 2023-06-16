import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fyxt/Fyxt/SecureStorage.dart';

class getDatasEnvironment {
  String baseUrl = '';
  Future getHostlink() async {
    Map<String, int> ApiDatas = {};
    var _selectedindex = 0;
    final token =
        'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlWnBNd0VPZDRsTUFLcjVDYmtHN3VOd1JucjVLR2h5bWJZVFlXNVV6Nk1rIn0.eyJleHAiOjE2ODM3NzczNzQsImlhdCI6MTY4MzUxODE3NCwianRpIjoiZWRmMTNkZDktZGU2MC00ZTAyLTk3NWUtNTk5ZmMzOThkOWNjIiwiaXNzIjoiaHR0cHM6Ly9hY2NvdW50LXFhLmZ5eHQuY29tL2F1dGgvcmVhbG1zL3plcm8tZHJhbWEiLCJhdWQiOlsidGVzdC1sb2dpbi1zIiwicmVhbG0tbWFuYWdlbWVudCIsImJyb2tlciIsImFjY291bnQiXSwic3ViIjoibmF2aW4uYSsxQGJ1aWxkaW5nYmxvY2tzLmxhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoidGVzdC1sb2dpbi1zIiwic2Vzc2lvbl9zdGF0ZSI6ImQyZTVkYzA4LWNjZjItNGJjNC05MGEzLWU0ZTViNWU1OGM2YSIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiKiIsImh0dHA6Ly9sb2NhbGhvc3Q6NDIwMCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy16ZXJvLWRyYW1hIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InJlYWxtLW1hbmFnZW1lbnQiOnsicm9sZXMiOlsidmlldy1pZGVudGl0eS1wcm92aWRlcnMiLCJ2aWV3LXJlYWxtIiwibWFuYWdlLWlkZW50aXR5LXByb3ZpZGVycyIsImltcGVyc29uYXRpb24iLCJyZWFsbS1hZG1pbiIsImNyZWF0ZS1jbGllbnQiLCJtYW5hZ2UtdXNlcnMiLCJxdWVyeS1yZWFsbXMiLCJ2aWV3LWF1dGhvcml6YXRpb24iLCJxdWVyeS1jbGllbnRzIiwicXVlcnktdXNlcnMiLCJtYW5hZ2UtZXZlbnRzIiwibWFuYWdlLXJlYWxtIiwidmlldy1ldmVudHMiLCJ2aWV3LXVzZXJzIiwidmlldy1jbGllbnRzIiwibWFuYWdlLWF1dGhvcml6YXRpb24iLCJtYW5hZ2UtY2xpZW50cyIsInF1ZXJ5LWdyb3VwcyJdfSwiYnJva2VyIjp7InJvbGVzIjpbInJlYWQtdG9rZW4iXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJ2aWV3LWFwcGxpY2F0aW9ucyIsInZpZXctY29uc2VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwiZGVsZXRlLWFjY291bnQiLCJtYW5hZ2UtY29uc2VudCIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSB0ZXN0LWxvZ2luLXMiLCJzaWQiOiJkMmU1ZGMwOC1jY2YyLTRiYzQtOTBhMy1lNGU1YjVlNThjNmEiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwidXNlcl9pZCI6ImVhYTVkNDdlLWRhNjAtNDkzNC1hMmY1LWYzZGM1NTlmOGFhOCIsIm5hbWUiOiJOYXZpbiBBbnRvbnkgUkIiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuYXZpbi5hKzFAYnVpbGRpbmdibG9ja3MubGEiLCJnaXZlbl9uYW1lIjoiTmF2aW4iLCJmYW1pbHlfbmFtZSI6IkFudG9ueSBSQiIsImVtYWlsIjoibmF2aW4uYSsxQGJ1aWxkaW5nYmxvY2tzLmxhIiwidXNlcl9pZF9yZW1vdGUiOiJjNDBkZmYyMC1mNjk1LTQ2ZjItYmVjYS1jMDZmNTVjNDhlMDkifQ.oTXwFvrMEk09VFFaeRl92RlJjqxs6vNarT8TbccmN2FTpz-6K8hsvICg64yQ8cmzPIg_6slu7FOO3cwUaDWK7Fz7PBRkXlL_rkYft_1uhPdqV2x0RZ5zoookqDbo-An0NSGEM0v178eOq76TuP_tVcSjRILe7egGIv63MnhBRKKl3QJA9MB037G-RVMi0QqMqndSXMcBgs82Ggz3xBWElnIpoO9s19N5imWHmbEP8LLHbeHSi95kh6J66NKriS7FPzxiithIFWIh2a2z10s1PLMzgXRVaFUwscuXG1suPifR-Qkj5DIedauXlywpAPqx3eTCbrX74wGuHvp6F7_tvQ';
    Future getContentFordashboard() async {
      try {
        Dio dio = Dio();
        final response =
            await dio.get('https://web.devapifyxt.com/v1/dashboard/',
                data: jsonEncode(<String, String>{
                  'email': 'navin.a+1@buildingblocks.la',
                  'password': 'Admin12345',
                }),
                options: Options(headers: {
                  'source': 'android',
                  'Authorization': 'Bearer $token',
                  'content-type': 'application/json'
                }));

        if (response.statusCode == 200) {
          getHost();
          print('Dashboard Response:${response.data}');
          response.data.forEach((key, value) {
            ApiDatas[key] = value as int;
          });
          print('api:${ApiDatas}');
          print('Api length:${ApiDatas.length}');
          print('baseUrl::${baseUrl}');
          return response.data;
        } else {
          print("failed");
        }
      } catch (e) {
        print(e.toString());
      }
    }

    // @override
    // void initState() {
    //   super.initState();
    //   getHost();
    // }
  }

  getHost() async {
    final getHost = await secureDatas.gethost();
    print('${await secureDatas.gethost()}');
    baseUrl = getHost;
    print(baseUrl);
    // }
  }
}
