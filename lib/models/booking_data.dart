class BookingData {
  late String workspaceName;
  late int workSpaceId;
  late String bookingDate;

  BookingData({
    required this.workspaceName,
    required this.workSpaceId,
    required this.bookingDate,
  });


  static BookingData getObjectFromJson(Map<String,dynamic> jsonData) {
    return BookingData(
      workspaceName: jsonData['workspace_name'], 
      workSpaceId: jsonData['workspace_id'], 
      bookingDate: jsonData['booking_date']
    );
  }

}