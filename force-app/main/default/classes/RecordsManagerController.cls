/**
 * Created by YuryNistratau on 09.12.2022.
 */

public with sharing class RecordsManagerController {

    @AuraEnabled
    public static InitData getInitData() {
        Filter_Contact filter = new Filter_Contact();
        Pagination pagination = new Pagination();
        String filterJSON = Filter_Settings__c.getOrgDefaults().Filter_Value__c;
        if (!String.isEmpty(filterJSON)) {
            filter = (Filter_Contact)JSON.deserialize(filterJSON, Filter_Contact.class);
        }
        return new InitData(filter, SearchService.search(filter, pagination));
    }

    @AuraEnabled
    public static SearchResponse getRecords(String filterStr, String paginationStr) {
        Filter_Settings__c filterJSON = Filter_Settings__c.getOrgDefaults();
        filterJSON.Filter_Value__c = filterStr;
        update filterJSON;
        Filter filter = (Filter_Contact)JSON.deserialize(filterStr, Filter_Contact.class);
        Pagination pagination = (Pagination)JSON.deserialize(paginationStr, Pagination.class);
        return SearchService.search(filter, pagination);
    }

    public class InitData {
        @AuraEnabled public Filter_Contact filter;
        @AuraEnabled public SearchResponse searchResponse;
        @AuraEnabled public List<Map<String, String>> columns = new List<Map<String, String>>();

        public InitData(Filter_Contact filter, SearchResponse searchResponse) {
            this.filter = filter;
            this.searchResponse = searchResponse;
            for (String currentField : filter.getFields()) {
                columns.add(new Map<String, String>{
                        'label' => Contact.getSObjectType().getDescribe().fields.getMap().get(currentField).getDescribe().getLabel(),
                        'fieldName' => currentField
                });
            }
        }
    }

}