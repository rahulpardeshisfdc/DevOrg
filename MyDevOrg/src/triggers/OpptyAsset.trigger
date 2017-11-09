trigger OpptyAsset on Opportunity (after insert,after update) {
    for(Opportunity O:trigger.new)
    {
    
    }
    system.debug('%%%%%%%%%%%%%%% In After insert Trigger %%%%%%%%%%%%%%%%');
}