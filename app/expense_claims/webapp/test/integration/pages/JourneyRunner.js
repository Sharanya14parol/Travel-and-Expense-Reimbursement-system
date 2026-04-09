sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"expenseclaims/test/integration/pages/ExpenseClaimsList",
	"expenseclaims/test/integration/pages/ExpenseClaimsObjectPage"
], function (JourneyRunner, ExpenseClaimsList, ExpenseClaimsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('expenseclaims') + '/test/flp.html#app-preview',
        pages: {
			onTheExpenseClaimsList: ExpenseClaimsList,
			onTheExpenseClaimsObjectPage: ExpenseClaimsObjectPage
        },
        async: true
    });

    return runner;
});

