trigger TestTriggerOnAccnt on Account (before insert,before update) {
    For(Account a: Trigger.New){
        //if(a.createdDate == Date.TODAY()){
			//a.Active__c = 'Yes';            
			System.debug(a.CreatedDate);
        //}
    }
}