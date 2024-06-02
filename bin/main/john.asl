
// Belief
age(23).
bmi(18).
avg_glu(102).
fam_his(1).
exc_frq(3).
g1(1).
g2(1).
g3(1).
life_style_changes(1).
medication(1).

// Desire
!send_medical_details.
!suggetions.

// Intention

+!send_medical_details <-
    ?age(AGE);
    ?bmi(BMI);
    ?avg_glu(AVG_GLU);
    ?fam_his(FAM_HIS);
    ?exc_frq(EXC_FRQ);
    ?g1(G1);
    ?g2(G2);
    ?g3(G3);
    .send(riskAssessmentAgent, tell, patient_details(AGE,BMI,AVG_GLU,FAM_HIS,EXC_FRQ,G1,G2,G3));
    .print("Medical details sent to RiskAssessment: ").

+!receive_lifestyle_changes(LifestyleChanges) : true <-
    .print("Received lifestyle changes: ", LifestyleChanges).

+suggested(LifestyleChanges, Medication)  <-
    -+life_style_changes(LifestyleChanges);
    -+medication(Medication).

+!suggetions <-
    .wait(1000);
    ?life_style_changes(LifestyleChanges);
    ?medication(Medication);
    .print("Received life style recommandations: ", LifestyleChanges);
    .print("Received medication recommandations: ", Medication).