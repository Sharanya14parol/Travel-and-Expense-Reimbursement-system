sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"travelrequests/test/integration/pages/TravelRequestsList",
	"travelrequests/test/integration/pages/TravelRequestsObjectPage"
], function (JourneyRunner, TravelRequestsList, TravelRequestsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('travelrequests') + '/test/flp.html#app-preview',
        pages: {
			onTheTravelRequestsList: TravelRequestsList,
			onTheTravelRequestsObjectPage: TravelRequestsObjectPage
        },
        async: true
    });

    return runner;
});

