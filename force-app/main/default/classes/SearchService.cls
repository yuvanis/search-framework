/**
 * Created by YuryNistratau on 08.12.2022.
 */

public with sharing class SearchService {
    public static SearchResponse search(Filter filter, Pagination pagination) {
        String whereClause = String.isEmpty(filter.getFilterString()) ? '' : ' WHERE ' + filter.getFilterString();
        String countQuery = 'SELECT Count() FROM ' + filter.getSObjectType() + whereClause;
        Integer allRecordsCount = Database.countQuery(countQuery);
        pagination.setRecordsCount(allRecordsCount);
        String queryStr = 'SELECT ' + String.join(filter.getFields(), ',') +
                ' FROM ' + filter.getSObjectType() +
                whereClause +
                ' LIMIT ' + pagination.recordsPerPage +
                ' OFFSET ' + pagination.offset;
        List<SObject> records = Database.query(queryStr);

        return new SearchResponse(records, pagination);
    }

}