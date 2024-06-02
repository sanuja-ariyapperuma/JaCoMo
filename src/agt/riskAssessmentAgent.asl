
// Belief 
patient_age(0).
patient_bmi(0).
patient_avg_glu(0).
patient_fam_his(0).
patient_exc_frq(0).
patient_g1(0).
patient_g2(0).
patient_g3(0).
patient_life_style_changes(0).
patient_medication(0).
risk_score(0).
genetic_score(0).
lifestyleRecommandation(0).
medicationRecommandation(0).

// Desires
!calculate_risk_score.
!calculate_genetic_score. 
!getLifestyleMedications.
!send_recommandation_back.

// Intentions

+patient_details(AGE,BMI,AVG_GLU,FAM_HIS,EXC_FRQ,G1,G2,G3)[source(AGENT)] : true <-
    -+patient_age(AGE);
    -+patient_bmi(BMI);
    -+patient_avg_glu(AVG_GLU);
    -+patient_fam_his(FAM_HIS);
    -+patient_exc_frq(EXC_FRQ);
    -+patient_g1(G1);
    -+patient_g2(G2);
    -+patient_g3(G3);
    .print("Received patient's medical details from agent : ",AGENT).
    

+!calculate_risk_score: true <-
    .wait(1);
    ?patient_age(AGE);
    ?patient_bmi(BMI);
    ?patient_avg_glu(AVG_GLU);
    ?patient_fam_his(FAM_HIS);
    ?patient_exc_frq(EXC_FRQ);
    RiskScore = (AGE*0.25)+(BMI*0.25)+(AVG_GLU*0.75)+(FAM_HIS*0.5)+(EXC_FRQ*0.5);
    -+risk_score(RiskScore);
    .print("Calculated risk score: ", RiskScore).

+!calculate_genetic_score: true <-
    .wait(1);
    ?patient_g1(G1);
    ?patient_g2(G2);
    ?patient_g3(G3);
    GeneticScore = (G1*1.5)+(G2*1)+(G3*0.5);
    -+genetic_score(GeneticScore);
    .print("Calculated genetic score: ", GeneticScore).

+!getLifestyleMedications : true <-
    .wait(100);
    ?risk_score(RiskScore);
    ?genetic_score(GeneticScore);
    .send(lifeStyleRecommandationAgent, tell, risk_info(RiskScore, GeneticScore));
    .print("Sent risk and genetic score to lifestyle recommandation agent").

+recommanded(LifestyleChanges, Medication) : true <-
    -+lifestyleRecommandation(LifestyleChanges);
    -+medicationRecommandation(Medication);
    .print("Recieved risk and genetic score from lifeStyleRecommandationAgent").
    
+!send_recommandation_back : true <-
    .wait(500);
    ?lifestyleRecommandation(LifestyleChanges);
    ?medicationRecommandation(Medication);
    .send(john, tell, suggested(LifestyleChanges, Medication));
    .print("Sent lifestyle and medication recommandations to John").
