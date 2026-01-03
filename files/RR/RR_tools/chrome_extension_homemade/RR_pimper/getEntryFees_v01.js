
function downloadJSON(data, filename) {
    const jsonString = JSON.stringify(data, null, 2);
    const blob = new Blob([jsonString], { type: 'application/json' });
    const url = URL.createObjectURL(blob);

    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);

    console.log(`📁 Downloaded: ${filename}`);
}











// Function to download TSV as file
function downloadTSV(data, filename) {
    const blob = new Blob([data], { type: 'text/tab-separated-values' });
    const url = URL.createObjectURL(blob);

    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);

    console.log(`📁 Downloaded: ${filename}`);
}





function createMergedSummaryTSV(participantsWithFees, participantsWithPayments) {
    // Collect statistics from both sources
    const { feeStats, languagesList } = collectFeeStats(participantsWithFees);
    const paymentStats = collectPaymentStats(participantsWithPayments);

    // Merge: get all unique IDs from both fees and payments
    const allIDs = new Set([
        ...Object.keys(feeStats),
        ...Object.keys(paymentStats)
    ]);

    // Build merged data structure
    const mergedStats = {};

    allIDs.forEach(feeID => {
        const feeData = feeStats[feeID];
        const paymentData = paymentStats[feeID];

        mergedStats[feeID] = {
            id: feeID,
            name: feeData ? feeData.name : '',
            labels: feeData ? feeData.labels : {},
            countFees: feeData ? feeData.countFees : 0,
            sumFees: feeData ? feeData.sumFees : 0,
            uniqueFees: feeData ? feeData.uniqueFees : new Set(),
            countPayments: paymentData ? paymentData.countPayments : 0,
            sumPayments: paymentData ? paymentData.sumPayments : 0,
            uniquePayments: paymentData ? paymentData.uniquePayments : new Set()
        };
    });

    // Create TSV header dynamically
    let tsvContent = "ID\tCountFees\tCountPayments\tLabel\tName\t";
    languagesList.forEach(lang => {
        tsvContent += `Label_${lang}\t`;
    });
    tsvContent += "SumFees\tUniqueFees\tSumPayments\tUniquePayments\n";

    // Sort by SumFees descending (you can change to SumPayments if preferred)
    const sortedIDs = Array.from(allIDs).sort((a, b) =>
        mergedStats[b].sumFees - mergedStats[a].sumFees
    );

    sortedIDs.forEach(feeID => {
        const stats = mergedStats[feeID];

        const uniqueFeesArray = Array.from(stats.uniqueFees).sort((a, b) => a - b);
        const uniqueFeesString = uniqueFeesArray.join(', ');

        const uniquePaymentsArray = Array.from(stats.uniquePayments).sort((a, b) => a - b);
        const uniquePaymentsString = uniquePaymentsArray.join(', ');

        // Determine Label with priority: EN → DE → Name
        let label = stats.labels['EN'] || stats.labels['DE'] || stats.name;

        tsvContent += `${stats.id}\t${stats.countFees}\t${stats.countPayments}\t${label}\t${stats.name}\t`;

        // Add label columns in the same order as header
        languagesList.forEach(lang => {
            const langLabel = stats.labels[lang] || '';
            tsvContent += `${langLabel}\t`;
        });

        tsvContent += `${stats.sumFees}\t${uniqueFeesString}\t${stats.sumPayments}\t${uniquePaymentsString}\n`;
    });

    console.log('Merged TSV Summary:');
    console.log(tsvContent);

    // Download the merged TSV file
    downloadTSV(tsvContent, 'merged-fees-payments-summary.tsv');

    return tsvContent;
}








function collectPaymentStats(participantsWithPayments) {
    // Object to store payment statistics by ID (no labels, no names)
    const paymentStats = {};

    // Parse through all participants and their payments
    for (const participantID in participantsWithPayments) {
        const payments = participantsWithPayments[participantID];

        for (let i = 0; i < payments.length; i++) {
            const payment = payments[i];

            if (!payment.Registrations) continue;

            for (let j = 0; j < payment.Registrations.length; j++) {
                const registration = payment.Registrations[j];

                if (!registration.Fees) continue;

                for (let k = 0; k < registration.Fees.length; k++) {
                    const fee = registration.Fees[k];
                    const feeID = fee.ID;
                    const feeAmount = fee.Amount;
                    const feeQty = fee.Qty || 1;

                    // Initialize or update payment statistics
                    if (!paymentStats[feeID]) {
                        paymentStats[feeID] = {
                            id: feeID,
                            countPayments: 0,
                            sumPayments: 0,
                            uniquePayments: new Set()
                        };
                    }

                    paymentStats[feeID].countPayments += feeQty;
                    paymentStats[feeID].sumPayments += feeAmount * feeQty;
                    paymentStats[feeID].uniquePayments.add(feeAmount);
                }
            }
        }
    }

    return paymentStats;
}










