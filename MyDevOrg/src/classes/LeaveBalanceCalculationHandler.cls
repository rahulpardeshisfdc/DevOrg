public class LeaveBalanceCalculationHandler {
    public void LeaveBalanceCalculatorHelperCall(list<Leave_Application__c> lstLeaves,Map<id,Leave_Application__c> TrigoldMap){
        LeaveBalanceCalculationHelper leaveHelper = new LeaveBalanceCalculationHelper();
        if(Trigger.isBefore){
            leaveHelper.LeaveCalculator(lstLeaves,TrigoldMap);
        }
        else if(Trigger.isAfter){
            leaveHelper.LeaveCalculator(lstLeaves,TrigoldMap);
        }
    }
}