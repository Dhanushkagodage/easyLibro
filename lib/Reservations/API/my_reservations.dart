import 'package:easylibro_app/Reservations/API/reservation.dart';
import 'package:easylibro_app/Reservations/API/reservation_service.dart';

class MyReservations {
  List<Reservation> allReservations = [];
  final ReservationService _reservationService = ReservationService();

  Future<void> fetchReservations(String keyword, String type) async {
    allReservations =
        await _reservationService.fetchReservations(keyword, type);
  }

  List<Reservation> getAll(String category) {
    if (category == "All") {
      return allReservations;
    }
    return [];
  }

  List<Reservation> getDue(String category) {
    if (category == "All") {
      return allReservations.where((reservation) => reservation.status == "overdue").toList();
    }
    return [];
  }

  List<Reservation> getBorrowed(String category) {
    if (category == "All") {
      return allReservations.where((reservation) => reservation.status == "borrowed").toList();
    }
    return [];
  }

  List<Reservation> getReceived(String category) {
    if (category == "All") {
      return allReservations.where((element) => element.status == "received").toList();
    }
    return [];
  }
}
