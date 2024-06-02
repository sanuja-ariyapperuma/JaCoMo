

+risk_info(RiskScore, GeneticScore) : true <-
    .print("Received risk score: ", RiskScore, GeneticScore);
    !calculate_lifestyle_changes.

+!calculate_lifestyle_changes : risk_info(RiskScore, GeneticScore) <-
    (if (RiskScore < 80) {
        LifestyleChanges = "Maintain current lifestyle";
    } else {
        LifestyleChanges = "Increase physical activity";
    });
    (if (GeneticScore < 100) {
        Medication = "No medications needed";
    } else {
        Medication = "Take Metformin 20mg every night";
    });
    .send(riskAssessmentAgent, tell, recommanded(LifestyleChanges, Medication));
    .print("Lifestyle changes calculated and sent to RiskAssessment: ", LifestyleChanges, Medication).
