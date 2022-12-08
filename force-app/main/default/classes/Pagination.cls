public with sharing class Pagination {

    public Integer recordsPerPage = 10;
    public Integer currentPageNumber = 1;
    public Integer pages;
    public Integer recordsPerCurrentPage;
    public Integer offset = 0;
    public Integer allRecords;

    public void setRecordsCount(Integer recordsCount) {
        allRecords = recordsCount;
        recalc();
    }

    public void recalc() {
        pages = ((Decimal)allRecords / recordsPerPage).round(RoundingMode.UP).intValue();
        if (currentPageNumber > pages) currentPageNumber = 1;
        offset = (currentPageNumber - 1) * recordsPerPage;
    }

}