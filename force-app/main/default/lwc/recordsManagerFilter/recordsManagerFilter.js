/**
 * Created by YuryNistratau on 09.12.2022.
 */

import {api, LightningElement} from 'lwc';

export default class RecordsManagerFilter extends LightningElement {

    @api filter;

    handleValue(evt) {
        const newFilter = JSON.parse(JSON.stringify(this.filter));
        newFilter.searchString = evt.target.value;
        this.filterChange(newFilter);
    }

    handleMinAge(evt) {
        const newFilter = JSON.parse(JSON.stringify(this.filter));
        newFilter.minAge = evt.target.value;
        this.filterChange(newFilter);
    }

    handleMaxAge(evt) {
        const newFilter = JSON.parse(JSON.stringify(this.filter));
        newFilter.maxAge = evt.target.value;
        this.filterChange(newFilter);
    }

    filterChange(newFilter) {
        this.dispatchEvent(new CustomEvent('filterchange', {
                detail: newFilter
            }
        ));
    }
}


