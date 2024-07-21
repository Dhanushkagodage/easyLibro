import 'package:easylibro_app/Requests/Api/request.dart';
import 'package:easylibro_app/Requests/Api/request_services.dart';

class MyRequests {
  List<Request> allRequests = [];
  RequestService requestService = RequestService();

  Future<List<Request>> fetchRequests() async {
    allRequests = await requestService.fetchRequests();
    return allRequests;
  }

  List<String> getIsbnList() {
    return allRequests.map((request) => request.isbn).toList();
  }
}
