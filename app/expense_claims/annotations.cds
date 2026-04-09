using Travel_Expense_Service as service from '../../srv/service';
annotate service.ExpenseClaims with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'claimDate',
                Value : claimDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'tripCompletedDate',
                Value : tripCompletedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalClaimedAmount',
                Value : totalClaimedAmount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'claimDate',
            Value : claimDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'tripCompletedDate',
            Value : tripCompletedDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'totalClaimedAmount',
            Value : totalClaimedAmount,
        },
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
        },
    ],
);

annotate service.ExpenseClaims with {
    employee @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Employees',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : employee_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'empName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'department',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'designation',
            },
        ],
    }
};

annotate service.ExpenseClaims with {
    travelRequest @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'TravelRequests',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : travelRequest_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'travelPurpose',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'travelType',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'status',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'fromLocation',
            },
        ],
    }
};

