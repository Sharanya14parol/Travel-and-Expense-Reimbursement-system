sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"financeexpenseapproval/test/integration/pages/FinanceExpenseApprovalList",
	"financeexpenseapproval/test/integration/pages/FinanceExpenseApprovalObjectPage"
], function (JourneyRunner, FinanceExpenseApprovalList, FinanceExpenseApprovalObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('financeexpenseapproval') + '/test/flp.html#app-preview',
        pages: {
			onTheFinanceExpenseApprovalList: FinanceExpenseApprovalList,
			onTheFinanceExpenseApprovalObjectPage: FinanceExpenseApprovalObjectPage
        },
        async: true
    });

    return runner;
});

