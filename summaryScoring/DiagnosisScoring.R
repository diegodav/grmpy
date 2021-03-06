###################################################################################################
##########################      GRMPY - Summary Scores - Diagnosis       ##########################
##########################               Robert Jirsaraie                ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                 06/03/2016                    ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
# Use #

## This script was created to generate a CSV of Diagnoses from a subsample of 144 GRMPY subjects. Data must first 
# be downloaded from Psych1 and SCP onto CfN before running this script.

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

###############################################################################
##### Read in the Raw Diagnosis Data and the RDS Files To Transfer Output #####
###############################################################################

library(car)
raw<-read.csv("/data/jux/BBL/studies/grmpy/rawPsycha1/diagnosis_wsmryvars_20180626.csv")
TP2covars<-readRDS("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n141_TP2_NMF/n141_Demo+ARI+QA_20180322.rds")
Ratecovars<-readRDS("/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n137_Rate_NMF/n137_Demo+ARI+QA_20180401.rds")

################################################
##### Refine the Raw Diagnosis Spreadsheet #####
################################################

diagnosis<-raw[,c(1,grep("dx",names(raw)))]
names(diagnosis)[1]<-c("bblid")

TP2diagnosis<-diagnosis[which(diagnosis$bblid %in% TP2covars$bblid),]
RATEdiagnosis<-diagnosis[which(diagnosis$bblid %in% Ratecovars$bblid),]

TP2diagnosis[,2:21] <- lapply(TP2diagnosis[,2:21], as.numeric)
RATEdiagnosis[,2:21] <- lapply(RATEdiagnosis[,2:21], as.numeric)

TP2diagnosis$dx_pscat<-NULL
RATEdiagnosis$dx_pscat<-NULL

###############################################################
##### Check and Relabel Subjects with a Missing Diagnosis #####
###############################################################

TP2diagnosis$Missing<-rowSums(TP2diagnosis[,2:21])
which(TP2diagnosis$Missing==0)
TP2diagnosis$Missing<-NULL

RATEdiagnosis$Missing<-rowSums(RATEdiagnosis[,2:21])
which(RATEdiagnosis$Missing==0)
RATEdiagnosis$Missing<-NULL

################################################
##### Make New Diagnosis Vars For Analysis #####
################################################

# Creates A Variable for Overall Number of Disorders for Each Subject

TP2diagnosis$Binary<-rowSums(TP2diagnosis[,5:21])
RATEdiagnosis$Binary<-rowSums(RATEdiagnosis[,5:21])


TP2diagnosis$Sum<-apply(TP2diagnosis[names(TP2diagnosis)[grep("^dx_",names(TP2diagnosis))]],1,sum)
RATEdiagnosis$Sum<-apply(RATEdiagnosis[names(RATEdiagnosis)[grep("^dx_",names(RATEdiagnosis))]],1,sum)

# This Binary Variable 0: Healthy Controls
TP2diagnosis$BIN_HC<-TP2diagnosis$Sum
TP2diagnosis[which(TP2diagnosis$BIN_HC>=1),14]<-1 
RATEdiagnosis$BIN_HC<-RATEdiagnosis$Sum
RATEdiagnosis[which(RATEdiagnosis$BIN_HC>=1),14]<-1

# This Binary Varaible 0: Healthy Controls and Prodromal
TP2diagnosis$BIN_HC_PRO<-rowSums(TP2diagnosis[,3:12])
TP2diagnosis[which(TP2diagnosis$BIN_HC_PRO>=1),15]<-1
RATEdiagnosis$BIN_HC_PRO<-rowSums(RATEdiagnosis[,3:12])
RATEdiagnosis[which(RATEdiagnosis$BIN_HC_PRO>=1),15]<-1

# This Multi-level Factor Creates a Level for Each Disorder
TP2diagnosis$MultiFULL<-0
TP2diagnosis$MultiFULL[TP2diagnosis$dx_prodromal==1] <- 1 # Level 1: Psychosis and Prodromal and Schizophrenia
TP2diagnosis$MultiFULL[TP2diagnosis$dx_psychosis==1] <- 1 
TP2diagnosis$MultiFULL[TP2diagnosis$dx_dx_scz==1] <- 1 
TP2diagnosis$MultiFULL[TP2diagnosis$dx_moodnos==1] <- 2 # level 2: Mood Disorder
TP2diagnosis$MultiFULL[TP2diagnosis$dx_mdd==1] <- 3 #level 3: Major Depression
TP2diagnosis$MultiFULL[TP2diagnosis$dx_bp1==1] <- 4 #level 4: Bipolar 1 and bpOTH
TP2diagnosis$MultiFULL[TP2diagnosis$dx_bpoth==1] <- 4
TP2diagnosis$MultiFULL[TP2diagnosis$dx_adhd==1] <- 5 #level 5: ADHD
TP2diagnosis$MultiFULL[TP2diagnosis$dx_anx==1] <- 6 #level 6: Anxiety
TP2diagnosis$MultiFULL[TP2diagnosis$dx_sub_dep==1] <- 7 #level 7: Substance Depedence ALH+CAN+OTH
TP2diagnosis$MultiFULL[TP2diagnosis$dx_sub_abuse==1] <- 8 #level 8: Substance Abuse ALH+CAN+OTH
TP2diagnosis$MultiFULL[TP2diagnosis$Sum>=2] <- 9 #level 9: More than 1 Disorder

RATEdiagnosis$MultiFULL<-0
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_prodromal==1] <- 1 # Level 1: Psychosis and Prodromal and Schizophrenia
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_psychosis==1] <- 1 
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_dx_scz==1] <- 1 
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_moodnos==1] <- 2 # level 2: Mood Disorder
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_mdd==1] <- 3 #level 3: Major Depression
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_bp1==1] <- 4 #level 4: Bipolar 1 and bpOTH
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_bpoth==1] <- 4
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_adhd==1] <- 5 #level 5: ADHD
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_anx==1] <- 6 #level 6: Anxiety
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_sub_dep==1] <- 7 #level 7: Substance Depedence ALH+CAN+OTH
RATEdiagnosis$MultiFULL[RATEdiagnosis$dx_sub_abuse==1] <- 8 #level 8: Substance Abuse ALH+CAN+OTH
RATEdiagnosis$MultiFULL[RATEdiagnosis$Sum>=2] <- 9 #level 9: More than 1 Disorder

##########################################
##### Reclassify Varibles as Factors #####
##########################################

TP2diagnosis[,2:16] <- lapply(TP2diagnosis[,2:16] , factor)
RATEdiagnosis[,2:16] <- lapply(RATEdiagnosis[,2:16] , factor)

####################################################################
##### Merge the Diagnosis Data with the Covariate Spreadsheets #####
####################################################################

TP2final<-merge(TP2covars,TP2diagnosis, by= c("bblid"))
RATEfinal<-merge(Ratecovars,RATEdiagnosis, by= c("bblid"))

####################################
##### Save Master Spreadsheets #####
####################################

saveRDS(TP2final, "/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n141_TP2_NMF/n141_DIAGNOSIS_20180603.rds")
saveRDS(RATEfinal, "/data/jux/BBL/projects/jirsaraieStructuralIrrit/data/n137_Rate_NMF/n137_DIAGNOSIS_20180603.rds")

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
