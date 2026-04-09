sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"expensepolicies/test/integration/pages/ExpensePoliciesList",
	"expensepolicies/test/integration/pages/ExpensePoliciesObjectPage"
], function (JourneyRunner, ExpensePoliciesList, ExpensePoliciesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('expensepolicies') + '/test/flp.html#app-preview',
        pages: {
			onTheExpensePoliciesList: ExpensePoliciesList,
			onTheExpensePoliciesObjectPage: ExpensePoliciesObjectPage
        },
        async: true
    });

    return runner;
});

