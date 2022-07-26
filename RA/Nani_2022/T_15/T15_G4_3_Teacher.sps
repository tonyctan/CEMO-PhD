* Encoding: UTF-8.

**** ADMIN INFO *****
* Date: 19 July 2021
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
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\T15_G4_0_Merge_teacher.sav".

**************************
** Admin variables **
**************************

*1: Country ID - Numeric ISO Code.
RECODE
    IDCNTRY
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
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

*6: Teacher ID.
RECODE
    IDTEACH
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDTEACH
        (-99).

*7: Teacher Link Number.
RECODE
    IDLINK
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDLINK
        (-99).

*8: Teacher ID and Link.
RECODE
    IDTEALIN
        (99999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDTEALIN
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
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ITCOURSE
        (-99).

*14: Mathematics Teacher Link.
RECODE
    MATSUBJ
        (9=-99) (SYSMIS=-99) (MISSING=-99).
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
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    NTEACH
        (-99).

*19: JACKKNIFE REPLICATE CODE.
RECODE
    JKREP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKREP
        (-99).

*20: JACKKNIFE ZONE.
RECODE
    JKZONE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKZONE
        (-99).

*21: WEIGHT FOR MATHEMATICS TEACHER DATA.
RECODE
    MATWGT
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    MATWGT
        (-99).

*22: WEIGHT FOR SCIENCE TEACHER DATA.
RECODE
    SCIWGT
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    SCIWGT
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
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E
    ATBG06F ATBG06G ATBG06H ATBG06I ATBG06J
    ATBG06K ATBG06L ATBG06M ATBG06N ATBG06O
    ATBG06P ATBG06Q
        (1=4)  (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E
    ATBG06F ATBG06G ATBG06H ATBG06I ATBG06J
    ATBG06K ATBG06L ATBG06M ATBG06N ATBG06O
    ATBG06P ATBG06Q
        0 'Very low'
        1 'Low'
        2 'Medium'
        3 'High'
        4 'Very high'.
MISSING VALUES
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E
    ATBG06F ATBG06G ATBG06H ATBG06I ATBG06J
    ATBG06K ATBG06L ATBG06M ATBG06N ATBG06O
    ATBG06P ATBG06Q
        (-99).
RENAME VARIABLES (
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E
    ATBG06F ATBG06G ATBG06H ATBG06I ATBG06J
    ATBG06K ATBG06L ATBG06M ATBG06N ATBG06O
    ATBG06P ATBG06Q
    =
    STchUndT STchSucT STchExpT STchAbiT STchInsT
    SParInvT SParComT SparExpT SParSupT SParPreT
    SStudDesT SRchGoalT SResPeerT SClaObjT SCollabT
    SInstSupT SLeadSupT
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

* G8: Teaching constraint.
RECODE
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E ATBG08F ATBG08G
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E ATBG08F ATBG08G
        0 'Serious problem'
        1 'Modrate problem'
        2 'Minor problem'
        3 'Not a problem'.
MISSING VALUES
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E ATBG08F ATBG08G
        (-99).
RENAME VARIABLES (
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E ATBG08F ATBG08G
    =
    ConBuil ConSpac ConMate ConHyge ConMain ConReso ConSupp
    ).

* G9: Teacher interaction.
RECODE
    ATBG09A ATBG09B ATBG09C ATBG09D ATBG09E ATBG09F ATBG09G
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG09A ATBG09B ATBG09C ATBG09D ATBG09E ATBG09F ATBG09G
        0 'Never or almost never'
        1 'Sometimes'
        2 'Often'
        3 'Very often'.
MISSING VALUES
    ATBG09A ATBG09B ATBG09C ATBG09D ATBG09E ATBG09F ATBG09G
        (-99).
RENAME VARIABLES (
    ATBG09A ATBG09B ATBG09C ATBG09D ATBG09E ATBG09F ATBG09G
    =
    IntDisc IntColl IntLear IntVisi IntToge IntGpCu IntCont
    ).

* G10: Teacher job satisfaction.
RECODE
    ATBG10A ATBG10B ATBG10C ATBG10D ATBG10E ATBG10F ATBG10G
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG10A ATBG10B ATBG10C ATBG10D ATBG10E ATBG10F ATBG10G
        0 'Never or almost never'
        1 'Sometimes'
        2 'Often'
        3 'Very often'.
MISSING VALUES
    ATBG10A ATBG10B ATBG10C ATBG10D ATBG10E ATBG10F ATBG10G
        (-99).
RENAME VARIABLES (
    ATBG10A ATBG10B ATBG10C ATBG10D ATBG10E ATBG10F ATBG10G
    =
    JContent Jsatisfi JPurpose JEnthus JInspire JProud Jcontinu
    ).

* G11: Teaching limitation.
RECODE
    ATBG11A ATBG11B ATBG11C ATBG11D ATBG11E ATBG11F ATBG11G ATBG11H
        (1=0) (2=1) (3=2) (4=3) 
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG11A ATBG11B ATBG11C ATBG11D ATBG11E ATBG11F ATBG11G ATBG11H
        0 'Never or almost never'
        1 'Sometimes'
        2 'Often'
        3 'Very often'.
MISSING VALUES
    ATBG11A ATBG11B ATBG11C ATBG11D ATBG11E ATBG11F ATBG11G ATBG11H
        (-99).
RENAME VARIABLES (
    ATBG11A ATBG11B ATBG11C ATBG11D ATBG11E ATBG11F ATBG11G ATBG11H
    =
    LManyStd LManyMat LManyHr LTimePrep LTimeAss LMchPres LChgCur LManyAdm
    ).

* G12A: Number of students in class.
* G12B: Number of students in Grade 4class.
* G13: Number of students with language difficulties.
RECODE
    ATBG12A ATBG12B ATBG13
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBG12A ATBG12B ATBG13
        (-99).
RENAME VARIABLES (
    ATBG12A ATBG12B ATBG13
    =
    NStdCl NStdG4 NStdLang
    ).

* G14: Teaching practices.
RECODE
    ATBG14A ATBG14B ATBG14C ATBG14D ATBG14E ATBG14F ATBG14G ATBG14H
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG14A ATBG14B ATBG14C ATBG14D ATBG14E ATBG14F ATBG14G ATBG14H
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ATBG14A ATBG14B ATBG14C ATBG14D ATBG14E ATBG14F ATBG14G ATBG14H
        (-99).
RENAME VARIABLES (
    ATBG14A ATBG14B ATBG14C ATBG14D ATBG14E ATBG14F ATBG14G ATBG14H
    =
    PDalyLiv PExpAns PInsMat PBeyIns PClasDis PLnkKnow PPrbSolv PExpsIde
    ).

* G15: Students limitation.
RECODE
    ATBG15A ATBG15B ATBG15C ATBG15D ATBG15E ATBG15F ATBG15G
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG15A ATBG15B ATBG15C ATBG15D ATBG15E ATBG15F ATBG15G
        0 'A lot'
        1 'Some'
        2 'Not at all'.
MISSING VALUES
    ATBG15A ATBG15B ATBG15C ATBG15D ATBG15E ATBG15F ATBG15G
        (-99).
RENAME VARIABLES (
    ATBG15A ATBG15B ATBG15C ATBG15D ATBG15E ATBG15F ATBG15G
    =
    LLckKng LLckNut LLckSlep LDistStd LUninStd LPhysImp LMentImp
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

* M2: Math teaching confidence.
RECODE
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E ATBM02F ATBM02G ATBM02H ATBM02I
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E ATBM02F ATBM02G ATBM02H ATBM02I
        0 'Low'
        1 'Medium'
        2 'High'
        3 'Very high'.
MISSING VALUES
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E ATBM02F ATBM02G ATBM02H ATBM02I
        (-99).
RENAME VARIABLES (
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E ATBM02F ATBM02G ATBM02H ATBM02I
    =
    MCfInsp MCfProb MCfChal MCfEnga MCfAppr MCfAss MCfImpr MCfRele MCfHgTh
    ).

* M3: Math teaching practices.
RECODE
    ATBM03A ATBM03B ATBM03C ATBM03D ATBM03E ATBM03F ATBM03G ATBM03H ATBM03I
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM03A ATBM03B ATBM03C ATBM03D ATBM03E ATBM03F ATBM03G ATBM03H ATBM03I
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
     ATBM03A ATBM03B ATBM03C ATBM03D ATBM03E ATBM03F ATBM03G ATBM03H ATBM03I
        (-99).
RENAME VARIABLES (
     ATBM03A ATBM03B ATBM03C ATBM03D ATBM03E ATBM03F ATBM03G ATBM03H ATBM03I
    =
    MTExpln MTSolve MTMemrz MTGuid MTWork MTOccup MTTest MTMixAb MTSameAb
    ).

* M4: Math teaching and access to calculator.
RECODE
    ATBM04
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM04
        0 'No, calculators are not permitted'
        1 'Yes, with restricted use'
        2 'Yes, with unrestricted use'.
MISSING VALUES
    ATBM04
        (-99).
RENAME VARIABLES (
    ATBM04 = MUseCal
    ).

* M5A: Mathteaching and access to computer.
RECODE
    ATBM05A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM05A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM05A
        (-99).
RENAME VARIABLES (
    ATBM05A = MPCAva
    ).

* M5B: Mathteaching and access to computer.
RECODE
    ATBM05BA ATBM05BB ATBM05BC
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM05BA ATBM05BB ATBM05BC
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM05BA ATBM05BB ATBM05BC
        (-99).
RENAME VARIABLES (
    ATBM05BA ATBM05BB ATBM05BC
    =
    MPCStd MPCClas MPCSch
    ).

* M5C: Math teaching using computer.
RECODE
    ATBM05CA ATBM05CB ATBM05CC
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM05CA ATBM05CB ATBM05CC
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every or almost every day'.
MISSING VALUES
    ATBM05CA ATBM05CB ATBM05CC
        (-99).
RENAME VARIABLES (
    ATBM05CA ATBM05CB ATBM05CC
    =
    MPCConc MPCPrac MPCSear
    ).

* M6A: Mathematics topics taught to use the TIMSS class: Number.
* M6B: Mathematics topics taught to use the TIMSS class: Geometric shapes and measures.
* M6C: Mathematics topics taught to use the TIMSS class: Data display.
RECODE
    ATBM06AA ATBM06AB ATBM06AC ATBM06AD ATBM06AE ATBM06AF ATBM06AG ATBM06AH
    ATBM06BA ATBM06BB ATBM06BC ATBM06BD ATBM06BE ATBM06BF ATBM06BG
    ATBM06CA ATBM06CB
        (1=1) (2=2) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM06AA ATBM06AB ATBM06AC ATBM06AD ATBM06AE ATBM06AF ATBM06AG ATBM06AH
    ATBM06BA ATBM06BB ATBM06BC ATBM06BD ATBM06BE ATBM06BF ATBM06BG
    ATBM06CA ATBM06CB
        0 'Not yet taught or just introduced'
        1 'Mostly taught before this year'
        2 'Mostly taught this year'.
MISSING VALUES
    ATBM06AA ATBM06AB ATBM06AC ATBM06AD ATBM06AE ATBM06AF ATBM06AG ATBM06AH
    ATBM06BA ATBM06BB ATBM06BC ATBM06BD ATBM06BE ATBM06BF ATBM06BG
    ATBM06CA ATBM06CB
        (-99).
RENAME VARIABLES (
    ATBM06AA ATBM06AB ATBM06AC ATBM06AD ATBM06AE ATBM06AF ATBM06AG ATBM06AH
    ATBM06BA ATBM06BB ATBM06BC ATBM06BD ATBM06BE ATBM06BF ATBM06BG
    ATBM06CA ATBM06CB
    =
    MTopNum MTopSim MTopFac MTopFraC MTopFraU MTopDec MTopSent MTopPat
    MTopLine MTopAngl MTopCood MTopShap MTopRota MTopDim MTopArea
    MTopData MTopConc
    ).

* M7A: Mathematics homework for the TIMSS class.
RECODE
    ATBM07A
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM07A
        0 'I do not assign mathematics homework'
        1 'Less than once a week'
        2 '1 or 2 times a week'
        3 '3 or 4 times a week'
        4 'Every day'.
MISSING VALUES
    ATBM07A
        (-99).
RENAME VARIABLES (
    ATBM07A = MHomeW
    ).

* M7B: Mathematics homework for the TIMSS class.
RECODE
    ATBM07B
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM07B
        0 '15 minutes or less'
        1 '16--30 minutes'
        2 '31--60 minutes'
        3 'More than 60 minutes'.
MISSING VALUES
    ATBM07B
        (-99).
RENAME VARIABLES (
    ATBM07B = MTimeHW
    ).

* M7C: Mathematics homework for the TIMSS class.
RECODE
    ATBM07CA ATBM07CB ATBM07CC
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM07CA ATBM07CB ATBM07CC
        0 'Never or almost never'
        1 'Sometimes'
        2 'Always or almost always'.
MISSING VALUES
    ATBM07CA ATBM07CB ATBM07CC
        (-99).
RENAME VARIABLES (
    ATBM07CA ATBM07CB ATBM07CC
    =
    MHWCor MHWDis MHWMntr
    ).

* M8: Math assessment of the TIMSS class.
RECODE
    ATBM08A ATBM08B ATBM08C
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM08A ATBM08B ATBM08C
        0 'None'
        1 'Some'
        2 'A lot'.
MISSING VALUES
    ATBM08A ATBM08B ATBM08C
        (-99).
RENAME VARIABLES (
    ATBM08A ATBM08B ATBM08C
    =
    MAsOngo MAsTest MAsNati
    ).

* M9: PD to teach mathematics.
RECODE
    ATBM09A ATBM09B ATBM09C ATBM09D ATBM09E ATBM09F ATBM09G
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM09A ATBM09B ATBM09C ATBM09D ATBM09E ATBM09F ATBM09G
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM09A ATBM09B ATBM09C ATBM09D ATBM09E ATBM09F ATBM09G
        (-99).
RENAME VARIABLES (
    ATBM09A ATBM09B ATBM09C ATBM09D ATBM09E ATBM09F ATBM09G
    =
    MPDCont MPDPed MPDCur MPDTech MPDProb MPDAss MPDNeed
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

* M11: Preparation to teach mathematics.
RECODE
    ATBM11AA ATBM11AB ATBM11AC ATBM11AD ATBM11AE ATBM11AF ATBM11AG ATBM11AH
    ATBM11BA ATBM11BB ATBM11BC ATBM11BD ATBM11BE ATBM11BF ATBM11BG
    ATBM11CA ATBM11CB
        (1=0) (2=3) (3=2) (4=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM11AA ATBM11AB ATBM11AC ATBM11AD ATBM11AE ATBM11AF ATBM11AG ATBM11AH
    ATBM11BA ATBM11BB ATBM11BC ATBM11BD ATBM11BE ATBM11BF ATBM11BG
    ATBM11CA ATBM11CB
        0 'Not applicable'
        1 'Not well prepared'
        2 'Somewhat prepared'
        3 'Very well prepared'.
MISSING VALUES
    ATBM11AA ATBM11AB ATBM11AC ATBM11AD ATBM11AE ATBM11AF ATBM11AG ATBM11AH
    ATBM11BA ATBM11BB ATBM11BC ATBM11BD ATBM11BE ATBM11BF ATBM11BG
    ATBM11CA ATBM11CB
        (-99).
RENAME VARIABLES (
    ATBM11AA ATBM11AB ATBM11AC ATBM11AD ATBM11AE ATBM11AF ATBM11AG ATBM11AH
    ATBM11BA ATBM11BB ATBM11BC ATBM11BD ATBM11BE ATBM11BF ATBM11BG
    ATBM11CA ATBM11CB
    =
    MPrpNum MPrpSim MPrpFac MPrpFraC MPrpFraU MPrpDec MPrpSent MPrpPat
    MPrpLine MPrpAngl MPrpCood MPrpShap MPrpRota MPrpDim MPrpArea
    MPrpData MPrpConc
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

* S2: Science teaching confidence.
RECODE
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E ATBS02F ATBS02G ATBS02H ATBS02I ATBS02J
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E ATBS02F ATBS02G ATBS02H ATBS02I ATBS02J
        0 'Low'
        1 'Medium'
        2 'High'
        3 'Very high'.
MISSING VALUES
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E ATBS02F ATBS02G ATBS02H ATBS02I ATBS02J
        (-99).
RENAME VARIABLES (
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E ATBS02F ATBS02G ATBS02H ATBS02I ATBS02J
    =
    SCfInsp SCfExpl SCfChal SCfEnga SCfAppr SCfAss SCfImpr SCfRele SCfHgTh SCfInqu
    ).

* S3: Science teaching practices.
RECODE
    ATBS03A ATBS03B ATBS03C ATBS03D ATBS03E ATBS03F ATBS03G
    ATBS03H ATBS03I ATBS03J ATBS03K ATBS03L ATBS03M ATBS03N
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS03A ATBS03B ATBS03C ATBS03D ATBS03E ATBS03F ATBS03G
    ATBS03H ATBS03I ATBS03J ATBS03K ATBS03L ATBS03M ATBS03N
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ATBS03A ATBS03B ATBS03C ATBS03D ATBS03E ATBS03F ATBS03G
    ATBS03H ATBS03I ATBS03J ATBS03K ATBS03L ATBS03M ATBS03N
        (-99).
RENAME VARIABLES (
    ATBS03A ATBS03B ATBS03C ATBS03D ATBS03E ATBS03F ATBS03G
    ATBS03H ATBS03I ATBS03J ATBS03K ATBS03L ATBS03M ATBS03N
    =
    STExp STObs STDem STPlanEx STConEx STPreDat STIntDat
    STUseEvi STReadTx STFact STFieldW STTest STMixAb STSamAb
    ).

* S4A: Science teaching and computer availability.
RECODE
    ATBS04A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS04A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS04A
        (-99).
RENAME VARIABLES (
    ATBS04A = SPCAva
    ).

* S4B: Science teaching and access to computer.
RECODE
    ATBS04BA ATBS04BB ATBS04BC
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS04BA ATBS04BB ATBS04BC
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS04BA ATBS04BB ATBS04BC
        (-99).
RENAME VARIABLES (
    ATBS04BA ATBS04BB ATBS04BC
    =
    SPCStd SPCClas SPCSch
    ).

* S4C: Science teaching using computer.
RECODE
    ATBS04CA ATBS04CB ATBS04CC ATBS04CD
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS04CA ATBS04CB ATBS04CC ATBS04CD
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every or almost every day'.
MISSING VALUES
    ATBS04CA ATBS04CB ATBS04CC ATBS04CD
        (-99).
RENAME VARIABLES (
    ATBS04CA ATBS04CB ATBS04CC ATBS04CD
    =
    SPCSkil SPCSear SPCProc SPCSimu
    ).

* S5: Science topics taught to the TIMSS class.
RECODE
    ATBS05AA ATBS05AB ATBS05AC ATBS05AD ATBS05AE ATBS05AF ATBS05AG
    ATBS05BA ATBS05BB ATBS05BC ATBS05BD ATBS05BE ATBS05BF ATBS05BG ATBS05BH ATBS05BI
    ATBS05CA ATBS05CB ATBS05CC ATBS05CD ATBS05CE ATBS05CF ATBS05CG
        (1=1) (2=2) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS05AA ATBS05AB ATBS05AC ATBS05AD ATBS05AE ATBS05AF ATBS05AG
    ATBS05BA ATBS05BB ATBS05BC ATBS05BD ATBS05BE ATBS05BF ATBS05BG ATBS05BH ATBS05BI
    ATBS05CA ATBS05CB ATBS05CC ATBS05CD ATBS05CE ATBS05CF ATBS05CG
        0 'Not yet taught or just introduced'
        1 'Mostly taught before this year'
        2 'Mostly taught this year'.
MISSING VALUES
    ATBS05AA ATBS05AB ATBS05AC ATBS05AD ATBS05AE ATBS05AF ATBS05AG
    ATBS05BA ATBS05BB ATBS05BC ATBS05BD ATBS05BE ATBS05BF ATBS05BG ATBS05BH ATBS05BI
    ATBS05CA ATBS05CB ATBS05CC ATBS05CD ATBS05CE ATBS05CF ATBS05CG
        (-99).
RENAME VARIABLES (
    ATBS05AA ATBS05AB ATBS05AC ATBS05AD ATBS05AE ATBS05AF ATBS05AG
    ATBS05BA ATBS05BB ATBS05BC ATBS05BD ATBS05BE ATBS05BF ATBS05BG ATBS05BH ATBS05BI
    ATBS05CA ATBS05CB ATBS05CC ATBS05CD ATBS05CE ATBS05CF ATBS05CG
    =
    STopLiv STopBody STopLife STopPlan STopFeat STopComm STopHum
    STopMat STopClas STopMix STopChg STopEne STopLigt STopElec STopMag STopForc
    STopLand STopWate STopWeat STopFosl STopSolr STopMotn STopReas
    ).

* S6A: Time for science homework.
RECODE
    ATBS06A
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS06A
        0 'I do not assign science homework'
        1 'Less than one a week'
        2 '1 or 2 times a week'
        3 '3 or 4 times a week'
        4 'Every day'.
MISSING VALUES
    ATBS06A
        (-99).
RENAME VARIABLES (
    ATBS06A = SHomeW
    ).

* S6B: Time for science homework.
RECODE
    ATBS06B
        (1=0) (2=1) (3=2) (4=3)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS06B
        0 '15 minutes or less'
        1 '16--30 minutes'
        2 '31--60 minutes'
        3 'More than 60 minutes'.
MISSING VALUES
    ATBS06B
        (-99).
RENAME VARIABLES (
    ATBS06B = STimeHW
    ).

* S5C: Assessing science homework.
RECODE
    ATBS06CA ATBS06CB ATBS06CC
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS06CA ATBS06CB ATBS06CC
        0 'Never or almost never'
        1 'Sometimes'
        2 'Always or almost always'.
MISSING VALUES
    ATBS06CA ATBS06CB ATBS06CC
        (-99).
RENAME VARIABLES (
    ATBS06CA ATBS06CB ATBS06CC
    =
    SHWCor SHWDis SHWMntr
    ).

* S7: Science assessment of the TIMSS class.
RECODE
    ATBS07A ATBS07B ATBS07C
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS07A ATBS07B ATBS07C
        0 'None'
        1 'Some'
        2 'A lot'.
MISSING VALUES
    ATBS07A ATBS07B ATBS07C
        (-99).
RENAME VARIABLES (
    ATBS07A ATBS07B ATBS07C
    =
    SAsOngo SAsTest SAsNati
    ).

* S8: PD to teach science: Past experience (A) and future needs (B).
RECODE
    ATBS08A ATBS08B ATBS08C ATBS08D ATBS08E ATBS08F ATBS08G ATBS08H
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS08A ATBS08B ATBS08C ATBS08D ATBS08E ATBS08F ATBS08G ATBS08H
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS08A ATBS08B ATBS08C ATBS08D ATBS08E ATBS08F ATBS08G ATBS08H
        (-99).
RENAME VARIABLES (
    ATBS08A ATBS08B ATBS08C ATBS08D ATBS08E ATBS08F ATBS08G ATBS08H
    =
    SPDCont SPDPed SPDCur SPDTech SPDCrit SPDAss SPDNeed SPDIntg
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

* S10: Preparation to teach science.
RECODE
    ATBS10AA ATBS10AB ATBS10AC ATBS10AD ATBS10AE ATBS10AF ATBS10AG
    ATBS10BA ATBS10BB ATBS10BC ATBS10BD ATBS10BE ATBS10BF ATBS10BG ATBS10BH ATBS10BI
    ATBS10CA ATBS10CB ATBS10CC ATBS10CD ATBS10CE ATBS10CF ATBS10CG
        (1=0) (2=3) (3=2) (4=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS10AA ATBS10AB ATBS10AC ATBS10AD ATBS10AE ATBS10AF ATBS10AG
    ATBS10BA ATBS10BB ATBS10BC ATBS10BD ATBS10BE ATBS10BF ATBS10BG ATBS10BH ATBS10BI
    ATBS10CA ATBS10CB ATBS10CC ATBS10CD ATBS10CE ATBS10CF ATBS10CG
        0 'Not applicable'
        1 'Not well prepared'
        2 'Somewhat prepared'
        3 'Very well prepared'.
MISSING VALUES
    ATBS10AA ATBS10AB ATBS10AC ATBS10AD ATBS10AE ATBS10AF ATBS10AG
    ATBS10BA ATBS10BB ATBS10BC ATBS10BD ATBS10BE ATBS10BF ATBS10BG ATBS10BH ATBS10BI
    ATBS10CA ATBS10CB ATBS10CC ATBS10CD ATBS10CE ATBS10CF ATBS10CG
        (-99).
RENAME VARIABLES (
    ATBS10AA ATBS10AB ATBS10AC ATBS10AD ATBS10AE ATBS10AF ATBS10AG
    ATBS10BA ATBS10BB ATBS10BC ATBS10BD ATBS10BE ATBS10BF ATBS10BG ATBS10BH ATBS10BI
    ATBS10CA ATBS10CB ATBS10CC ATBS10CD ATBS10CE ATBS10CF ATBS10CG
    =
    SPrpLiv SPrpBody SPrpLife SPrpPlan SPrpFeat SPrpComm SPrpHum
    SPrpMat SPrpClas SPrpMix SPrpChg SPrpEne SPrpLigt SPrpElec SPrpMag SPrpForc
    SPrpLand SPrpWate SPrpWeat SPrpFosl SPrpSolr SPrpMotn SPrpReas
    ).

**************************
** Compound variables **
**************************

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

* TIMSS compound variables: School conditions and resources.
RECODE
    ATBGSCR
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
     ATBGSCR
        (-99).
RENAME VARIABLES (
     ATBGSCR = SCLRes
    ).

RECODE
    ATDGSCR
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGSCR
        0 'Moderate to severe problems'
        1 'Minor problems'
        2 'Hardly any problems'.
MISSING VALUES
    ATDGSCR
        (-99).
RENAME VARIABLES (
    ATDGSCR = IDXRes
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

* TIMSS compound variables: Challenges facing teachers.
RECODE
    ATBGCFT
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGCFT
        (-99).
RENAME VARIABLES (
    ATBGCFT = SCLChal
    ).

RECODE
    ATDGCFT
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGCFT
        0 'Many challenges'
        1 'Some challenges'
        2 'Few challenges'.
MISSING VALUES
    ATDGCFT
        (-99).
RENAME VARIABLES (
    ATDGCFT = IDXChal
    ).

* TIMSS compound variables: Teaching limited by student needs.
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
        0 'Very limited'
        1 'Somewhat limited'
        2 'Very limited'.
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

* Percent of teachers majored in education and math.
RECODE
    ATDM05
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDM05
        0 'No formal education beyond upper secondary'
        1 'All other majors'
        2 'Major in mathematics but not education'
        3 'Major in education but not mathematics'
        4 'Major in education and mathematics'.
MISSING VALUES
    ATDM05
        (-99).
RENAME VARIABLES (
    ATDM05 = MTchMjr
    ).

* Percent of teachers majored in education and science.
RECODE
    ATDS05
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDS05
        0 'No formal education beyond upper secondary'
        1 'All other majors'
        2 'Major in math but not in primary education'
        3 'Major in primary education but not in math'
        4 'Major in primary education and math'.
MISSING VALUES
    ATDS05
        (-99).
RENAME VARIABLES (
    ATDS05 = STchMjr
    ).

* Percent of students taught math topics.
RECODE
    ATDM06NU ATDM06GE ATDM06DT
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDM06NU ATDM06GE ATDM06DT
        (-99).
RENAME VARIABLES (
    ATDM06NU ATDM06GE ATDM06DT
    =
    PTpNumb PTpGeo PTpData
    ).

* Percent of students taught science topics.
RECODE
    ATDS05LI ATDS05PH ATDS05ES
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDS05LI ATDS05PH ATDS05ES
        (-99).
RENAME VARIABLES (
    ATDS05LI ATDS05PH ATDS05ES
    =
    PTpLife PTpPhys PTpEarth
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
    ASMDAT01
    ASMDAT02
    ASMDAT03
    ASMDAT04
    ASMDAT05
    ASMGEO01
    ASMGEO02
    ASMGEO03
    ASMGEO04
    ASMGEO05
    ASMNUM01
    ASMNUM02
    ASMNUM03
    ASMNUM04
    ASMNUM05
    ASSEAR01
    ASSEAR02
    ASSEAR03
    ASSEAR04
    ASSEAR05
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
    idbid
    .

* Update data set.
SAVE OUTFILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\T15_G4_3_Teacher.sav".

***** End script *****
