

import 'package:refnotes/models/StatusItemModel.dart';

class StatusHelper {

  static var statusList = [StatusItemModel("Title of article", "Excerpt goes here", "11:21 PM", "10 June 20"), StatusItemModel("Another title", "Excerpt goes here", "10:22 PM", "10 June 20")];

  static StatusItemModel getStatusItem(int position) {
    return statusList[position];
  }

  static var itemCount = statusList.length;

}
