import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/utils/constants.dart';
import 'package:digitalflake_hackathon/utils/navigator_utils.dart';
import 'package:digitalflake_hackathon/view_models/home_view_model.dart';
import 'package:digitalflake_hackathon/views/booking_history_view/booking_history.dart';
import 'package:digitalflake_hackathon/views/common_widgets/elevated_button_widget.dart';
import 'package:digitalflake_hackathon/views/slot_screen_view/slot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/df_icon.png'),
                      Text('Co-working',style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButtonWidget(
                      size: const Size(140,42),
                      onPressed: () async{
                         NavigatorUtils.navigate(context, const BookingHistory());
                    }, child: const Text('Booking history')),
                  )
                ],
              ),
            ),
            StoreConnector<WorkspaceType,WorkspaceType>(
              converter: (store) => store.state,
              builder: (context, WorkspaceType workspaceType) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //* WORK STATION 
                      GestureDetector(
                        onTap: () {
                          homeViewModel.changeWorkspace(WorkspaceType.DESKS);
                          NavigatorUtils.navigate(context, const SlotScreen(workspaceType: WorkspaceType.DESKS));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                color: workspaceType == WorkspaceType.DESKS ? Constants.primaryColor : Constants.primaryColor.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Image.asset('assets/images/workstation.png',),
                            ),
                            SizedBox(
                              width: 130,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Boook Work Station',style: Theme.of(context).textTheme.headline6,),
                              ),
                            )
                          ],
                        ),
                      ),
            
                      //*MEETING ROOM 
                      GestureDetector(
                        onTap: (){
                          homeViewModel.changeWorkspace(WorkspaceType.MeetingRooms);
                          NavigatorUtils.navigate(context, const SlotScreen(workspaceType: WorkspaceType.MeetingRooms));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                color: workspaceType == WorkspaceType.MeetingRooms ? Constants.primaryColor : Constants.primaryColor.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Image.asset('assets/images/meeting.png',),
                            ),
                            SizedBox(
                              width: 130,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Meeting Room',style: Theme.of(context).textTheme.headline6,),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}