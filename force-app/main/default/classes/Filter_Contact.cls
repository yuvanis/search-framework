/**
 * Created by YuryNistratau on 08.12.2022.
 */

public with sharing class Filter_Contact implements Filter{

    public String searchString = '';
    public Integer minAge;
    public Integer maxAge;
    public List<String> getFields() {
        return new List<String>{
            Contact.FirstName + '', Contact.LastName + ''
        };
    }

    public String getFilterString() {
        if (String.isEmpty(searchString)) return null;
        return 'FirstName LIKE \'%' + searchString + '%\' OR LastName LIKE \'%' + searchString + '%\'';
    }

    public SObjectType getSObjectType() {
        return Contact.getSObjectType();
    }
}