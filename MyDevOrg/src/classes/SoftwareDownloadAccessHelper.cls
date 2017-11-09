public class SoftwareDownloadAccessHelper {
    public void provideSoftwareDownloadAccess(list<Asset> lstAsset){
        if(Trigger.isInsert){
            
            //Map of Oracle Customer No and Software Download Record
            map<integer,Software_Download__c> mapSoftwareDownload = new map<integer,Software_Download__c>();
            
            //SOQL to fetch software download records
            list<Software_Download__c> lstSWDownload = [SELECT id, Name, Account__c, Oracle_Customer_Number__c, Product_Line__c,End_Date__c FROM Software_Download__c];
            if(!lstSWDownload.isEmpty()){
                for(Software_Download__c sd : lstSWDownload){
                    if(mapSoftwareDownload.containsKey(integer.valueOf(sd.Oracle_Customer_Number__c))){
                        System.debug('$%$%$%$ Id already in Map.... %$%$%$%$');
                    }//End of IF
                    else{
                        mapSoftwareDownload.put(integer.valueOf(sd.Oracle_Customer_Number__c),sd);
                    }//End of Else
                }//End of FOR
                if(!mapSoftwareDownload.isEmpty()){
                    for(Asset ast : lstAsset){
                        if(mapSoftwareDownload.containsKey(integer.valueOf(ast.Oracle_Customer_Number__c))){
                            Software_Download__c sdl = mapSoftwareDownload.get(integer.valueOf(ast.Oracle_Customer_Number__c));
                            if(ast.Oracle_Customer_Number__c == sdl.Oracle_Customer_Number__c && 
                              ast.Product2.Family == sdl.Product_Line__c &&
                              ast.UsageEndDate <= sdl.End_Date__c){
                                continue;
                            }//End of inner If
                            else if(ast.UsageEndDate > sdl.End_Date__c){
                                ast.AddError('Access already provided...');
                            }
                            else{
                                ast.AddError('Conditions don\'t match....Can\'t insert asset.....');
                            }
                        }//End of IF - ContainsKey
                    }//End of for - Asset
                }
                
            }//End of IF
            
        }//End of if(Trigger.isInsert)
    }//End of method 'provideSoftwareDownloadAccess'
}//End of Class