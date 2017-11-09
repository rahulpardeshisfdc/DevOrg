trigger tracktask on Task (after insert, after update) {
if(trigger.isInsert){
    for(task t1: trigger.new){
        string userID = t1.OwnerId;
        List<taskTracking__c> trackrecord1 = database.query('select id, task_owner__c, openTask__c, closedTask__c from taskTracking__c where task_owner__c=:userID');
          
            if(trackrecord1.size() == 0){
                taskTracking__c insert1 = new taskTracking__c();
                insert1.task_owner__c = userID;
                if(t1.Status != 'Completed'){
                    insert1.openTask__c = 1;
                }
                else{
                    insert1.closedTask__c = 1;
                }
                insert insert1;
            }else{
                String track_id = trackrecord1[0].id;
                system.debug(trackrecord1);
                system.debug(trackrecord1[0].openTask__c);
                taskTracking__c update1 = new taskTracking__c(id=track_id);
                update1.task_owner__c = userID;
                if(t1.Status != 'Completed'){
                    update1.openTask__c = integer.valueof(trackrecord1[0].openTask__c)+1;
                }
                else{
                    update1.closedTask__c = integer.valueof(trackrecord1[0].closedTask__c)+1;
                }
                update update1;
            }
    }
}


if(trigger.isupdate){
    for(task t2: trigger.new){
        string userID = t2.OwnerId;
        List<taskTracking__c> trackrecord2 = database.query('select id, task_owner__c, openTask__c, closedTask__c from taskTracking__c where task_owner__c=:userID');
          system.debug(trackrecord2 );
          system.debug(trackrecord2[0].id);
            if(trackrecord2.size() == 0){
                taskTracking__c insert1 = new taskTracking__c();
                insert1.task_owner__c = userID;
                if(t2.Status != 'Completed'){
                    insert1.openTask__c = 1;
                }
                else{
                    insert1.closedTask__c = 1;
                }
                insert insert1;
            }else{
                String track_id = trackrecord2[0].id;
                taskTracking__c update1 = new taskTracking__c(id=track_id);
                update1.task_owner__c = userID;
                system.debug(trackrecord2[0]);
                if(t2.Status != 'Completed'){
                    update1.openTask__c = integer.valueof(trackrecord2[0].openTask__c)+1;
                }
                else{
                    update1.closedTask__c = integer.valueof(trackrecord2[0].closedTask__c) + 1;
                    update1.openTask__c = integer.valueof(trackrecord2[0].openTask__c)-1;
                }
                update update1;
            }
    }
}
}