using {travel_expense_management_system as db} from '../db/schema';

service Travel_Expense_Service {

    @odata.draft.enabled
    entity Employees              as projection on db.Employees;

    @odata.draft.enabled
    entity ExpenseCategories      as projection on db.ExpenseCategories;

    @odata.draft.enabled
    entity ExpensePolicies        as projection on db.ExpensePolicies;

    @cds.redirection.target
    entity TravelRequests         as projection on db.TravelRequests
        actions {
            action approve();
            action reject();
            action tripCompleted();
        };

    //Only the records which requested for advance would be moved to Finance Approval Page
    entity FinanceAdvanceApproval as
        projection on db.TravelRequests {
            *
        }
        where
            advanceRequired = true
        actions {
            action advanceapprove();
            action advancereject();
        };

    entity FinanceExpenseApproval as
        projection on db.TravelRequests {
            *
        };

    @odata.draft.enabled
    entity AdvancePolicies        as projection on db.AdvancePolicies;

    // @cds.redirection.target
    entity ExpenseClaims          as projection on db.ExpenseClaims
        actions {
            action approveExpense();
            action rejectExpense();
        };

    entity Department             as projection on db.Department;

    entity ExpenseType            as projection on db.ExpenseType;

    entity Location               as projection on db.Location;

    entity TravelType             as projection on db.TravelType;

//Actions defined on an entity usually works on an selected row or else it is disabled
}
