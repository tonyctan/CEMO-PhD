* Encoding: UTF-8.

**** ADMIN INFO *****
* Date: 10 July 2021
* Author: Tony Tan
* Email: tctan@uio.no
* Position: PhD Candidate
* Organisation: CEMO, UV, UiO
* Script purpose: Data cleaning--Teacher

***** DATA ATTRIBUTES *****
* ILSA: TIMSS
* Cycle: 2019
* Questionnaire: Teacher
* Grade: Grade 4
* Subject: Math and Science

***** Begin script *****

* Import data.
GET FILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\T19_G4_0_Merge_teacher.sav".

**************************
** Admin variables **
**************************
*1: Country ID - Numeric ISO Code.
RECODE
    IDCNTRY
        (9999999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDCNTRY
        (-99).

*2: Student Test Booklet.
RECODE
    IDBOOK
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDBOOK
        (-99).

*3: School ID.
RECODE
    IDSCHOOL
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDSCHOOL
        (-99).

*4: Class ID.
RECODE
    IDCLASS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDCLASS
        (-99).

*5: Student ID.
RECODE
    IDSTUD
        (99999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDSTUD
        (-99).

*6: Teacher ID and Link.
RECODE
    IDTEALIN
        (99999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDTEALIN
        (-99).

*7: Teacher ID.
RECODE
    IDTEACH
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDTEACH
        (-99).

*8: Teacher Link Number.
RECODE
    IDLINK
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDLINK
        (-99).

*9: Population ID.
RECODE
    IDPOP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDPOP
        (-99).

*10: Standardized Grade ID.
RECODE
    IDGRADER
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADER
        (-99).

*11: Grade ID.
RECODE
    IDGRADE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADE
        (-99).

*12: Subject ID.
RECODE
    IDSUBJ
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDSUBJ
        (-99).

*13: Subject Code in instrument.
RECODE
    ITCOURSE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ITCOURSE
        (-99).

*14: Mathematics Teacher Link.
RECODE
    MATSUBJ
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    MATSUBJ
        (-99).

*15: Science Teacher Link.
RECODE
    SCISUBJ
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    SCISUBJ
        (-99).

*16: Number of Math Teachers for Student.
RECODE
    NMTEACH
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    NMTEACH
        (-99).

*17: Number of Science Teachers for Student.
RECODE
    NSTEACH
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    NSTEACH
        (-99).

*18: Number of Teachers.
RECODE
    NTEACH
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    NTEACH
        (-99).

*19: WEIGHT FOR MATHEMATICS TEACHER DATA.
RECODE
    MATWGT
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    MATWGT
        (-99).

*20: WEIGHT FOR SCIENCE TEACHER DATA.
RECODE
    SCIWGT
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    SCIWGT
        (-99).

*20: JACKKNIFE REPLICATE CODE.
RECODE
    JKREP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKREP
        (-99).

*21: JACKKNIFE ZONE.
RECODE
    JKZONE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKZONE
        (-99).

**************************
** Teacher variables **
**************************

* G1: Years of teaching experience.
RECODE
    ATBG01
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBG01
        (-99).
RENAME VARIABLES (
    ATBG01 = YearTeach
    ).

* G2: Teacher gender.
RECODE
    ATBG02
        (1=0) (2=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG02
        0 'Female'
        1 'Male'.
MISSING VALUES
    ATBG02
        (-99).
RENAME VARIABLES (
    ATBG02 = TchMale
    ).

* G3: Teacher age.
RECODE
    ATBG03
         (1=0) (2=1) (3=2) (4=3) (5=4) (6=5)
         (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG03
       0 'Under 25'
       1 '25-29'
       2 '30-39'
       3 '40-49'
       4 '50-59'
       5 '60 or more' .
MISSING VALUES
    ATBG03
        (-99).
RENAME VARIABLES (
    ATBG03 = AgeTeach
    ).

* G4: Teacher level of education.
RECODE
    ATBG04
        (1=0)  (2=1) (3=2) (4=3) (5=4) (6=5) (7=6)
        (99=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
   ATBG04
       0 'Did not completed upper secondary'
       1 'Upper secondary'
       2 'Post-secondary or non-tertiary'
       3 'Short-cycle tertiary'
       4 'Bachelor'
       5 'Master'
       6 'Doctor'.
MISSING VALUES
    ATBG04
        (-99).
RENAME VARIABLES (
    ATBG04 = EduLevel
    ).

* G5A: Teacher major area of study.
RECODE
    ATBG05AA ATBG05AB ATBG05AC ATBG05AD ATBG05AE ATBG05AF
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG05AA ATBG05AB ATBG05AC ATBG05AD ATBG05AE ATBG05AF
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBG05AA ATBG05AB ATBG05AC ATBG05AD ATBG05AE ATBG05AF
        (-99).
RENAME VARIABLES (
    ATBG05AA ATBG05AB ATBG05AC ATBG05AD ATBG05AE ATBG05AF
    =
    MajPrim MajSec MajMath MajSci MajLang MajOther
    ).

* G5B: Teacher specialization area of study.
RECODE
    ATBG05BA ATBG05BB ATBG05BC ATBG05BD
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG05BA ATBG05BB ATBG05BC ATBG05BD
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBG05BA ATBG05BB ATBG05BC ATBG05BD
        (-99).
RENAME VARIABLES (
    ATBG05BA ATBG05BB ATBG05BC ATBG05BD
    =
    SpecMath SpecSci SpecLang SpecOther
    ).

* G6: School emphasis on academic success.
RECODE
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E ATBG06F
    ATBG06G ATBG06H ATBG06I ATBG06J ATBG06K ATBG06L
        (1=4)  (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E ATBG06F
    ATBG06G ATBG06H ATBG06I ATBG06J ATBG06K ATBG06L
        0 'Very low'
        1 'Low'
        2 'Medium'
        3 'High'
        4 'Very high'.
MISSING VALUES
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E ATBG06F
    ATBG06G ATBG06H ATBG06I ATBG06J ATBG06K ATBG06L
        (-99).
RENAME VARIABLES (
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E ATBG06F
    ATBG06G ATBG06H ATBG06I ATBG06J ATBG06K ATBG06L
    =
    STchUndT STchSucT STchExpT STchAbiT SParInvT SParComT
    SparExpT SParSupT SStudDesT SRchGoalT SResPeerT ScollabT
    ).

* G7: Safety and orderly school.
RECODE
    ATBG07A ATBG07B ATBG07C ATBG07D ATBG07E ATBG07F ATBG07G ATBG07H
    (1=3) (2=2) (3=1) (4=0)
    (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG07A ATBG07B ATBG07C ATBG07D ATBG07E ATBG07F ATBG07G ATBG07H
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ATBG07A ATBG07B ATBG07C ATBG07D ATBG07E ATBG07F ATBG07G ATBG07H
        (-99).
RENAME VARIABLES (
    ATBG07A ATBG07B ATBG07C ATBG07D ATBG07E ATBG07F ATBG07G ATBG07H
    =
    OSafeNgh OFeelSaf OSecPol OStdBhv OStdRes OResPro OClrRul ORulEnf
    ).

* G8: Teacher job satisfaction.
RECODE
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E
        0 'Never or almost never'
        1 'Sometimes'
        2 'Often'
        3 'Very often'.
MISSING VALUES
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E
        (-99).
RENAME VARIABLES (
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E
    =
    JContent JPurpose JEnthus JInspire JProud
    ).

* G9: Teaching limitation.
RECODE
    ATBG09A ATBG09B ATBG09C ATBG09D ATBG09E ATBG09F ATBG09G ATBG09H
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG09A ATBG09B ATBG09C ATBG09D ATBG09E ATBG09F ATBG09G ATBG09H
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disagree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ATBG09A ATBG09B ATBG09C ATBG09D ATBG09E ATBG09F ATBG09G ATBG09H
        (-99).
RENAME VARIABLES (
    ATBG09A ATBG09B ATBG09C ATBG09D ATBG09E ATBG09F ATBG09G ATBG09H
    =
    LManyStd LManyMat LManyHr LTimePrep LTimeAss LMchPres LChgCur LManyAdm
    ).

* G10A: Number of student in the class.
* G10B: Number of student in the class in Grade 4.
* G11: Number of students with language difficulties.
RECODE
    ATBG10A ATBG10B ATBG11
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBG10A ATBG10B ATBG11
        (-99).
RENAME VARIABLES (
    ATBG10A ATBG10B ATBG11
    =
    NStdCl NStdG4 NstdLang
    ).

* G12: Teaching practices.
RECODE
    ATBG12A ATBG12B ATBG12C ATBG12D ATBG12E ATBG12F ATBG12G ATBG12H
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG12A ATBG12B ATBG12C ATBG12D ATBG12E ATBG12F ATBG12G ATBG12H
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ATBG12A ATBG12B ATBG12C ATBG12D ATBG12E ATBG12F ATBG12G ATBG12H
        (-99).
RENAME VARIABLES (
    ATBG12A ATBG12B ATBG12C ATBG12D ATBG12E ATBG12F ATBG12G ATBG12H
    =
    PDalyLiv PExpAns PInsMat PBeyIns PClasDis PLnkKnow PPrbSolv PExpsIde
    ).

* G13: Students limitation.
RECODE
    ATBG13A ATBG13B ATBG13C ATBG13D ATBG13E ATBG13F ATBG13G ATBG13H
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG13A ATBG13B ATBG13C ATBG13D ATBG13E ATBG13F ATBG13G ATBG13H
        0 'A lot'
        1 'Some'
        2 'Not at all'.
MISSING VALUES
    ATBG13A ATBG13B ATBG13C ATBG13D ATBG13E ATBG13F ATBG13G ATBG13H
        (-99).
RENAME VARIABLES (
    ATBG13A ATBG13B ATBG13C ATBG13D ATBG13E ATBG13F ATBG13G ATBG13H
    =
    LLckKng LLckNut LLckSlep Labsent LDistStd LUninStd LMentImp LDifUnLg
    ).

* M1: Time spent on math instruction.
RECODE
    ATBM01
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBM01
        (-99).
RENAME VARIABLES (
    ATBM01 = MathTime
    ).

* M2: Math teaching practices.
RECODE
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E ATBM02F ATBM02G ATBM02H
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E ATBM02F ATBM02G ATBM02H
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E ATBM02F ATBM02G ATBM02H
        (-99).
RENAME VARIABLES (
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E ATBM02F ATBM02G ATBM02H
    =
    MTExpln MTSolve MTMemrz MTPract MTApply MTWork MTMixAb MTSameAb
    ).

* M3: Math teaching and access to calculator.
RECODE
    ATBM03
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM03
        0 'No, calculators are not permitted'
        1 'Yes, with restricted use'
        2 'Yes, with unrestricted use'.
MISSING VALUES
    ATBM03
        (-99).
RENAME VARIABLES (
    ATBM03 = MUseCal
    ).

* M4A: Mathteaching and access to computer.
RECODE
    ATBM04A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM04A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM04A
        (-99).
RENAME VARIABLES (
    ATBM04A = MPCAva
    ).

* M4B: Mathteaching and access to computer.
RECODE
    ATBM04BA ATBM04BB ATBM04BC
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM04BA ATBM04BB ATBM04BC
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM04BA ATBM04BB ATBM04BC
        (-99).
RENAME VARIABLES (
    ATBM04BA ATBM04BB ATBM04BC
    =
    MPCStd MPCClas MPCSch
    ).

* M4C: Math teaching using computer.
RECODE
    ATBM04CA ATBM04CB ATBM04CC ATBM04CD
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM04CA ATBM04CB ATBM04CC ATBM04CD
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every or almost every day'.
MISSING VALUES
    ATBM04CA ATBM04CB ATBM04CC ATBM04CD
        (-99).
RENAME VARIABLES (
    ATBM04CA ATBM04CB ATBM04CC ATBM04CD
    =
    MLpcClas MLpcLow MLpcHigh MLpcNeed
    ).

* M5A: Mathematics topics taught to use the TIMSS class.
* M5B: Mathematics topics taught to use the TIMSS class.
* M5C: Mathematics topics taught to use the TIMSS class.
RECODE
    ATBM05AA ATBM05AB ATBM05AC ATBM05AD ATBM05AE ATBM05AF ATBM05AG
    ATBM05BA ATBM05BB ATBM05BC ATBM05BD ATBM05BE ATBM05BF ATBM05BG
    ATBM05CA ATBM05CB ATBM05CC
        (1=1) (2=2) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM05AA ATBM05AB ATBM05AC ATBM05AD ATBM05AE ATBM05AF ATBM05AG
    ATBM05BA ATBM05BB ATBM05BC ATBM05BD ATBM05BE ATBM05BF ATBM05BG
    ATBM05CA ATBM05CB ATBM05CC
        0 'Not yet taught or just introduced'
        1 'Mostly taught before this year'
        2 'Mostly taught this year'.
MISSING VALUES
    ATBM05AA ATBM05AB ATBM05AC ATBM05AD ATBM05AE ATBM05AF ATBM05AG
    ATBM05BA ATBM05BB ATBM05BC ATBM05BD ATBM05BE ATBM05BF ATBM05BG
    ATBM05CA ATBM05CB ATBM05CC
        (-99).
RENAME VARIABLES (
    ATBM05AA ATBM05AB ATBM05AC ATBM05AD ATBM05AE ATBM05AF ATBM05AG
    ATBM05BA ATBM05BB ATBM05BC ATBM05BD ATBM05BE ATBM05BF ATBM05BG
    ATBM05CA ATBM05CB ATBM05CC
    =
    MTopNum MTopSim MTopFac MTopSent MTopPat MTopFrac MTopDec
    MTopLeng MTopMas MTopArea MTopLine MTopAngl MTopShap MTopDim
    MTopData MTopRep MTopConc
    ).

* M6A: Time for math homework.
RECODE
    ATBM06A
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM06A
        0 'I do not assign mathematics homework'
        1 'Less than once a week'
        2 '1 or 2 times a week'
        3 '3 or 4 times a week'
        4 'Every day'.
MISSING VALUES
    ATBM06A
        (-99).
RENAME VARIABLES (
    ATBM06A = MHomeW
    ).

* M6B: Time for math homework.
RECODE
    ATBM06B
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM06B
        0 '15 minutes or less'
        1 '16--30 minutes'
        2 '31--60 minutes'
        3 'More than 60 minutes'.
MISSING VALUES
    ATBM06B
        (-99).
RENAME VARIABLES (
    ATBM06B = MTimeHW
    ).

* M6C: Assessing mathematics homework.
RECODE
    ATBM06CA ATBM06CB ATBM06CC
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM06CA ATBM06CB ATBM06CC
        0 'Never or almost never'
        1 'Sometimes'
        2 'Always or almost always'.
MISSING VALUES
    ATBM06CA ATBM06CB ATBM06CC
        (-99).
RENAME VARIABLES (
    ATBM06CA ATBM06CB ATBM06CC
    =
    MHWCor MHWDis MHWMntr
    ).

* M7: Math assessment strategies.
RECODE
    ATBM07A ATBM07B ATBM07C ATBM07D ATBM07E
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM07A ATBM07B ATBM07C ATBM07D ATBM07E
        0 'None'
        1 'Some'
        2 'A lot'.
MISSING VALUES
    ATBM07A ATBM07B ATBM07C ATBM07D ATBM07E
        (-99).
RENAME VARIABLES (
    ATBM07A ATBM07B ATBM07C ATBM07D ATBM07E
    =
    MAsObs MAsAsk MAsShort MAsLgTest MAsLgPro
    ).

* M8: Math test on computer.
RECODE
    ATBM08
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM08
        0 'None'
        1 'Once a year'
        2 'Twice a year'
        3 'Once a month'
        4 'More than once a month'.
MISSING VALUES
    ATBM08
        (-99).
RENAME VARIABLES (
    ATBM08 = MTestPC
    ).

* M9: PD to teach mathematics: Past experience (A) and future needs (B).
RECODE
    ATBM09AA ATBM09BA ATBM09AB ATBM09BB ATBM09AC ATBM09BC ATBM09AD
    ATBM09BD ATBM09AE ATBM09BE ATBM09AF ATBM09BF ATBM09AG ATBM09BG
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM09AA ATBM09BA ATBM09AB ATBM09BB ATBM09AC ATBM09BC ATBM09AD
    ATBM09BD ATBM09AE ATBM09BE ATBM09AF ATBM09BF ATBM09AG ATBM09BG
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM09AA ATBM09BA ATBM09AB ATBM09BB ATBM09AC ATBM09BC ATBM09AD
    ATBM09BD ATBM09AE ATBM09BE ATBM09AF ATBM09BF ATBM09AG ATBM09BG
        (-99).
RENAME VARIABLES (
    ATBM09AA ATBM09BA ATBM09AB ATBM09BB ATBM09AC ATBM09BC ATBM09AD
    ATBM09BD ATBM09AE ATBM09BE ATBM09AF ATBM09BF ATBM09AG ATBM09BG
    =
    MPDPCont MPDFCont MPDPPed MPDFPed MPDPCur MPDFCur MPDPTech
    MPDFTech MPDPProb MPDFProb MPDPAss MPDFAss MPDPNeed MPDFNeed
    ).

* M10: Number of PD hours in mathematics.
RECODE
    ATBM10
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM10
        0 'None'
        1 'Less than 6 hours'
        2 '6--15 hours'
        3 '16--35 hours'
        4 'More than 35 hours'.
MISSING VALUES
    ATBM10
        (-99).
RENAME VARIABLES (
    ATBM10 = MPDHour
    ).

* S1A: Separate or integrated science teaching.
RECODE
    ATBS01A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS01A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS01A
        (-99).
RENAME VARIABLES (
    ATBS01A = SciSub
    ).

* S1B: Time spent on science instruction.
RECODE
    ATBS01B
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBS01B
        (-99).
RENAME VARIABLES (
    ATBS01B = STime
    ).

* S2: Science teaching practices.
RECODE
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E ATBS02F ATBS02G
    ATBS02H ATBS02I ATBS02J ATBS02K ATBS02L ATBS02M
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E ATBS02F ATBS02G
    ATBS02H ATBS02I ATBS02J ATBS02K ATBS02L ATBS02M
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E ATBS02F ATBS02G
    ATBS02H ATBS02I ATBS02J ATBS02K ATBS02L ATBS02M
        (-99).
RENAME VARIABLES (
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E ATBS02F ATBS02G
    ATBS02H ATBS02I ATBS02J ATBS02K ATBS02L ATBS02M
    =
    STExp STObs STDem STPlanEx STConEx STPreDat STIntDat
    STUseEvi STReadTx STFact STFieldW STMixAb STSamAb
    ).

* S3A: Science teaching and computer availability.
RECODE
    ATBS03A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS03A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS03A
        (-99).
RENAME VARIABLES (
    ATBS03A = SPCAva
    ).

* S3B: Science teaching and access to computer.
RECODE
    ATBS03BA ATBS03BB ATBS03BC
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS03BA ATBS03BB ATBS03BC
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS03BA ATBS03BB ATBS03BC
        (-99).
RENAME VARIABLES (
    ATBS03BA ATBS03BB ATBS03BC
    =
    SPCStd SPCClas SPCSch
    ).

* S3C: Science teaching using computer.
RECODE
    ATBS03CA ATBS03CB ATBS03CC ATBS03CD
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS03CA ATBS03CB ATBS03CC ATBS03CD
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every or almost every day'.
MISSING VALUES
    ATBS03CA ATBS03CB ATBS03CC ATBS03CD
        (-99).
RENAME VARIABLES (
    ATBS03CA ATBS03CB ATBS03CC ATBS03CD
    =
    SLpcClas SLpcLow SLpcHigh SLpcNeed
    ).

* S4: Science topics taught to the TIMSS class.
RECODE
    ATBS04AA ATBS04AB ATBS04AC ATBS04AD ATBS04AE ATBS04AF ATBS04AG
    ATBS04BA ATBS04BB ATBS04BC ATBS04BD ATBS04BE ATBS04BF ATBS04BG
    ATBS04BH ATBS04BI ATBS04BJ ATBS04BK ATBS04BL
    ATBS04CA ATBS04CB ATBS04CC ATBS04CD ATBS04CE ATBS04CF ATBS04CG
        (1=1) (2=2) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS04AA ATBS04AB ATBS04AC ATBS04AD ATBS04AE ATBS04AF ATBS04AG
    ATBS04BA ATBS04BB ATBS04BC ATBS04BD ATBS04BE ATBS04BF ATBS04BG
    ATBS04BH ATBS04BI ATBS04BJ ATBS04BK ATBS04BL
    ATBS04CA ATBS04CB ATBS04CC ATBS04CD ATBS04CE ATBS04CF ATBS04CG
        0 'Not yet taught or just introduced'
        1 'Mostly taught before this year'
        2 'Mostly taught this year'.
MISSING VALUES
    ATBS04AA ATBS04AB ATBS04AC ATBS04AD ATBS04AE ATBS04AF ATBS04AG
    ATBS04BA ATBS04BB ATBS04BC ATBS04BD ATBS04BE ATBS04BF ATBS04BG
    ATBS04BH ATBS04BI ATBS04BJ ATBS04BK ATBS04BL
    ATBS04CA ATBS04CB ATBS04CC ATBS04CD ATBS04CE ATBS04CF ATBS04CG
        (-99).
RENAME VARIABLES (
    ATBS04AA ATBS04AB ATBS04AC ATBS04AD ATBS04AE ATBS04AF ATBS04AG
    ATBS04BA ATBS04BB ATBS04BC ATBS04BD ATBS04BE ATBS04BF ATBS04BG
    ATBS04BH ATBS04BI ATBS04BJ ATBS04BK ATBS04BL
    ATBS04CA ATBS04CB ATBS04CC ATBS04CD ATBS04CE ATBS04CF ATBS04CG
    =
    STopLiv STopBody STopLife STopPlan STopOrg STopEco STopHum
    STopMat STopClas STopMix STopMag STopPhy STopChe STopEne
    STopLigt STopHeat STopElec STopForc STopMach
    STopEart STopReso STopSurf STopFosl STopClmt STopSolr STopMotn
    ).

* S5A: Time for science homework.
RECODE
    ATBS05A
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS05A
        0 'I do not assign science homework'
        1 'Less than one a week'
        2 '1 or 2 times a week'
        3 '3 or 4 times a week'
        4 'Every day'.
MISSING VALUES
    ATBS05A
        (-99).
RENAME VARIABLES (
    ATBS05A = SHomeW
    ).

* S5B: Time for science homework.
RECODE
    ATBS05B
        (1=0) (2=1) (3=2) (4=3)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS05B
        0 '15 minutes or less'
        1 '16--30 minutes'
        2 '31--60 minutes'
        3 'More than 60 minutes'.
MISSING VALUES
    ATBS05B
        (-99).
RENAME VARIABLES (
    ATBS05B = STimeHW
    ).

* S5C: Assessing science homework.
RECODE
    ATBS05CA ATBS05CB ATBS05CC
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS05CA ATBS05CB ATBS05CC
        0 'Never or almost never'
        1 'Sometimes'
        2 'Always or almost always'.
MISSING VALUES
    ATBS05CA ATBS05CB ATBS05CC
        (-99).
RENAME VARIABLES (
    ATBS05CA ATBS05CB ATBS05CC
    =
    SHWCor SHWDis SHWMntr
    ).

* S6: Science assessment strategies.
RECODE
    ATBS06A ATBS06B ATBS06C ATBS06D ATBS06E
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS06A ATBS06B ATBS06C ATBS06D ATBS06E
        0 'None'
        1 'Some'
        2 'A lot'.
MISSING VALUES
    ATBS06A ATBS06B ATBS06C ATBS06D ATBS06E
        (-99).
RENAME VARIABLES (
    ATBS06A ATBS06B ATBS06C ATBS06D ATBS06E
    =
    SAsObs SAsAsk SAsShort SAsLgTest SAsLgPro
    ).

* S7: Science assessment strategies.
RECODE
    ATBS07
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS07
        0 'Never'
        1 'Once a year'
        2 'Twice a year'
        3 'Once a month'
        4 'More than once a month'.
MISSING VALUES
    ATBS07
        (-99).
RENAME VARIABLES (
    ATBS07 = STestPC
    ).

* S8: PD to teach science: Past experience (A) and future needs (B).
RECODE
    ATBS08AA ATBS08BA ATBS08AB ATBS08BB ATBS08AC ATBS08BC ATBS08AD ATBS08BD
    ATBS08AE ATBS08BE ATBS08AF ATBS08BF ATBS08AG ATBS08BG ATBS08AH ATBS08BH
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS08AA ATBS08BA ATBS08AB ATBS08BB ATBS08AC ATBS08BC ATBS08AD ATBS08BD
    ATBS08AE ATBS08BE ATBS08AF ATBS08BF ATBS08AG ATBS08BG ATBS08AH ATBS08BH
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS08AA ATBS08BA ATBS08AB ATBS08BB ATBS08AC ATBS08BC ATBS08AD ATBS08BD
    ATBS08AE ATBS08BE ATBS08AF ATBS08BF ATBS08AG ATBS08BG ATBS08AH ATBS08BH
        (-99).
RENAME VARIABLES (
    ATBS08AA ATBS08BA ATBS08AB ATBS08BB ATBS08AC ATBS08BC ATBS08AD ATBS08BD
    ATBS08AE ATBS08BE ATBS08AF ATBS08BF ATBS08AG ATBS08BG ATBS08AH ATBS08BH
    =
    SPDPCont SPDFCont SPDPPed SPDFPed SPDPCur SPDFCur SPDPTech SPDFTech
    SPDPProb SPDFProb SPDPAss SPDFAss SPDPNeed SPDFNeed SPDPIntg SPDFIntg
    ).

* S9: Number of PD hours in science.
RECODE
    ATBS09
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS09
        0 'None'
        1 'Less than 6 hours'
        2 '6--15 hours'
        3 '16--35 hours'
        4 'More than 35 hours'.
MISSING VALUES
    ATBS09
        (-99).
RENAME VARIABLES (
    ATBS09 = SPDHour
    ).

**************************
** Compound variables **
**************************

* Language of teacher questionnaire.
RECODE
    ITLANG_T
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ITLANG_T
        (-99).

* Locale ID of teacher questionnaire.
RECODE
    LCID_T
        (9999999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    LCID_T
        (-99).

* TIMSS compound variables: SEAS.
RECODE
    ATBGEAS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGEAS
        (-99).
RENAME VARIABLES (
    ATBGEAS = SCLSeasT
    ).

RECODE
    ATDGEAS
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGEAS
        0 'Medium emphasis'
        1 'High emphasis'
        2 'Very high emphasis'.
MISSING VALUES
    ATDGEAS
        (-99).
RENAME VARIABLES (
    ATDGEAS = IDXSeasT
    ).

* TIMSS compound variables: Safe and orderly school.
RECODE
    ATBGSOS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGSOS
        (-99).
RENAME VARIABLES (
    ATBGSOS = SCLSafe
    ).

RECODE
    ATDGSOS
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGSOS
        0 'Less than safe and orderly'
        1 'Somewhat safe and orderly'
        2 'Very safe and orderly'.
MISSING VALUES
    ATDGSOS
        (-99).
RENAME VARIABLES (
    ATDGSOS = IDXSafe
    ).

* TIMSS compound variables: Teacher job satisfaction.
RECODE
    ATBGTJS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGTJS
        (-99).
RENAME VARIABLES (
    ATBGTJS = SCLJob
    ).

RECODE
    ATDGTJS
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGTJS
        0 'Less than satisfied'
        1 'Somewhat satisfied'
        2 'Very satisfied'.
MISSING VALUES
    ATDGTJS
        (-99).
RENAME VARIABLES (
    ATDGTJS = IDXJob
    ).

* TIMSS compound variables: Teaching limited by students not ready.
RECODE
    ATBGLSN
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGLSN
        (-99).
RENAME VARIABLES (
    ATBGLSN = SCLLimit
    ).

RECODE
    ATDGLSN
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGLSN
        0 'A lot'
        1 'Some'
        2 'Very little'.
MISSING VALUES
    ATDGLSN
        (-99).
RENAME VARIABLES (
    ATDGLSN = IDXLimit
    ).

* TIMSS compound variables: Teacher emphasis on science investigation.
RECODE
    ATBSESI
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBSESI
        (-99).
RENAME VARIABLES (
    ATBSESI = SCLExprm
    ).

RECODE
    ATDSESI
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDSESI
        0 'Less than half the lessons'
        1 'About half the lessons or more'.
MISSING VALUES
    ATDSESI
        (-99).
RENAME VARIABLES (
    ATDSESI = IDXExprm
    ).

* Percent of students taught math topics.
RECODE
    ATDMNUM ATDMGEO ATDMDAT
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDMNUM ATDMGEO ATDMDAT
        (-99).
RENAME VARIABLES (
    ATDMNUM ATDMGEO ATDMDAT
    =
    PTpNumb PTpGeo PTpData
    ).

* Percent of teachers majored in education and math.
RECODE
    ATDMMEM
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDMMEM
        0 'No formal education beyond upper secondary'
        1 'All other majors'
        2 'Major in mathematics but not education'
        3 'Major in education but not mathematics'
        4 'Major in education and mathematics'.
MISSING VALUES
    ATDMMEM
        (-99).
RENAME VARIABLES (
    ATDMMEM = MTchMjr
    ).

* Percent of students taught science topics.
RECODE
    ATDSLIF ATDSPHY ATDSEAR
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDSLIF ATDSPHY ATDSEAR
        (-99).
RENAME VARIABLES (
    ATDSLIF ATDSPHY ATDSEAR
    =
    PTpLife PTpPhys PTpEarth
    ).

* Percent of teachers majored in education and science.
RECODE
    ATDSMES
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDSMES
        0 'No formal education beyond upper secondary'
        1 'All other majors'
        2 'Major in science but not education'
        3 'Major in education but not science'
        4 'Major in education and science'.
MISSING VALUES
    ATDSMES
        (-99).
RENAME VARIABLES (
    ATDSMES = STchMjr
    ).

* Run script.
EXECUTE.

* Remove unwanted variable(s).
DELETE VARIABLES
    ASMMAT01
    ASMMAT02
    ASMMAT03
    ASMMAT04
    ASMMAT05
    ASSSCI01
    ASSSCI02
    ASSSCI03
    ASSSCI04
    ASSSCI05
    ASMNUM01
    ASMNUM02
    ASMNUM03
    ASMNUM04
    ASMNUM05
    ASMGEO01
    ASMGEO02
    ASMGEO03
    ASMGEO04
    ASMGEO05
    ASMDAT01
    ASMDAT02
    ASMDAT03
    ASMDAT04
    ASMDAT05
    ASMKNO01
    ASMKNO02
    ASMKNO03
    ASMKNO04
    ASMKNO05
    ASMAPP01
    ASMAPP02
    ASMAPP03
    ASMAPP04
    ASMAPP05
    ASMREA01
    ASMREA02
    ASMREA03
    ASMREA04
    ASMREA05
    ASSLIF01
    ASSLIF02
    ASSLIF03
    ASSLIF04
    ASSLIF05
    ASSPHY01
    ASSPHY02
    ASSPHY03
    ASSPHY04
    ASSPHY05
    ASSEAR01
    ASSEAR02
    ASSEAR03
    ASSEAR04
    ASSEAR05
    ASSKNO01
    ASSKNO02
    ASSKNO03
    ASSKNO04
    ASSKNO05
    ASSAPP01
    ASSAPP02
    ASSAPP03
    ASSAPP04
    ASSAPP05
    ASSREA01
    ASSREA02
    ASSREA03
    ASSREA04
    ASSREA05
    ASSENV01
    ASSENV02
    ASSENV03
    ASSENV04
    ASSENV05
    ASMIBM01
    ASMIBM02
    ASMIBM03
    ASMIBM04
    ASMIBM05
    ASSIBM01
    ASSIBM02
    ASSIBM03
    ASSIBM04
    ASSIBM05
    VERSION
    SCOPE
    idbid
    .

* Update data set.
SAVE OUTFILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\T19_G4_3_Teacher.sav".

***** End script *****
