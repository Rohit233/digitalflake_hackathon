import 'package:digitalflake_hackathon/enums/snackbar_type_enum.dart';
import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/models/form_model.dart/slot_booking_form.dart';
import 'package:digitalflake_hackathon/models/slot_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/utils/basic_utils.dart';
import 'package:digitalflake_hackathon/utils/constants.dart';
import 'package:digitalflake_hackathon/utils/navigator_utils.dart';
import 'package:digitalflake_hackathon/view_models/slot_view_model.dart';
import 'package:digitalflake_hackathon/views/book_desk_view/book_desk.dart';
import 'package:digitalflake_hackathon/views/book_desk_view/book_rooms.dart';
import 'package:digitalflake_hackathon/views/common_widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:horizontal_center_date_picker/date_item.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';

class SlotScreen extends StatefulWidget {
  final WorkspaceType workspaceType;
  const SlotScreen({super.key, required this.workspaceType});

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  final DatePickerController _datePickerController = DatePickerController();
  SlotViewModel slotViewModel = SlotViewModel();
  late Future getSlots;
  late SlotBookingForm slotBookingForm;
  @override
  void initState() {
    slotBookingForm =  SlotBookingForm(workspaceType: widget.workspaceType);
    getSlots =  slotViewModel.getSlots(context,slotBookingForm.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
       backgroundColor: Colors.white,
       leading: const BackButton(color: Colors.black),
       title: Text('Select Date & slot',style: Theme.of(context).textTheme.headline5,),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HorizontalDatePickerWidget(
              startDate: slotBookingForm.date, 
              endDate: slotBookingForm.date.add(const Duration(days: 90)),
              selectedDate: slotBookingForm.date, 
              widgetWidth: MediaQuery.of(context).size.width,
              datePickerController: _datePickerController,
              selectedColor: Constants.primaryColor,
              dateItemComponentList: const [
                DateItem.WeekDay,
                DateItem.Day,
                DateItem.Month
              ],
              onValueSelected: ((dateTime) {
                  slotBookingForm.date = dateTime;
                  slotViewModel.getSlots(context,dateTime);
              }),
            ),
          ),
          FutureBuilder(
                future: getSlots ,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return StoreConnector<List<SlotData>,List<SlotData>>(
                        builder: ((context, List<SlotData> slotsData) {
                          return Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Wrap(
                                children: [
                                  for(SlotData slot in slotsData)
                                  GestureDetector(
                                    onTap: () {
                                      if(slot.slotActive) {
                                        slotBookingForm.slot = slot;
                                        setState(() {},);
                                      }
                                      else {
                                        BasicUtils.showSnackBar(context, 'This slot is unavailable', SnackBarType.ERROR);
                                      }
                                     
                                    },
                                    child: Container(
                                          margin: const EdgeInsets.only(bottom: 8.0,left:5.0,right:5.0),
                                          width: MediaQuery.of(context).size.width * 0.45,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: slotBookingForm.slot?.slotId == slot.slotId ? Constants.selectedColor 
                                            : slot.slotActive ? Constants.activeColor
                                            : Constants.disableColor,
                                            borderRadius: BorderRadius.circular(4)
                                          ),
                                          child: Center(
                                            child: Text(slot.slotName,style: TextStyle(
                                              color: (slotBookingForm.slot?.slotId != null && slotBookingForm.slot!.slotId == slot.slotId) 
                                              || slot.slotActive ? Colors.white : Colors.black
                                            ),),
                                          )),
                                  ),
                                ],
                              ),
                            ),
                          );
                      }), converter: (store) => store.state,);
              },),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButtonWidget(
                      onPressed: slotBookingForm.slot == null ? null : () async {
                        if(ReduxStore.selectedWorkSpaceStore.state == WorkspaceType.DESKS) {
                          NavigatorUtils.navigate(context, BookDesk(slotBookingForm: slotBookingForm,));
                        }
                        else {
                          NavigatorUtils.navigate(context, BookRoom(slotBookingForm: slotBookingForm,));
                        }
                        
                    }, child: const Text('Next'))
              )

        ],
      ),
    );
  }
}