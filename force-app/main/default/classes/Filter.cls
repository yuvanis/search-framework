/**
 * Created by YuryNistratau on 08.12.2022.
 */

public interface Filter {

    List<String> getFields();
    String getFilterString();
    SObjectType getSObjectType();
}