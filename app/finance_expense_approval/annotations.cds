using Travel_Expense_Service as service from '../../srv/service';

annotate service.FinanceExpenseApproval with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'travelPurpose',
                Value: travelPurpose,
            },
            {
                $Type: 'UI.DataField',
                Label: 'travelType_name',
                Value: travelType_name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'status',
                Value: status,
            },
            {
                $Type: 'UI.DataField',
                Label: 'fromLocation',
                Value: fromLocation,
            },
            {
                $Type: 'UI.DataField',
                Label: 'toLocation',
                Value: toLocation,
            },
            {
                $Type: 'UI.DataField',
                Label: 'startDate',
                Value: startDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'endDate',
                Value: endDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'estimatedCost',
                Value: estimatedCost,
            },
            {
                $Type: 'UI.DataField',
                Label: 'requestedOn',
                Value: requestedOn,
            },
            {
                $Type : 'UI.DataField',
                Value : managerapprovedOn,
                Label : 'managerapprovedOn',
            },
            {
                $Type: 'UI.DataField',
                Label: 'advanceRequired',
                Value: advanceRequired,
            },
            {
                $Type: 'UI.DataField',
                Label: 'requestedAdvanceAmount',
                Value: requestedAdvanceAmount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'financeapprovedOn',
                Value: financeapprovedOn,
            },
            {
                $Type: 'UI.DataField',
                Label: 'approvedAdvanceAmount',
                Value: approvedAdvanceAmount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'finalReimbursedAmount',
                Value: finalReimbursedAmount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'tripStatus',
                Value: tripStatus,
            },
            {
                $Type: 'UI.DataField',
                Label: 'expenseIncurred',
                Value: expenseIncurred,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Expense Claims',
            ID    : 'ExpenseClaims',
            Target: 'expenseClaim/@UI.LineItem#ExpenseClaims1',
        },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: employee.empName,
            Label: 'empName',
        },
        {
            $Type: 'UI.DataField',
            Label: 'travelPurpose',
            Value: travelPurpose,
        },
        {
            $Type: 'UI.DataField',
            Label: 'travelType_name',
            Value: travelType_name,
        },
        {
            $Type: 'UI.DataField',
            Label: 'status',
            Value: status,
        },
        {
            $Type: 'UI.DataField',
            Value: advanceRequired,
            Label: 'advanceRequired',
        },
        {
            $Type: 'UI.DataField',
            Value: approvedAdvanceAmount,
            Label: 'approvedAdvanceAmount',
        },
        {
            $Type: 'UI.DataField',
            Value: estimatedCost,
            Label: 'estimatedCost',
        },
    ],
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: employee.empName,
        },
        TypeName      : '',
        TypeNamePlural: '',
        Description   : {
            $Type: 'UI.DataField',
            Value: employee.role,
        },
    },
);

annotate service.FinanceExpenseApproval with {
    employee @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Employees',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: employee_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'empName',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'email',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'role',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'location_name',
            },
        ],
    }
};

annotate service.FinanceExpenseApproval with {
    department @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Department',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: department_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'totalBudget',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'usedBudget',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'remainingBudget',
            },
        ],
    }
};

annotate service.FinanceExpenseApproval with {
    travelType @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'TravelType',
        Parameters    : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: travelType_name,
            ValueListProperty: 'name',
        }, ],
    }
};

annotate service.ExpenseClaims with @(UI.LineItem #ExpenseClaims1: [
    {
        $Type: 'UI.DataField',
        Value: ID,
        Label: 'ID',
    },
    {
        $Type: 'UI.DataField',
        Value: expenseDate,
        Label: 'Expense Date',
    },
    {
        $Type: 'UI.DataField',
        Value: travelRequest.travelType_name,
        Label: 'Travel Type ',
    },
    {
        $Type: 'UI.DataField',
        Value: expenseType_name,
        Label: 'Expense Type',
    },
    {
        $Type: 'UI.DataField',
        Value: description,
        Label: 'Description',
    },
    {
        $Type: 'UI.DataField',
        Value: claimStatus,
        Label: 'Claim Status',
    },
    {
        $Type: 'UI.DataField',
        Value: attachment,
        Label: 'Attachment',
    },
    {
        $Type: 'UI.DataField',
        Value: requestedAmount,
        Label: 'Requested Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: approvedAmount,
        Label: 'Approved Amount',
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'Travel_Expense_Service.approveExpense',
        Label : 'Approve Expense',
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'Travel_Expense_Service.rejectExpense',
        Label : 'Reject Expense',
    },
]);
