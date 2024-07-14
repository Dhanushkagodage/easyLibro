
import 'package:easylibro_app/Requests/Api/request.dart';
import 'package:easylibro_app/Requests/Api/request_services.dart';

class MyRequests{
  List <Request> allRequests = [];
  RequestService requestService = RequestService();

  Future<void> fetchRequests() async {
    allRequests = await requestService.fetchRequests();
  }
}