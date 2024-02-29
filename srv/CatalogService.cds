using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';

service CatalogService @(path: 'CatalogService') {

    @readonly
    entity EmployeeSet as projection on master.employees;
    entity BusinessPartnerSet as projection on master.businesspartner;
    @Capabilities: { Updatable,Deletable : false }
    entity ProductSet as projection on master.product;
    entity AddressSet as projection on master.address;
    entity POs @(
        odata.draft.enabled: true,
        Common.DefaultValuesFunction : 'getOrderDefaults'
    )as projection on transaction.purchaseorder{
        *,
        case OVERALL_STATUS
            when 'P' then 'Paid'
            when 'N' then 'New'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            end as OverallStatus : String(10),
        case OVERALL_STATUS
            when 'P' then 3
            when 'N' then 2
            when 'A' then 3
            when 'X' then 1
            end as Spiderman : Integer,
        Items
    }actions{
        @cds.odata.bindingparameter.name : '_anubhav'
        @Common.SideEffects : {
                TargetProperties : ['_anubhav/GROSS_AMOUNT']
            }  
        action boost();
    };

    function getOrderDefaults() returns POs;
    function largestOrder() returns POs;
    entity PurchaseOrderItems as projection on transaction.poitems;

}
