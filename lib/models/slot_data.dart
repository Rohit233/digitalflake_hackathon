class SlotData {
  late String slotName;
  late int slotId;
  late bool slotActive;


  SlotData({
    required this.slotActive,
    required this.slotId,
    required this.slotName,
  });


  static SlotData getObjectFromJson(Map<String,dynamic> jsonData) {
    return SlotData(
      slotActive: jsonData['slot_active'],
      slotId: jsonData['slot_id'], 
      slotName: jsonData['slot_name']
    );
  }


}