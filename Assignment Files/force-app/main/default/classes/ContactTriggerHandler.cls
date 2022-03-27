public class ContactTriggerHandler {

    public static void beforeInsert(list<contact> newContacts) {
        ContactTriggerHelper.copyAccountIndustrytoContact(newContacts, null);
    }
    
    public static void beforeUpdate(list<contact> newContacts, map<id, contact> oldContactMap) {
        ContactTriggerHelper.copyAccountIndustrytoContact(newContacts, oldContactMap);
    }
}