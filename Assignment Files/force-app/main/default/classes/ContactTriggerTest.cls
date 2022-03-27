@isTest
private class ContactTriggerTest {
    
    private static id createAccount(string name, string Ind) {
        account a = new account();
        a.Name = name;
        a.Industry = Ind;
        insert a;
        return a.Id;
    }
	//TestCase1: Create new contact and verify if account_Industry is populated
    static testMethod void newContactTestCase1() {
        id accId = createAccount('Test', 'Manufacturing');
        
        test.startTest();
        contact c = new contact();
        c.AccountId = accId;
        c.FirstName = 'fName';
        c.LastName = 'lName';
        insert c;
        test.stopTest();
        //verify contact has account_industry__c populated as same as account
        contact con = [select id, Account_Industry__c from contact where id = : c.Id];
        system.assertEquals('Manufacturing', con.Account_Industry__c);
        
    }
    
    //TestCase2: update existing contact with different account and verify if correct account_Industry is populated
    static testMethod void updateContactTestCase2() {
        id accId = createAccount('Test', 'Clothing');
        id accId2 = createAccount('Test', 'Finance');
        test.startTest();
        contact c = new contact();
        c.AccountId = accId;
        c.FirstName = 'fName';
        c.LastName = 'lName';
        insert c;
        //Update to different Account to verify the change in the industry
        c.AccountId = accId2;
        update c;
        test.stopTest();
        //verify contact has account_industry__c populated as same as account
        contact con = [select id, Account_Industry__c from contact where id = : c.Id];
        system.assertEquals('Finance', con.Account_Industry__c);
        
    }
    
    //TestCase3: update existing contact with different account Industry than it's account's and verify if correct account_Industry is populated
    static testMethod void updateContactTestCase3() {
        id accId = createAccount('Test', 'Clothing');
        
        test.startTest();
        contact c = new contact();
        c.AccountId = accId;
        c.FirstName = 'fName';
        c.LastName = 'lName';
        insert c;
        //Update Account_Industry__c to verify to override with account's value
        c.Account_Industry__c = 'NO Valid';
        update c;
        test.stopTest();
        //verify contact has account_industry__c is populated with 'Clothing' and not 'NO Valid'
        contact con = [select id, Account_Industry__c from contact where id = : c.Id];
        system.assertEquals('Clothing', con.Account_Industry__c);
        
    }
}