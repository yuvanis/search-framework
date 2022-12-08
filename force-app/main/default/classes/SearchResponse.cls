/**
 * Created by YuryNistratau on 08.12.2022.
 */

public with sharing class SearchResponse {

    public List<SObject> records;
    public Pagination pagination;

    public SearchResponse(List<SObject> records, Pagination pagination) {
        this.records = records;
        this.pagination = pagination;
    }
}