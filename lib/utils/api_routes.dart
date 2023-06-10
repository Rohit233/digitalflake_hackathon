class ApiRoutes {
  static String baseUrl = 'https://demo0413095.mockable.io/digitalflake/api';

  static getLoginApiRoute () {
    return '$baseUrl/login';
  }

  static getCreateAccountApiRoute () {
    return '$baseUrl/create_account';
  }
  

  //* DATE FORMAT: YYY-MM-DD 
  static getSlotsApiRoute (String date) {
    return '$baseUrl/get_slots?date=$date';
  }

  //* DATE FORMAT: YYY-MM-DD 
  static getAvailailityApiRoute (String date,String slotId,String type) {
    return '$baseUrl/get_availability?date=$date&slot_id=$slotId&type=$type';
  }

  static getConfirmBookingApiRoute () {
    return '$baseUrl/confirm_booking';
  }

  static getBookingsApiRoute (String userId) {
    return '$baseUrl/get_bookings?user_id=$userId';
  }
 
}