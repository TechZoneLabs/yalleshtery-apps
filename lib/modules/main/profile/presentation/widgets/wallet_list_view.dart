import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../app/utils/strings_manager.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text(AppStrings.noDataToShow.tr()))],
    )
        // Expanded(
        //         child: ListView(
        //           padding: const EdgeInsets.all(8),
        //           children: [
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.primary2,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             const Divider(
        //               height: 20,
        //               thickness: 1,
        //               indent: 20,
        //               endIndent: 20,
        //               color: Colors.grey,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.primary2,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             const Divider(
        //               height: 20,
        //               thickness: 1,
        //               indent: 20,
        //               endIndent: 20,
        //               color: Colors.grey,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.kRed,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             const Divider(
        //               height: 20,
        //               thickness: 1,
        //               indent: 20,
        //               endIndent: 20,
        //               color: Colors.grey,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.kRed,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             const Divider(
        //               height: 20,
        //               thickness: 1,
        //               indent: 20,
        //               endIndent: 20,
        //               color: Colors.grey,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.kRed,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             const Divider(
        //               height: 20,
        //               thickness: 1,
        //               indent: 20,
        //               endIndent: 20,
        //               color: Colors.grey,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.kRed,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             const Divider(
        //               height: 20,
        //               thickness: 1,
        //               indent: 20,
        //               endIndent: 20,
        //               color: Colors.grey,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.kRed,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             const Divider(
        //               height: 20,
        //               thickness: 1,
        //               indent: 20,
        //               endIndent: 20,
        //               color: Colors.grey,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.kRed,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),
        //             ),
        //              const Divider(
        //               height: 20,
        //               thickness: 1,
        //               indent: 20,
        //               endIndent: 20,
        //               color: Colors.grey,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     children: const [
        //                       Text('2 hours ago'),
        //                       Text(
        //                         'SENT',
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, color: Colors.red),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     height: 40,
        //                     width: 90,
        //                     color: ColorManager.kRed,
        //                     child: const Center(
        //                         child: Text('50 LE',
        //                             style: TextStyle(color: Colors.white))),
        //                   )
        //                 ],
        //               ),

        //             ),
        //           ],
        //         ),
        //       )
        ;
  }
}
