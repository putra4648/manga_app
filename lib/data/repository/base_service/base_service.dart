import 'package:http/http.dart' as http;

enum RequestType { GET, POST, DELETE }

class BaseService {
  Future<http.Response> response(RequestType requestType, String url,
      {dynamic body, Map<String, dynamic> headers}) async {
    http.Response response;
    switch (requestType) {
      case RequestType.GET:
        response = await http.get(url, headers: headers);
        break;
      case RequestType.POST:
        response = await http.post(url, body: body, headers: headers);
        break;
      case RequestType.DELETE:
        response = await http.delete(url, headers: headers);
        break;
    }

    if (response.statusCode != 200) {
      throw Exception('Error');
    }
    return response;
  }
}
