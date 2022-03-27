public class ContactTriggerHelper {
	
    /* DESC: Copy account.Industry field to contact custom field
     	@contacts : list of contacts created/updated
    	@oldContactMap: null for before and After Insert trigger calls
	*/
    public static void copyAccountIndustrytoContact(list<contact> contacts, map<id, contact> oldContactMap) {
        set<id> accountIds = new set<id>();
        
        //Collect all accountIds to get the related account's Industry
        for(contact c:contacts) {
            accountIds.add(c.AccountId);
        }
        //get account info
        map<Id, account> accountMap = new map<Id, account>([select Id, Industry from account where ID IN: accountIds]);
        
        for(contact c: contacts) {
            //New contacts, Old contact without Account Industries, Contacts updated with different account, contact updated with different account Industry 
            if(accountMap.containsKey(c.AccountId) 
               && ( oldContactMap == null 
               || c.Account_Industry__c == null
               || oldContactMap.get(c.Id).AccountId != c.AccountId
               || oldContactMap.get(c.Id).Account_Industry__c != c.Account_Industry__c )
              ) {
              		c.Account_Industry__c = accountMap.get(c.AccountId).industry;
              }
        }
       
         
    }
}