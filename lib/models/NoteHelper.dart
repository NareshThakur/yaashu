
import 'package:refnotes/models/NoteItemModel.dart';

class NoteHelper {

  static var chatList = [
    NoteItemModel("Note 1 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to", "20 June 2020", "10:10 PM"),
    NoteItemModel("Note 2 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to", "02 May 2020", "10:10 PM"),
    NoteItemModel("Note 3 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to", "15 Apr 2020", "10:10 PM"),
    NoteItemModel("Note 4 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to", "31 Jan 2020", "10:10 PM"),
    NoteItemModel("Note 5 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to", "15 Dec 2019", "10:10 PM"),
  ];

  static NoteItemModel getNoteItem(int position) {
    return chatList[position];
  }

  static var itemCount = chatList.length;

}
