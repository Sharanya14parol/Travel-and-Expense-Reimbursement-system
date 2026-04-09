sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"financeadvanceapproval/test/integration/pages/FinanceAdvanceApprovalList",
	"financeadvanceapproval/test/integration/pages/FinanceAdvanceApprovalObjectPage"
], function (JourneyRunner, FinanceAdvanceApprovalList, FinanceAdvanceApprovalObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('financeadvanceapproval') + '/test/flp.html#app-preview',
        pages: {
			onTheFinanceAdvanceApprovalList: FinanceAdvanceApprovalList,
			onTheFinanceAdvanceApprovalObjectPage: FinanceAdvanceApprovalObjectPage
        },
        async: true
    });

    return runner;
});

