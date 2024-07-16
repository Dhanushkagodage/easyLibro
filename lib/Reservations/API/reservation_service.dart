import 'dart:convert';

import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/Reservations/API/reservation.dart';
import 'package:easylibro_app/Reservations/API/reservation_details.dart';

class ReservationService{
  Future<List<Reservation>> fetchReservations(String keyword, String type ) async {
    final apiService = ApiService();
    await apiService.init();

    try{
      final response = await apiService.dio.post(
        'Reservation/SearchReservation',
        data: jsonEncode({
          'keywords': keyword,
          'type': type,
        }),
      );
     //print (response.data);
      if(response.statusCode == 200){
        List<dynamic> body = response.data;
        return body.map((dynamic item) => Reservation.fromJson(item)).toList();
      }else{
        throw Exception('Failed to load reservations');
      }
    }catch(e){
      //print('Error fetching reservations: $e');
      throw Exception('Failed to load reservations: $e');
    }
  }

  Future<Reservationdetails> fetchReservationDetails(int id) async {
    final apiService = ApiService();
    await apiService.init();

    try{
      final response = await apiService.dio.post('Reservation/About?resId=$id');
      if(response.statusCode == 200){
        return Reservationdetails.fromJson(response.data);
      }else{
        throw Exception('Failed to load reservation');
      }
    }catch(e){
      //print('Error fetching reservation: $e');
      throw Exception('Failed to load reservation: $e');
    }
  }

}