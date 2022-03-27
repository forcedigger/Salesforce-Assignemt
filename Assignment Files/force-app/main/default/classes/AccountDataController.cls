public with sharing class AccountDataController {

    //Per requirement, return 5 accounts to LWC component when called.
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account LIMIT 5 ];
    }

    //called on NEXT button click with Selected account ID as param
    @AuraEnabled(cacheable=true)
    public static Account getAccountDetail(string accId) {
        System.debug(accId);
        list<Account> a = [SELECT Id, Name, Industry, Type, Owner.Name, Owner.SmallPhotoUrl 
                            FROM Account 
                            WHERE Id =: accId 
                            WITH SECURITY_ENFORCED];
        return a[0];
    }

}