/**
 * Created by YuryNistratau on 09.12.2022.
 */

import {LightningElement, track} from 'lwc';
import getRecords from '@salesforce/apex/RecordsManagerController.getRecords';
import getInitData from '@salesforce/apex/RecordsManagerController.getInitData';

export default class recordsManager extends LightningElement {

    @track columns;
    @track records;
    @track filter;
    @track pagination;
    @track initialized = false;
    @track showSpinner = false;

    handleFilterChange(event) {
        this.filter = event.detail;
        this.getData();
    }

    handlePaginationChange(event) {
        this.pagination = event.detail;
        this.getData();
    }

    connectedCallback() {
        this.init();
    }

    init() {
        this.showSpinner = true;
        getInitData().
        then(initData => {
            this.filter = initData.filter;
            this.pagination = initData.searchResponse.pagination;
            this.records = initData.searchResponse.records;
            this.columns = initData.columns;
            this.initialized = true;
            this.showSpinner = false;
        })
    }

    getData() {
        this.showSpinner = true;
        getRecords({filterStr: JSON.stringify(this.filter), paginationStr: JSON.stringify(this.pagination)})
            .then(result => {
                this.pagination = result.pagination;
                this.records = result.records;
                this.showSpinner = false;
            })
            .catch(error => {
                console.log('error ' + error.message);
            });
    }
}