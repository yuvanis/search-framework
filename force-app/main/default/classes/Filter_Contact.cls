/**
 * Created by YuryNistratau on 08.12.2022.
 */

public with sharing class Filter_Contact implements Filter {

    @AuraEnabled public String searchString;
    @AuraEnabled public String minAge;
    @AuraEnabled public String maxAge;
    @AuraEnabled public String sortedField;

    public List<String> getFields() {
        return new List<String>{
                Contact.FirstName + '',
                Contact.LastName + '',
                Contact.Current_age__c + ''
        };
    }

    public String getFilterString() {
        List<String> filterItems = new List<String>();
        filterItems.add('(FirstName LIKE \'%' + searchString + '%\' ' + 'OR LastName LIKE \'%' + searchString + '%\')');
        if (!String.isEmpty(minAge)) filterItems.add('Current_age__c > ' + minAge);
        if (!String.isEmpty(maxAge)) filterItems.add('Current_age__c < ' + maxAge);
        return String.join(filterItems, ' AND ');
    }

    public String getOrderByString() {
        return sortedField;
    }

    public SObjectType getSObjectType() {
        return Contact.getSObjectType();
    }
}