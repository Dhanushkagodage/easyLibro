import 'package:easylibro_app/Resources/API/resource_service.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';

class MyResources {
  List<Resource> allResources = [];
  final ResourceService _resourceService = ResourceService();

   Future<void> fetchResources(
      String keyword, String tag, String type) async {
    allResources = await _resourceService.fetchResources(keyword, tag, type);
  }
 
   List<Resource> getAllResourcesByCategory(String category) {
    if (category == "All") {
      return allResources;
    } else if (category == "Ebook") {
      return allResources
          .where((resource) => resource.type == "Ebook")
          .toList();
    } else if (category == "Journal") {
      return allResources
          .where((resource) => resource.type == "Journal")
          .toList();
    }
    return [];
  }

   List<Resource> getLatestResources(String category) {
    if (category == "All") {
      List<Resource> filteredResources = allResources;
      filteredResources.sort((a, b) => b.dateadded.compareTo(a.dateadded));
      List<Resource> latestResources = filteredResources.take(10).toList();
      return latestResources;
    } else {
      List<Resource> filteredResources =
          allResources.where((resource) => resource.type == category).toList();
      filteredResources.sort((a, b) => b.dateadded.compareTo(a.dateadded));
      List<Resource> latestResources = filteredResources.take(10).toList();
      return latestResources;
    }
  }

   List<Resource> getPopularResources(String category) {
    if (category == "All") {
      return allResources
          .where((resource) => resource.noOfRes > 0)
          .toList();
    } else {
      return allResources
          .where((resource) => resource.type == category && resource.noOfRes > 0)
          .toList();
    }
  }
}
