trigger LeaveBalanceCalculation on Leave_Application__c (before insert, before update) {
	LeaveBalanceCalculationHandler lbc = new LeaveBalanceCalculationHandler();
    lbc.LeaveBalanceCalculatorHelperCall(Trigger.new,Trigger.oldMap);
}