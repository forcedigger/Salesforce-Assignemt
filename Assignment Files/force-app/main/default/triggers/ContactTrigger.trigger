/*
 * 
 * Assumption 1: No action will taken if account's Industry is changed as per requirement 
 * 				[Account_Industry__c field only populated on contact record created or updated]. 
 * 
 * 
*/
trigger ContactTrigger on Contact (before insert, before update) {
    //have handler in place to divert the call
    switch on trigger.operationType {
        when BEFORE_INSERT {
            contactTriggerHandler.beforeInsert(trigger.new);
        }
        when BEFORE_UPDATE {
            contactTriggerHandler.beforeUpdate(trigger.new, trigger.oldMap);
        }
    }

}