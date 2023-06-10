import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/models/booking_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/view_models/booking_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hexcolor/hexcolor.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  BookingHistoryViewModel bookingHistoryViewModel = BookingHistoryViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       elevation: 0,
       backgroundColor: Colors.white,
       leading: const BackButton(color: Colors.black),
       title: Text('Booking History',style: Theme.of(context).textTheme.headline5,),
      ),

      body: FutureBuilder(
        future: bookingHistoryViewModel.getBookingHistory(context),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
             return const Center(
              child: CircularProgressIndicator(),
             );
          }
          return StoreConnector<List<BookingData>,List<BookingData>>(
            converter: (store) => store.state,
            builder: (context, List<BookingData> bookingHistory) {
              return ListView.builder(
                itemCount: bookingHistory.length,
                itemBuilder: (context,index) {
                 return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: HexColor('#F5F7FF'),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children: [
                     ReduxStore.selectedWorkSpaceStore.state == WorkspaceType.DESKS ?  Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.26,
                          child: const Text('Desk id: ')),
                        Text(bookingHistory[index].workSpaceId.toString()),
                      ],
                     ) : Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.26,
                          child: const Text('Room id: ')),
                        Text(bookingHistory[index].workSpaceId.toString()),
                      ],
                     ) ,
                     Padding(
                       padding: const EdgeInsets.only(top:8.0),
                       child: Row(
                        children: [
                          SizedBox(
                             width: MediaQuery.of(context).size.width * 0.26,
                            child: const Text('Name: ')),
                          Text(bookingHistory[index].workspaceName),
                        ],
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top:8.0),
                       child: Row(
                        children: [
                          SizedBox(
                             width: MediaQuery.of(context).size.width * 0.26,
                            child: const Text('Booked on: ')),
                          Text(bookingHistory[index].bookingDate),
                        ],
                       ),
                     ),
                  ],
                ),
              );
              });
            }
          );

      },),
    );
  }
}