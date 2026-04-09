using Travel_Expense_Service as service from '../../srv/service';

annotate service.TravelRequests with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Travel Purpose',
                Value: travelPurpose,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Status',
                Value: status,
            },
            {
                $Type: 'UI.DataField',
                Value: travelType_name,
                Label: 'Travel Type',
            },
            {
                $Type: 'UI.DataField',
                Label: 'From Location',
                Value: fromLocation,
            },
            {
                $Type: 'UI.DataField',
                Label: 'To Location',
                Value: toLocation,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Start Date',
                Value: startDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'End Date',
                Value: endDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Estimated Cost',
                Value: estimatedCost,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Advance Required',
                Value: advanceRequired,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Advance Amount',
                Value: requestedAdvanceAmount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Approved Advance Amount',
                Value: approvedAdvanceAmount,
            },
            {
                $Type: 'UI.DataField',
                Value: financeapprovedOn,
                Label: 'Finance approvedOn',
            },
            {
                $Type: 'UI.DataField',
                Value: requestedOn,
                Label: 'Requested On',
            },
            {
                $Type: 'UI.DataField',
                Value: finalReimbursedAmount,
                Label: 'Reimbursed Amount',
            },
            {
                $Type: 'UI.DataField',
                Value: expenseIncurred,
                Label: 'Expense Incurred',
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'Travel Request Details',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Expense Claims',
            ID    : 'ExpenseClaims',
            Target: 'expenseClaim/@UI.LineItem#ExpenseClaims',
        },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: employee.empName,
            Label: 'Employee',
        },
        {
            $Type: 'UI.DataField',
            Label: 'Travel Purpose',
            Value: travelPurpose,
        },
        {
            $Type: 'UI.DataField',
            Value: travelType_name,
            Label: 'Travel Type',
        },
        {
            $Type: 'UI.DataField',
            Label: 'Status',
            Value: status,
        },
        {
            $Type: 'UI.DataField',
            Label: 'From',
            Value: fromLocation,
        },
        {
            $Type: 'UI.DataField',
            Label: 'To',
            Value: toLocation,
        },
        {
            $Type: 'UI.DataField',
            Value: startDate,
            Label: 'Start',
        },
        {
            $Type: 'UI.DataField',
            Value: endDate,
            Label: 'End',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'Travel_Expense_Service.approve',
            Label : 'approve',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'Travel_Expense_Service.reject',
            Label : 'reject',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'Travel_Expense_Service.SendBack',
            Label : 'SendBack',
        },
    ],
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: travelPurpose,
        },
        TypeName      : '',
        TypeNamePlural: '',
        Description   : {
            $Type: 'UI.DataField',
            Value: travelType_name,
        },
        TypeImageUrl  : 'sap-icon://person-placeholder',
    },
);

annotate service.TravelRequests with {
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
                ValueListProperty: 'department',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'designation',
            },
        ],
    }
};

annotate service.ExpenseClaims with @(UI.LineItem #ExpenseClaims: [
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
        Value: expenseType_name,
        Label: 'Expense Type',
    },
    {
        $Type: 'UI.DataField',
        Value: travelRequest.travelType_name,
        Label: 'Travel Type',
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
]);

annotate service.ExpenseClaims with {
    expenseType @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ExpenseType',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: expenseType_name,
                ValueListProperty: 'name',
            }, ],
            Label         : 'Expense Type',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.ExpenseClaims with {
    approvedAmount @Common.FieldControl: #ReadOnly
};

annotate service.ExpenseClaims with {
    claimStatus @Common.FieldControl: #ReadOnly
};
