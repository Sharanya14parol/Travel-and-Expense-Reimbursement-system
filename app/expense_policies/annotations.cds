using Travel_Expense_Service as service from '../../srv/service';
annotate service.ExpensePolicies with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'policyName',
                Value : policyName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'travelType',
                Value : travelType,
            },
            {
                $Type : 'UI.DataField',
                Label : 'maxAllowedAmount',
                Value : maxAllowedAmount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'receiptRequired',
                Value : receiptRequired,
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
            Label : 'policyName',
            Value : policyName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'travelType',
            Value : travelType,
        },
        {
            $Type : 'UI.DataField',
            Label : 'maxAllowedAmount',
            Value : maxAllowedAmount,
        },
        {
            $Type : 'UI.DataField',
            Label : 'receiptRequired',
            Value : receiptRequired,
        },
    ],
);

annotate service.ExpensePolicies with {
    expenseCategory @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'ExpenseCategories',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : expenseCategory_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'category',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'description',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'receiptRequired',
            },
        ],
    }
};