function collectFeeStats(participantsWithFees) {
    // First pass: detect all languages used
    const allLanguages = new Set();

    for (const participantID in participantsWithFees) {
        const participantFees = participantsWithFees[participantID];
        for (const bibNumber in participantFees) {
            const fees = participantFees[bibNumber];
            fees.forEach(feeItem => {
                const feeName = feeItem.Name;
                const multiLangMatch = feeName.match(/^\{(.+)\}$/);
                if (multiLangMatch) {
                    const content = multiLangMatch[1];
                    const parts = content.split('|');
                    parts.forEach(part => {
                        const langMatch = part.match(/^([A-Z]{2}):/);
                        if (langMatch) {
                            allLanguages.add(langMatch[1]);
                        }
                    });
                }
            });
        }
    }

    const languagesList = Array.from(allLanguages).sort();
    console.log('Detected languages in fees:', languagesList);

    // Object to store fee statistics by ID
    const feeStats = {};

    // Parse through all participants and their fees
    for (const participantID in participantsWithFees) {
        const participantFees = participantsWithFees[participantID];

        for (const bibNumber in participantFees) {
            const fees = participantFees[bibNumber];
            fees.forEach(feeItem => {
                const feeID = feeItem.ID;
                const feeName = feeItem.Name;
                const feeAmount = feeItem.Fee;

                // Extract labels for all languages
                const labels = {};

                const multiLangMatch = feeName.match(/^\{(.+)\}$/);
                if (multiLangMatch) {
                    const content = multiLangMatch[1];
                    const parts = content.split('|');
                    parts.forEach(part => {
                        const langMatch = part.match(/^([A-Z]{2}):(.+)$/);
                        if (langMatch) {
                            const langCode = langMatch[1];
                            const labelText = langMatch[2];
                            labels[langCode] = labelText;
                        }
                    });
                }

                // Initialize or update fee statistics
                if (!feeStats[feeID]) {
                    feeStats[feeID] = {
                        id: feeID,
                        name: feeName,
                        labels: labels,
                        countFees: 0,
                        sumFees: 0,
                        uniqueFees: new Set()
                    };
                }

                feeStats[feeID].countFees++;
                feeStats[feeID].sumFees += feeAmount;
                feeStats[feeID].uniqueFees.add(feeAmount);
            });
        }
    }

    return { feeStats, languagesList };
}











async function getAllParticipantsWithFees() {
    try {
        console.log('Getting all participant IDs...');

        const idData = await parent.RM().Data.GetJSON("id");
        console.log(`Found ${idData.length} total participants`);

        const ids = idData.map(row => row[0]);
        const participantsWithFees = {};
        const participantsWithPayments = {}; // NEW: Store payment data

        for (const pid of ids) {
            try {
                // Get entry fees
                const fees = await parent.RM().Participants.EntryFee(pid);
                if (Object.keys(fees).length > 0) {
                    participantsWithFees[pid] = fees;
                    console.log(`✅ PID ${pid} has fees`);

                    // NEW: Get payment data
                    try {
                        const payments = await parent.RM().Pay.Payments.Participant(parent.RM().EventID(), pid);
                        if (payments && payments.length > 0) {
                            participantsWithPayments[pid] = payments;
                            console.log(`💳 PID ${pid} has ${payments.length} payment(s)`);
                        }
                    } catch (payErr) {
                        console.log(`⚠️ PID ${pid} payment error:`, payErr.message);
                    }

                } else {
                    console.log(`⚪ PID ${pid} has no fees`);
                }
            } catch (err) {
                console.log(`❌ PID ${pid} error:`, err.message);
            }
        }

        console.log(`\nComplete! Found ${Object.keys(participantsWithFees).length} participants with entry fees out of ${ids.length} total`);
        console.log(`Found ${Object.keys(participantsWithPayments).length} participants with payments`);

        if (Object.keys(participantsWithFees).length > 0) {
            // Download JSON
            downloadJSON(participantsWithFees, 'all-participants-with-fees.json');
            downloadJSON(participantsWithPayments, 'all-participants-with-payments.json');

            // Create and download merged TSV summary
            createMergedSummaryTSV(participantsWithFees, participantsWithPayments);
        }



        return { fees: participantsWithFees, payments: participantsWithPayments };

    } catch (error) {
        console.error('Error:', error);
    }
}














// Call the function
getAllParticipantsWithFees();
