/**@@
#TRIGGER NAME          :    QuoteLineTrigger
#HANDLER CLASS NAME    :    QuoteLineTriggerHandler
#HELPER CLASS NAME     :    QuoteLineTriggerHelper
#TEST CLASS            :    
#DESCRIPTION           :    This Trigger will handles all the trigger events and make call to the Handler class to handling the appropriate logic.   
@@**/

public class QuoteLineTriggerHelper {

    public static void PopulateProductDescriptionForQuoteTerms(List<SBQQ__QuoteLine__c> newRecords){
        
        map<id,Product2> mapOfProductIdsAndProducts = new map<id,Product2>();
        set<id> QLIProductIds = new set<id>();
        
        //Populating the set of ProductIds
        for(SBQQ__QuoteLine__c qli: newRecords){
            if(qli.SBQQ__Product__c != null && (qli.Product_Grouping_Type__c ==null || qli.Product_Descriptions_for_Quote_Terms__c == null)){
                QLIProductIds.add(qli.SBQQ__Product__c);
            }//End of IF
        }//End of FOR
        
        if(!QLIProductIds.isEmpty()){
            mapOfProductIdsAndProducts = new map<id,Product2>([SELECT id,Name,Grouping_Type__c ,Product_Descriptions_for_Quote_Terms__c FROM Product2 WHERE id IN : QLIProductIds]);
            
            if(!mapOfProductIdsAndProducts.isEmpty()){
                for(SBQQ__QuoteLine__c qt: newRecords){
                    if(qt.Product_Descriptions_for_Quote_Terms__c == null && mapOfProductIdsAndProducts.ContainsKey(qt.SBQQ__Product__c)){
                        qt.Product_Descriptions_for_Quote_Terms__c = mapOfProductIdsAndProducts.get(qt.SBQQ__Product__c).Product_Descriptions_for_Quote_Terms__c;
                    }//End of IF
                 
                    //get the Products grouping type into quote lines grouping type
                    if(mapOfProductIdsAndProducts.ContainsKey(qt.SBQQ__Product__c))
                        qt.Product_Grouping_Type__c = mapOfProductIdsAndProducts.get(qt.SBQQ__Product__c).Grouping_Type__c; 
                     
                }//End of FOR
            }//End of IF
        }//End of IF
        
    }//End of method PopulateProductDescriptionForQuoteTerms()
}//End of Class QuoteLineTriggerHelper