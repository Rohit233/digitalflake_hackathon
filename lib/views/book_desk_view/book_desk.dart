import 'package:digitalflake_hackathon/enums/snackbar_type_enum.dart';
import 'package:digitalflake_hackathon/models/form_model.dart/slot_booking_form.dart';
import 'package:digitalflake_hackathon/models/workspace_data.dart';
import 'package:digitalflake_hackathon/utils/basic_utils.dart';
import 'package:digitalflake_hackathon/utils/constants.dart';
import 'package:digitalflake_hackathon/utils/date_time_utils.dart';
import 'package:digitalflake_hackathon/utils/navigator_utils.dart';
import 'package:digitalflake_hackathon/view_models/book_desk_view_model.dart';
import 'package:digitalflake_hackathon/views/common_widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BookDesk extends StatefulWidget {
  final SlotBookingForm slotBookingForm;
  const BookDesk({super.key,required this.slotBookingForm});

  @override
  State<BookDesk> createState() => _BookDeskState();
}

class _BookDeskState extends State<BookDesk> {
  BookDeskViewModel bookDeskViewModel = BookDeskViewModel();
  late Future getWorkspaceAvailability;

  @override
  void initState() {
    getWorkspaceAvailability =  bookDeskViewModel.getAvailableWorkspaces(context,widget.slotBookingForm.workspaceType!,widget.slotBookingForm.slot!,widget.slotBookingForm.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       elevation: 0,
       backgroundColor: Colors.white,
       leading: const BackButton(color: Colors.black),
       title: Text('Available desks',style: Theme.of(context).textTheme.headline5,),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('${DateTimeUtils.getFormateDateInString(widget.slotBookingForm.date)}, ${widget.slotBookingForm.slot!.slotName}')),
          ),
          FutureBuilder(
            future: getWorkspaceAvailability,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return StoreConnector<List<WorkspaceData>, List<WorkspaceData>>(
                converter: (store) => store.state,
                builder: (context, List<WorkspaceData> workspaces) {
                  return StatefulBuilder(
                    builder: (context, state) {
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Wrap(
                            children: [
                              for(WorkspaceData workspace in workspaces)
                              GestureDetector(
                                    onTap: (() {
                                      if(workspace.workspaceActive) {
                                        setState((() {
                                          widget.slotBookingForm.workspace = workspace;
                                       }));
                                      }
                                      else {
                                        BasicUtils.showSnackBar(context, 'This desk is unavailable', SnackBarType.ERROR);
                                      }
                                        
                                    }),
                                    child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                            color: widget.slotBookingForm.workspace?.workspaceId == workspace.workspaceId 
                                            ? Constants.selectedColor 
                                            : workspace.workspaceActive ? Constants.activeColor
                                            : Constants.disableColor,
                                            borderRadius: BorderRadius.circular(4)
                                      ),
                                      height: 50,
                                      width: 50,
                                      child: Center(child: Text(workspace.workspaceName,style: TextStyle(
                                                color: (widget.slotBookingForm.workspace?.workspaceId != null && widget.slotBookingForm.workspace!.workspaceId == workspace.workspaceId) 
                                                || workspace.workspaceActive ? Colors.white : Colors.black
                                              ))),
                                    ),
                              ),

                              
                            ],
                          ),
                        ),
                      );
                    }
                  );
                }
              );
            }
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:15.0),
            child: ElevatedButtonWidget(onPressed: widget.slotBookingForm.workspace == null ? null : () async {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      title: Container(
                        padding: const EdgeInsets.only(left: 4.0,bottom: 4.0,top: 4.0),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             const Text('Confirm booking'),
                             IconButton(onPressed: (){
                                NavigatorUtils.navigateBack(context);
                             }, icon: const Icon(Icons.clear))
                          ],
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Text('Desk ID: '),
                                    Text(widget.slotBookingForm.workspace!.workspaceId.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Desk: '),
                                    Text(widget.slotBookingForm.workspace!.workspaceName),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  const Text('Slot: '),
                                  Expanded(child: Text('${DateTimeUtils.getFormateDateInString(widget.slotBookingForm.date)}, ${widget.slotBookingForm.slot!.slotName}')),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0,left:20,right:20),
                              child: ElevatedButtonWidget(onPressed: () async{
                                  await bookDeskViewModel.confirmBooking(
                                    context,
                                    widget.slotBookingForm
                                  );
                                  // ignore: use_build_context_synchronously
                                  NavigatorUtils.navigateBack(context);
                                  // ignore: use_build_context_synchronously
                                  NavigatorUtils.navigateBack(context); 
                                  // ignore: use_build_context_synchronously
                                  NavigatorUtils.navigateBack(context);
                              }, child: const Text('Confirm')),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }, child: const Text('Book Desk')),
          )
        ],
      ),
    );
  }
}