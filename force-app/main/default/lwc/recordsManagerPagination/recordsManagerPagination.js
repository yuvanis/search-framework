/**
 * Created by YuryNistratau on 09.12.2022.
 */

import {api, LightningElement} from 'lwc';

export default class RecordsManagerPagination extends LightningElement {

    @api pagination = {};

    nextPage() {
        const newPagination = this.clonePagination();
        if (newPagination.currentPageNumber < newPagination.pages) {
            newPagination.currentPageNumber += 1;
            this.fireChange(newPagination);
        }
    }

    previousPage() {
        const newPagination = this.clonePagination();
        if (newPagination.currentPageNumber > 1) {
            newPagination.currentPageNumber -= 1;
            this.fireChange(newPagination);
        }
    }

    firstPage() {
        const newPagination = this.clonePagination();
        newPagination.currentPageNumber = 1;
        this.fireChange(newPagination);    }

    lastPage() {
        const newPagination = this.clonePagination();
        newPagination.currentPageNumber = newPagination.pages;
        this.fireChange(newPagination);
    }

    fireChange(pagination) {
        this.dispatchEvent(new CustomEvent('change', {
            detail: pagination
        }));
    }

    clonePagination() {
        return JSON.parse(JSON.stringify(this.pagination));
    }
}