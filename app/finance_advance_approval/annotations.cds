using Travel_Expense_Service as service from '../../srv/service';

annotate service.FinanceAdvanceApproval with @(
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
                Label: 'Travel Type',
                Value: travelType_name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Status',
                Value: status,
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
                Label: 'Requested On',
                Value: requestedOn,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Advance Required',
                Value: advanceRequired,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Requested Advance Amount',
                Value: requestedAdvanceAmount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Approved Advance Amount',
                Value: approvedAdvanceAmount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Finance Approved On',
                Value: financeapprovedOn,
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
            Label : 'Expense Claim',
            ID    : 'ExpenseClaim',
            Target: 'expenseClaim/@UI.LineItem#ExpenseClaim',
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
            Label: 'fromLocation',
            Value: fromLocation,
        },
        {
            $Type: 'UI.DataField',
            Value: toLocation,
            Label: 'toLocation',
        },
        {
            $Type: 'UI.DataField',
            Value: startDate,
            Label: 'startDate',
        },
        {
            $Type: 'UI.DataField',
            Value: endDate,
            Label: 'endDate',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'Travel_Expense_Service.advanceapprove',
            Label : 'advanceapprove',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'Travel_Expense_Service.advancereject',
            Label : 'advancereject',
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
            Value: employee.designation,
        },
    },
);

annotate service.FinanceAdvanceApproval with {
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

annotate service.FinanceAdvanceApproval with {
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

annotate service.ExpenseClaims with @(UI.LineItem #ExpenseClaim: [
    {
        $Type: 'UI.DataField',
        Value: employee.expenseClaim.ID,
        Label: 'Expense Claim Id',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.expenseClaim.employee.empName,
        Label: 'Employee Name',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.expenseClaim.expenseDate,
        Label: 'Expense Date',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.expenseClaim.expenseType_name,
        Label: 'Expense Type',
    },
    {
        $Type : 'UI.DataField',
        Value : travelRequest.travelType_name,
        Label : 'Travel Type',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.expenseClaim.description,
        Label: 'Description',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.expenseClaim.claimStatus,
        Label: 'Claim Status',
    },
    {
        $Type : 'UI.DataField',
        Value : employee.expenseClaim.requestedAmount,
        Label : 'Requested Amount',
    },
    {
        $Type : 'UI.DataField',
        Value : employee.expenseClaim.approvedAmount,
        Label : 'Approved Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.expenseClaim.attachment,
        Label: 'Attachment',
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'Travel_Expense_Service.approve',
        Label : 'Approve',
        Inline : true,
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'Travel_Expense_Service.reject',
        Label : 'Reject',
        Inline : true,
    },
]);
