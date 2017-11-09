public class LeaveBalanceCalculationHelper {
    public void LeaveCalculator(list<Leave_Application__c> lstLeaves,Map<id,Leave_Application__c> mapLeaveApplicationOld){
        System.debug('%%%%%%%%%% lstLeaves : '+lstLeaves);
         
            set<id> conIds = new set<id>();
            for(Leave_Application__c l : lstLeaves){
                if(Trigger.IsUpdate){
                    if(mapLeaveApplicationOld.containsKey(l.Id)){
                        Leave_Application__c Old = mapLeaveApplicationOld.get(l.Id);
                            if(l.Contact__c != Null && l.Start_Date__c != Null && l.End_Date__c != Null && (l.Contact__c != old.Contact__c || l.Start_Date__c != old.Start_Date__c || l.End_Date__c != old.End_Date__c)){
                                conIds.add(l.Contact__c);
                            }
                    }
                }
                else if(Trigger.IsInsert){
                    if(l.Contact__c != Null && l.Start_Date__c != Null && l.End_Date__c != Null){
					conIds.add(l.Contact__c);
					}
                }
            }
            
            System.debug('############ conIds : '+conIds);
        	Map<id,Contact> mapConId = new Map<id,Contact>();
        	If(conIds != null){
                for(Contact c: [Select id, Leave_Balance__c FROM Contact WHERE Id IN: conIds]){
                    if(mapConId.containsKey(c.id)){
                        System.debug('$%$%$%$ Id already in Map.... %$%$%$%$');
                    }
                    else{
                        mapConId.put(c.Id,c);
                    }
                }
                System.debug('?????????????????? mapConId : '+mapConId); 
            }
			Boolean flag = False;
            if(Trigger.isInsert || Trigger.isUpdate){
 
                List<Contact> lstContactsTobeUpdated = new list<Contact>();
                if(!lstLeaves.isEmpty()){
					for(Leave_Application__c lc : lstLeaves){
                        if(Trigger.IsUpdate){
                            if(mapLeaveApplicationOld.containsKey(lc.Id)){
                                Leave_Application__c leaveOld = mapLeaveApplicationOld.get(lc.Id);
                                if(lc.Contact__c != Null && lc.Start_Date__c != Null && lc.End_Date__c != Null && (lc.Contact__c != leaveOld.Contact__c || lc.Start_Date__c != leaveOld.Start_Date__c || lc.End_Date__c != leaveOld.End_Date__c)){
                                    flag = True;
                                }
                            }
                        }
						if((lc.Contact__c != Null && lc.Start_Date__c != Null && lc.End_Date__c != Null) || flag == True){
							System.Debug('@#@#@#@#@ Flag:..... '+flag);
							integer LeaveDuration = lc.Start_Date__c.daysBetween(lc.End_Date__c);
							
							System.debug('********* LeaveDifference: '+LeaveDuration);
							
							if(mapConId.containsKey(lc.Contact__c)){
								System.debug('Inside IF..........Key : '+mapConId.containsKey(lc.Contact__c));
								
								integer lb = integer.valueOf(mapConId.get(lc.Contact__c).Leave_Balance__c);
								System.debug('$$$$$$ Value of LeaveBalance from Contact : '+lb);
								if(lb >= LeaveDuration){
									System.debug('@@@@@@@@@@@ Inside Inner IF.......lb > LeaveDuration@@@@@@@@@');
									contact conRec = mapConId.get(lc.Contact__c);
									conRec.Leave_Balance__c  = lb - LeaveDuration;
									System.debug('&&&&&&&&&& Subtraction from Contact and Leave Application : '+conRec.Leave_Balance__c);
									lstContactsTobeUpdated.add(conRec);
								}
								else {
									lc.AddError('You Don\'t have sufficient Leave Balance...Sorry...You can\'t apply for leaves...');
								}
							}
						}                
					}
					System.debug('^^^^^^^^^ lstContactsTobeUpdated: '+lstContactsTobeUpdated);
					if(!lstContactsTobeUpdated.isEmpty()){
						update lstContactsTobeUpdated;
					}
				}
        }

		}
}