/**
 * Created by YuryNistratau on 08.12.2022.
 */

public with sharing class Filter_Contact implements Filter {

    @AuraEnabled public String searchString;
    @AuraEnabled public String minAge;
    @AuraEnabled public String maxAge;

    public List<String> getFields() {
        return new List<String>{
                Contact.FirstName + '',
                Contact.LastName + '',
                Contact.Current_age__c + ''
        };
    }

    public String getFilterString() {
        if (String.isEmpty(minAge)) minAge = '0';
        if (String.isEmpty(maxAge)) maxAge = '100';
        return '(FirstName LIKE \'%' + searchString + '%\' ' +
                'OR LastName LIKE \'%' + searchString + '%\')' +
                ' AND (Current_age__c < ' + maxAge +
                ' AND Current_age__c > ' + minAge + ')';
    }

    public SObjectType getSObjectType() {
        return Contact.getSObjectType();
    }
}