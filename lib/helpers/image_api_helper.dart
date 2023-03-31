import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ImageAPIHelper {
  ImageAPIHelper._();
  static final ImageAPIHelper imageAPIHelper = ImageAPIHelper._();

  Future<Uint8List?> getImage({required String name}) async {
    String url = "https://source.unsplash.com/random/?$name";
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return res.bodyBytes;
    }
    return null;
  }
}
