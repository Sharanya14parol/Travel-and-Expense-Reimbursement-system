using Travel_Expense_Service as service from '../../srv/service';

annotate service.Employees with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ID,
                Label: 'ID',
            },
            {
                $Type: 'UI.DataField',
                Label: 'Name',
                Value: empName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Email',
                Value: email,
            },
            {
                $Type: 'UI.DataField',
                Value: department_ID,
                Label: 'Department',
            },
            {
                $Type: 'UI.DataField',
                Value: location_ID,
                Label: 'Location',
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
            Label : 'Travel Requests',
            ID    : 'TravelRequests',
            Target: 'travelRequest/@UI.LineItem#TravelRequests',
        },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'Name',
            Value: empName,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Email',
            Value: email,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Department',
            Value: department.name,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Role',
            Value: role,
        },
        {
            $Type: 'UI.DataField',
            Value: location.name,
            Label: 'Location',
        },
    ],
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: empName,
        },
        TypeName      : '',
        TypeNamePlural: '',
        TypeImageUrl  : 'sap-icon://person-placeholder',
    },
);

annotate service.TravelRequests with @(UI.LineItem #TravelRequests: [
    {
        $Type: 'UI.DataField',
        Value: travelPurpose,
        Label: 'Travel Purpose',
    },
    {
        $Type: 'UI.DataField',
        Value: travelType_name,
        Label: 'Travel Type',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.travelRequest.fromLocation,
        Label: 'From',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.travelRequest.toLocation,
        Label: 'To',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.travelRequest.startDate,
        Label: 'Start',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.travelRequest.endDate,
        Label: 'End',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.travelRequest.estimatedCost,
        Label: 'Estimated Cost',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.travelRequest.advanceRequired,
        Label: 'Advance Required',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.travelRequest.requestedAdvanceAmount,
        Label: 'Advance Amount',
    },
    {
        $Type: 'UI.DataField',
        Value: employee.travelRequest.status,
        Label: 'Status',
    },
    {
        $Type: 'UI.DataField',
        Value: tripStatus,
        Label: 'Trip Status',
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action: 'Travel_Expense_Service.tripCompleted',
        Label : 'Trip Completed',
        Inline: true,
    },
]);

annotate service.TravelRequests with {
    status @Common.FieldControl: #ReadOnly
};


annotate service.Employees with {
    ID @Common.FieldControl: #ReadOnly
};


annotate service.TravelRequests with {
    travelType @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'TravelType',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: travelType_name,
                ValueListProperty: 'name',
            }, ],
            Label         : 'Travel type',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.TravelRequests with {
    approvedAdvanceAmount @Common.FieldControl: #ReadOnly
};

annotate service.TravelRequests with {
    financeapprovedOn @Common.FieldControl: #ReadOnly
};

annotate service.TravelRequests with {
    finalReimbursedAmount @Common.FieldControl: #ReadOnly
};

annotate service.TravelRequests with {
    expenseIncurred @Common.FieldControl: #ReadOnly
};

annotate service.TravelRequests with {
    requestedOn @Common.FieldControl: #ReadOnly
};

annotate service.TravelRequests with {
    managerapprovedOn @Common.FieldControl: #ReadOnly
};

annotate service.Employees with {
    department @(
        Common.ValueList               : {
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
                }
            ],
            Label         : 'Department',
        },
        Common.Text                    : department.name,
        Common.TextArrangement         : #TextOnly,
        Common.ValueListWithFixedValues: true,
    )
};
annotate service.Employees with {
    location @(
        Common.ExternalID : location.name,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Location',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : location_ID,
                    ValueListProperty : 'ID',
                },
            ],
            Label : 'Location',
        },
        Common.ValueListWithFixedValues : true,
)};

