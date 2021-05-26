class Note{
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  Note(this._title,this._date,this._priority,[this._description]);

  Note.withId(this._id,this._title,this._date,this._priority,[this._description]);

  int get id=>_id;
  String get title=>_title;
  set title(String newTitle){
    if(newTitle.length<255){
      this._title=newTitle;
    }
  }
  String get description=>_description;
  set description(String newDescription){
    if(newDescription.length<255){
      this._description=newDescription;
    }
  }
  String get date=>_date;
  set date(String newDate){
    if(newDate.length<25){
      this._date=newDate;
    }
  }

  int get priority=>_priority;
  set priority(int newPriority){
    if(newPriority<=2&&newPriority>=1){
      this._priority=newPriority;
    }
  }

  //convert to map
  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    if(id!=null){
      map['id']=_id;
    }
    map['title']=_title;
    map['description']=_description;
    map['priority']=_priority;
    map['date']=_date;
    return map;
  }

  //convert to note
  Note.fromMapObject(Map<String,dynamic> map){
    this._id=map['id'];
    this._title=map['title'];
    this._description=map['description'];
    this._priority=map['priority'];
    this._date=map['date'];

  }

}