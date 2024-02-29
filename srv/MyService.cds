using { anubhav.db.master } from '../db/datamodel';

//this is the definition of a service
//the implementation is written in a JS file with name-equality

service MyService @(path: 'MyService') {

    function hello(name: String) returns String;

    @readonly
    entity ReadEmployeeSrv as projection on master.employees;

}
