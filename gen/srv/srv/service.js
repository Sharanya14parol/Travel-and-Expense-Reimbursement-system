const cds = require("@sap/cds");
const { data } = require("@sap/cds/lib/dbs/cds-deploy");
const { UPDATE, SELECT } = require("@sap/cds/lib/ql/cds-ql");

module.exports = (srv) => {
  const {
    FinanceAdvanceApproval,
    AdvancePolicies,
    TravelRequests,
    ExpenseClaims,
    ExpensePolicies,
    ExpenseType,
  } = srv.entities;

  srv.before("CREATE", ExpenseClaims, async (req) => {
    const travelRequest = await tx.run(
      SELECT.one.from(TravelRequests).where({ ID: req.data.travelRequest_ID }),
    );
    if (travelRequest.tripStatus !== "Trip completed") {
    }
    req.error(
      400,
      "Expense Claims can only be added after trip is marked as Completed",
    );
  });

  srv.on("approveExpense", ExpenseClaims, async (req) => {
    const tx = cds.transaction(req);
    const id = req.params[1]?.ID;
    console.log(id);

    const existingExpenseRecord = await tx.run(
      SELECT.one
        .from(ExpenseClaims)
        .columns(
          "claimStatus",
          "requestedAmount",
          "travelRequest_ID",
          "expenseType_name",
        )
        .where({ ID: id }),
    );

    const existingTravelRequest = await tx.run(
      SELECT.one
        .from(TravelRequests)
        .columns("travelType", "approvedAdvanceAmount", "expenseIncurred")
        .where({ ID: existingExpenseRecord.travelRequest_ID }),
    );
    const policy = await tx.run(
      SELECT.one.from(ExpensePolicies).columns("maxAllowedAmount").where({
        policyName: existingExpenseRecord.expenseType_name,
        travelType_name: existingTravelRequest.travelType_name,
      }),
    );
    if (!policy) {
      return req.error(400, "No policy found for this expense");
    }
    if (existingExpenseRecord.claimStatus != "Pending") {
      return req.error(400, "This advance request has already been processed");
    } else {
      if (existingExpenseRecord.requestedAmount <= policy.maxAllowedAmount) {
        await tx.run(
          UPDATE(ExpenseClaims)
            .set({
              claimStatus: "Expense Approved",
              approvedAmount: existingExpenseRecord.requestedAmount,
            })
            .where({ ID: id }),
        );
        await tx.run(
          UPDATE(TravelRequests)
            .set({
              expenseIncurred:
                existingTravelRequest.expenseIncurred +
                existingExpenseRecord.requestedAmount,
              finalReimbursedAmount:
                existingTravelRequest.approvedAdvanceAmount +
                existingExpenseRecord.requestedAmount,
            })
            .where({ ID: existingExpenseRecord.travelRequest_ID }),
        );
        req.notify("Request approved Successfully");
      } else {
        await tx.run(
          UPDATE(ExpenseClaims)
            .set({
              claimStatus: "Expense Partially Approved",
              approvedAmount: policy.maxAllowedAmount,
            })
            .where({ ID: id }),
        );
        await tx.run(
          UPDATE(TravelRequests)
            .set({
              expenseIncurred:
                existingTravelRequest.expenseIncurred +
                existingExpenseRecord.requestedAmount,
              finalReimbursedAmount:
                existingTravelRequest.approvedAdvanceAmount +
                policy.maxAllowedAmount,
            })
            .where({ ID: existingExpenseRecord.travelRequest_ID }),
        );
        req.notify("Exceeded Company Expense policy");
      }
    }
  });

  srv.on("rejectExpense", ExpenseClaims, async (req) => {
    const tx = cds.transaction(req);
    const id = req.params[1]?.ID;
    const existingExpenseRecord = await tx.run(
      SELECT.one
        .from(ExpenseClaims)
        .columns("claimStatus", "requestedAmount", "travelRequest_ID")
        .where({ ID: id }),
    );
    const existingTravelRequest = await tx.run(
      SELECT.one
        .from(TravelRequests)
        .columns("expenseIncurred")
        .where({ ID: existingExpenseRecord.travelRequest_ID }),
    );

    if (existingExpenseRecord.claimStatus != "Pending") {
      return req.error(400, "This advance request has already been processed");
    } else {
      await tx.run(
        UPDATE(ExpenseClaims)
          .set({ claimStatus: "Expense Rejected" })
          .where({ ID: id }),
      );
      await tx.run(
        UPDATE(TravelRequests)
          .set({
            expenseIncurred:
              existingTravelRequest.expenseIncurred +
              existingExpenseRecord.requestedAmount,
          })
          .where({ ID: existingExpenseRecord.travelRequest_ID }),
      );
      req.notify("Request Rejected");
    }
  });

  srv.on("approve", TravelRequests, async (req) => {
    const tx = cds.transaction(req);
    const id = req.params[0]?.ID;

    const existing = await tx.run(
      SELECT.one
        .from(TravelRequests)
        .columns("advanceRequired")
        .where({ ID: id }),
    );
    if (existing.advanceRequired == false) {
      await tx.run(
        UPDATE(TravelRequests)
          .set({
            status: "Manager Approved",
            tripStatus: "Trip approved",
            managerapprovedOn: new Date(),
          })
          .where({ ID: id }),
      );
    } else {
      await tx.run(
        UPDATE(TravelRequests)
          .set({
            status: "Pending Finance Approval",
            managerapprovedOn: new Date(),
          })
          .where({ ID: id }),
      );
    }
    req.notify("Request Approved Successfully");
  });

  srv.on("advanceapprove", FinanceAdvanceApproval, async (req) => {
    const tx = cds.transaction(req);
    const id = req.params[0]?.ID;

    const travelRequest = await tx.run(
      SELECT.one.from(TravelRequests).where({ ID: id }),
    );

    if (
      !travelRequest.requestedAdvanceAmount ||
      travelRequest.requestedAdvanceAmount <= 0
    ) {
      return req.error(400, "Requested advance amount must be greater than 0");
    }

    if (!travelRequest.estimatedCost || travelRequest.estimatedCost <= 0) {
      return req.error(400, "Estimated cost must be greater than 0");
    }
    if (travelRequest.financeapprovedOn) {
      return req.error(
        400,
        "This advance request has already been processed by finance",
      );
    }
    const estimatedCost = travelRequest.estimatedCost;
    const requestedAmount = travelRequest.requestedAdvanceAmount;

    const policy = await tx.run(
      SELECT.one.from(AdvancePolicies)
        .where`${estimatedCost} >=minAmount and ${estimatedCost} <=maxAmount `,
    );
    if (!policy) {
      return req.error(400, "No suitable Advance policy Found!!");
    }

    if (policy.action == "Approve") {
      const allowedAdvance = (estimatedCost * policy.approvalPercent) / 100.0;

      const approvedAmount = Math.min(allowedAdvance, requestedAmount);

      await tx.run(
        UPDATE(TravelRequests)
          .set({
            financeapprovedOn: new Date(),
            approvedAdvanceAmount: approvedAmount,
            tripStatus: "Trip approved",
          })
          .where({ ID: id }),
      );

      if (approvedAmount < requestedAmount) {
        await tx.run(
          UPDATE(TravelRequests)
            .set({ status: "Partial Advance Approved" })
            .where({ ID: id }),
        );
      } else {
        await tx.run(
          UPDATE(TravelRequests)
            .set({ status: "Full Advance Approved" })
            .where({ ID: id }),
        );
      }
    }

    if (policy.action == "Reject") {
      await tx.run(
        UPDATE(TravelRequests)
          .set({
            status: "Rejected as per Company policy",
            approvedAdvanceAmount: 0.0,
            financeapprovedOn: new Date(),
          })
          .where({ ID: id }),
      );
    }
    req.notify("Request Processed Successfully");
  });

  srv.on("advancereject", FinanceAdvanceApproval, async (req) => {
    const tx = cds.transaction(req);
    const id = req.params[0]?.ID;

    await tx.run(
      UPDATE(TravelRequests)
        .set({
          status: "Rejected by Finance Dept.",
          approvedAdvanceAmount: 0.0,
          financeapprovedOn: new Date(),
        })
        .where({ ID: id }),
    );
    req.notify("Request Rejected");
  });

  /* To change the field in travel request, we generally require travel request id but howeverr here since travel requests in an child entity of employee the id parameter generally returned would be of parent 
  req.params[0] → often parent entity (Employees) 
  req.params[1] → child entity (TravelRequests)
  */
  srv.on("tripCompleted", TravelRequests, async (req) => {
    const tx = cds.transaction(req);
    const id = req.params[1]?.ID;

    const existing = await tx.run(
      SELECT.one.from(TravelRequests).where({ ID: id }),
    );

    if (existing.tripStatus === "Trip completed") {
      return req.notify("Trip already marked as Completed");
    }
    await tx.run(
      UPDATE(TravelRequests)
        .set({
          tripStatus: "Trip completed",
        })
        .where({ ID: id }),
    );
    req.notify("Trip marked as Completed");
  });

  srv.on("approve", ExpenseClaims, async (req) => {
    const tx = cds.transaction(req);
    const id = req.params[1].ID;

    const existing = await tx.run(
      SELECT.one.from(ExpenseClaims).where({ ID: id }),
    );

    if (!existing) {
      return req.error(404, "Expense claim not found");
    }

    if (existing.claimStatus !== "Pending") {
      return req.notify("Request already processed");
    }

    const travelRequest = await tx.run(
      SELECT.one.from(TravelRequests).where({ ID: existing.travelRequest_ID }),
    );

    if (!travelRequest) {
      return req.error(404, "Travel Request not found");
    }

    const expensePolicy = await tx.run(
      SELECT.one.from(ExpensePolicies).where({
        policyName: existing.expenseType_name,
        travelType_name: travelRequest.travelType_name,
      }),
    );

    if (!expensePolicy) {
      return req.error(404, "Expense policy not found");
    }

    let approvedAmount = 0;

    if (existing.requestedAmount <= expensePolicy.maxAllowedAmount) {
      approvedAmount = existing.requestedAmount;

      await tx.run(
        UPDATE(ExpenseClaims)
          .set({
            claimStatus: "Approved by Finance Team",
            approvedAmount: approvedAmount,
          })
          .where({ ID: id }),
      );
    } else {
      approvedAmount = expensePolicy.maxAllowedAmount;

      await tx.run(
        UPDATE(ExpenseClaims)
          .set({
            claimStatus: "Partially Approved as per Company Expense Policy",
            approvedAmount: approvedAmount,
          })
          .where({ ID: id }),
      );
    }

    // ✅ CORRECT calculation using actual DB values
    const reimbursedAmount =
      (travelRequest.approvedAdvanceAmount || 0) + approvedAmount;

    await tx.run(
      UPDATE(TravelRequests)
        .set({
          finalReimbursedAmount: reimbursedAmount,
        })
        .where({ ID: existing.travelRequest_ID }),
    );

    req.notify("Request processed successfully");
  });
  srv.after("CREATE", ExpenseClaims, async (data, req) => {
    const tx = cds.transaction(req);

    const claims = await tx.run(
      SELECT.from(ExpenseClaims)
        .columns("requestedAmount")
        .where({ travelRequest_ID: data.travelRequest_ID }),
    );
    const totalExpense = claims.reduce(
      (sum, claim) => sum + Number(claim.requestedAmount || 0),
      0,
    );
    await tx.run(
      UPDATE(TravelRequests)
        .set({ expenseIncurred: totalExpense })
        .where({ ID: data.travelRequest_ID }),
    );
    console.log("Expense incurred updated to:", totalExpense);
    req.notify("Expense incurred updated successfully");
  });

  srv.on("reject", ExpenseClaims, async (req) => {
    const tx = cds.transaction(req);
    const id = req.params[1].ID;

    const existing = await tx.run(
      SELECT.one.from(ExpenseClaims).where({ ID: id }),
    );

    if (!existing) {
      return req.error(404, "Expense claim not found");
    }
    console.log(existing.claimStatus);
    if (existing.claimStatus !== "Pending") {
      return req.notify("Requested already processed");
    }
    await tx.run(
      UPDATE(ExpenseClaims)
        .set({ claimStatus: "Rejected by Finance Team" })
        .where({ ID: id }),
    );
    req.notify("Requested Rejected");
  });
};
