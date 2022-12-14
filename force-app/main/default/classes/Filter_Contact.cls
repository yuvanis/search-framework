/**
 * Created by YuryNistratau on 08.12.2022.
 */

public with sharing class Filter_Contact implements Filter {

    @AuraEnabled public String searchString = '';
    @AuraEnabled public String minAge = '20';
    @AuraEnabled public String maxAge = '30';

    public List<String> getFields() {
        return new List<String>{
                Contact.FirstName + '',
                Contact.LastName + '',
                Contact.Current_age__c + ''
        };
    }

    public String getFilterString() {
        if (String.isEmpty(searchString)) return null;
        return '(FirstName LIKE \'%' + searchString + '%\' OR LastName LIKE \'%'
                + searchString + '%\')';
    }

    public SObjectType getSObjectType() {
        return Contact.getSObjectType();
    }
}