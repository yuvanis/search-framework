/**
 * Created by Yury Nistratau on 09.12.2022.
 */

public with sharing class Pagination {
    @AuraEnabled public Integer recordsPerPage = 10;
    @AuraEnabled public Integer currentPageNumber = 1;
    @AuraEnabled public Integer pages = 1;
    @AuraEnabled public Integer offset = 0;
    @AuraEnabled public Integer allRecords;

    public void setRecordsCount(Integer recordsCount) {
        allRecords = recordsCount;
        recalc();
    }

    public void recalc() {
        pages = ((Decimal) allRecords / recordsPerPage)
            .round(RoundingMode.UP)
            .intValue();
        if (currentPageNumber > pages) currentPageNumber = 1;
        offset = (currentPageNumber - 1) * recordsPerPage;
    }
}
