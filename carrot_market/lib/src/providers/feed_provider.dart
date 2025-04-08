import 'package:get/get.dart';
import 'provider.dart';

class FeedProvider extends Provider {

  Future<Map> getList({int page = 1}) async {
    Response response = await get('/api/feed', query: {'page': '$page'});
    print(response.statusCode);
    print(response.bodyString);
    return response.body;
  }
}
