namespace travel_expense_management_system;

type category : String enum {
    Travel;
    Food;
    Hotel;
    Fuel;
}

entity Location {
    key name : String;
}

entity Department {
    key name : String;
}

entity ExpenseType {
    key name : String;
}

entity Employees {
    key ID            : UUID @Core.Computed: true;
        empName       : String;
        email         : String;
        department    : Association to Department;
        designation   : String;
        managerName   : String;
        location      : Association to Location;
        travelRequest : Composition of many TravelRequests
                            on travelRequest.employee = $self;
}

/*
If you want to create records of one entity inside another entity, those two entities should usually be modeled using a parent-child relationship with Composition, not just Association. In that case, the parent side should use Composition of many, while the child side can simply use Association to the parent.” and then the @odata.draft.enabled should not be used with child entity
*/
entity ExpenseCategories {
    key ID              : UUID @Core.Computed: true;
        category        : category;
        description     : String;
        receiptRequired : Boolean default true;
        expensePolicy   : Association to many ExpensePolicies
                              on expensePolicy.expenseCategory = $self;

}

entity AdvancePolicies {
    key ID              : UUID @Core.Computed: true;
        policyName      : String;
        minAmount       : Decimal(15, 2);
        maxAmount       : Decimal(15, 2);
        approvalPercent : Decimal(5, 2);
        action          : String;
        description     : String;
}

entity ExpensePolicies {
    key ID               : UUID @Core.Computed: true;
        policyName       : String;
        travelType       : Association to TravelType;
        expenseCategory  : Association to ExpenseCategories;
        maxAllowedAmount : Decimal(15, 2);
        receiptRequired  : Boolean default true;
        description      : String;
}

entity TravelType {
    key name : String;
}

entity TravelRequests {
    key ID                     : UUID @Core.Computed: true;
        employee               : Association to Employees;
        clientName             : String;
        travelPurpose          : String;
        travelType             : Association to TravelType;
        status                 : String default 'Pending Manager Approval';
        fromLocation           : String;
        toLocation             : String;
        startDate              : Date;
        endDate                : Date;
        estimatedCost          : Decimal(15, 2);
        requestedOn            : Date;
        advanceRequired        : Boolean default false;
        requestedAdvanceAmount : Decimal(15, 2) default 0;
        approvedAdvanceAmount  : Decimal(15, 2) default 0;
        financeapprovedOn      : Date;
        finalReimbursedAmount  : Decimal(15, 2) default 0;
        tripStatus             : String;
        expenseIncurred        : Decimal(15, 2) default 0;
        expenseClaim           : Composition of many ExpenseClaims
                                     on expenseClaim.travelRequest = $self;
}

entity ExpenseClaims {
    key ID              : UUID @Core.Computed: true;
        travelRequest   : Association to TravelRequests;
        expenseType     : Association to ExpenseType;
        expenseDate     : Date;
        requestedAmount : Decimal(15, 2);
        approvedAmount  : Decimal(15, 2);
        description     : String;
        attachment      : String;
        claimStatus     : String default 'Pending';
}
