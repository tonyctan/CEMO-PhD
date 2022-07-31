* Encoding: UTF-8.

**** ADMIN INFO *****
* Date: 29 July 2021
* Author: Tony Tan
* Email: tctan@uio.no
* Position: PhD Candidate
* Organisation: CEMO, UV, UiO
* Script purpose: Data cleaning--Teacher

***** DATA ATTRIBUTES *****
* ILSA: TIMSS
* Cycle: 2011
* Questionnaire: Teacher
* Grade: Grade 4
* Subject: Math and Science

***** Begin script *****

* Import data.
GET FILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_11\T11_G4_0_Merge_teacher.sav".

**************************
** Admin variables **
**************************

*1: Country ID - Numeric ISO Code.

*2: Student Test Booklet.
RECODE
    IDBOOK
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDBOOK
        (-99).

*3: School ID.
*4: Class ID.
*5: Student ID.

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
*9: System ID linkage file.

*10: Population ID.
RECODE
    IDPOP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDPOP
        (-99).

*11: Standardized Grade ID.
RECODE
    IDGRADER
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADER
        (-99).

*12: Grade ID.
RECODE
    IDGRADE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADE
        (-99).

*13: Subject ID.
RECODE
    IDSUBJ
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDSUBJ
        (-99).

*14: Name of course.
RECODE
    ITCOURSE
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ITCOURSE
        (-99).

*15: Mathematics Teacher Link.
RECODE
    MATSUBJ
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    MATSUBJ
        (-99).

*16: Science Teacher Link.
RECODE
    SCISUBJ
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    SCISUBJ
        (-99).

*17: Number of Math Teachers for Student.
RECODE
    NMTEACH
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    NMTEACH
        (-99).

*18: Number of Teachers.
RECODE
    NTEACH
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    NTEACH
        (-99).

*19: Number of Science Teachers for Student.
RECODE
    NSTEACH
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    NSTEACH
        (-99).

*20 & 21: Stratification.
RECODE
    IDSTRATE IDSTRATI
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDSTRATE IDSTRATI
        (-99).

*22: JACKKNIFE REPLICATE CODE.
RECODE
    JKREP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKREP
        (-99).

*23: JACKKNIFE ZONE.
RECODE
    JKZONE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKZONE
        (-99).

*24 & 25: WEIGHT FOR TEACHER DATA.
RECODE
    MATWGT SCIWGT
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    MATWGT SCIWGT
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
        (1=0)  (2=1) (3=2) (4=3) (5=4) (6=5)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
   ATBG04
       0 'Did not completed <ISCED Level 3>'
       1 'Finished <ISCED Level 3>'
       2 'Finished <ISCED Level 4>'
       3 'Finished <ISCED Level 5B>'
       4 'Finished <ISCED Level 5A, first degree>'
       5 'Finished <ISCED Level 5A, second degree> or higher'.
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
        (9=-99) (SYSMIS=-99) (MISSING=-99).
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
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E ATBG06F ATBG06G ATBG06H
        (1=4)  (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E ATBG06F ATBG06G ATBG06H
        0 'Very low'
        1 'Low'
        2 'Medium'
        3 'High'
        4 'Very high'.
MISSING VALUES
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E ATBG06F ATBG06G ATBG06H
        (-99).
RENAME VARIABLES (
    ATBG06A ATBG06B ATBG06C ATBG06D ATBG06E ATBG06F ATBG06G ATBG06H
    =
    STchJobS STchUndT STchSucT STchExpT SParSupT SParInvT SResPropT SStudDesT
    ).

* G7: Safety and orderly school.
RECODE
    ATBG07A ATBG07B ATBG07C ATBG07D ATBG07E
    (1=3) (2=2) (3=1) (4=0)
    (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG07A ATBG07B ATBG07C ATBG07D ATBG07E
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ATBG07A ATBG07B ATBG07C ATBG07D ATBG07E
        (-99).
RENAME VARIABLES (
    ATBG07A ATBG07B ATBG07C ATBG07D ATBG07E
    =
    OSafeNgh OFeelSaf OSecPol OStdBhv OStdRes
    ).

* G8: Teaching constraint.
RECODE
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E
        0 'Serious problem'
        1 'Modrate problem'
        2 'Minor problem'
        3 'Not a problem'.
MISSING VALUES
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E
        (-99).
RENAME VARIABLES (
    ATBG08A ATBG08B ATBG08C ATBG08D ATBG08E
    =
    ConBuil ConClas ConHour ConHyge ConMain
    ).

*G9A: Teacher computer use.
RECODE
    ATBG09AA ATBG09AB ATBG09AC
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG09AA ATBG09AB ATBG09AC
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBG09AA ATBG09AB ATBG09AC
        (-99).
RENAME VARIABLES (
    ATBG09AA ATBG09AB ATBG09AC
    =
    ComPrep ComAdmi ComInst
    ).

*G9B: Teacher computer use.
RECODE
    ATBG09BA ATBG09BB ATBG09BC
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG09BA ATBG09BB ATBG09BC
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ATBG09BA ATBG09BB ATBG09BC
        (-99).
RENAME VARIABLES (
    ATBG09BA ATBG09BB ATBG09BC
    =
    ComComf ComProb ComSupp
    ).

* G10: Teacher interaction.
RECODE
    ATBG10A ATBG10B ATBG10C ATBG10D ATBG10E
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG10A ATBG10B ATBG10C ATBG10D ATBG10E
        0 'Never or almost never'
        1 '2 or 3 times per month'
        2 '1--3 times per week'
        3 'Daily or almost daily'.
MISSING VALUES
    ATBG10A ATBG10B ATBG10C ATBG10D ATBG10E
        (-99).
RENAME VARIABLES (
    ATBG10A ATBG10B ATBG10C ATBG10D ATBG10E
    =
    IntDisc IntColl IntLear IntVisi IntToge
    ).

* G11A--E: Teacher job satisfaction.
RECODE
    ATBG11A ATBG11B ATBG11C ATBG11D ATBG11E
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG11A ATBG11B ATBG11C ATBG11D ATBG11E
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ATBG11A ATBG11B ATBG11C ATBG11D ATBG11E
        (-99).
RENAME VARIABLES (
    ATBG11A ATBG11B ATBG11C ATBG11D ATBG11E
    =
    JContent JSatisfi JEnthus JImport JContinu
    ).

* G11F:  Teacher job satisfaction (Frastration: reverse coding).
RECODE
    ATBG11F
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG11F
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disagree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ATBG11F
        (-99).
RENAME VARIABLES (
    ATBG11F = JFrustra
    ).

* G12A: Number of students in class.
* G12B: Number of students in Grade 4class.
* G13: Number of students with language difficulties.
RECODE
    ATBG12A ATBG12B ATBG13
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBG12A ATBG12B ATBG13
        (-99).
RENAME VARIABLES (
    ATBG12A ATBG12B ATBG13
    =
    NStdCl NStdG4 NStdLang
    ).

* G14: Teaching subject.
RECODE
    ATBG14A ATBG14B ATBG14C
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG14A ATBG14B ATBG14C
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBG14A ATBG14B ATBG14C
        (-99).
RENAME VARIABLES (
    ATBG14A ATBG14B ATBG14C
    =
    SubjRead SubjMath SubjScie
    ).

* G15: Teaching practices.
RECODE
    ATBG15A ATBG15B ATBG15C ATBG15D ATBG15E ATBG15F
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG15A ATBG15B ATBG15C ATBG15D ATBG15E ATBG15F
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ATBG15A ATBG15B ATBG15C ATBG15D ATBG15E ATBG15F
        (-99).
RENAME VARIABLES (
    ATBG15A ATBG15B ATBG15C ATBG15D ATBG15E ATBG15F
    =
    PSummary PDalyLiv PReason PEncoura PPraise PInsMat
    ).

* G16: Students limitation.
RECODE
    ATBG16A ATBG16B ATBG16C ATBG16D ATBG16E ATBG16F
        (1=0) (2=3) (3=2) (4=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG16A ATBG16B ATBG16C ATBG16D ATBG16E ATBG16F
        0 'Not applicable'
        1 'A lot'
        2 'Some'
        3 'Not at all'.
MISSING VALUES
    ATBG16A ATBG16B ATBG16C ATBG16D ATBG16E ATBG16F
        (-99).
RENAME VARIABLES (
    ATBG16A ATBG16B ATBG16C ATBG16D ATBG16E ATBG16F
    =
    LLckKng LLckNut LLckSlep LSpeNeed LDistStd LUninStd
    ).

* G17: Liaison with parents.
RECODE
    ATBG17A ATBG17B
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBG17A ATBG17B
        0 'Never'
        1 '1--3 times a year'
        2 '4--6 times a year'
        3 'Once or twice a month'
        4 'At least once a week'.
MISSING VALUES
    ATBG17A ATBG17B
        (-99).
RENAME VARIABLES (
    ATBG17A ATBG17B
    =
    LiaiMeet LiaiRepo
    ).

* M1: Time spent on math instruction.
RECODE
    ATBM01A ATBM01B
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBM01A ATBM01B
        (-99).
RENAME VARIABLES (
        ATBM01A ATBM01B
        =
        MathHour MathMinu
    ).

* M2: Math teaching confidence.
RECODE
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E
        0 'Not confident'
        1 'Somewhat confident'
        2 'Very confident'.
MISSING VALUES
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E
        (-99).
RENAME VARIABLES (
    ATBM02A ATBM02B ATBM02C ATBM02D ATBM02E
    =
    MCfAnsw MCfProb MCfChal MCfEnga MCfAppr
    ).

* M3: Math teaching practices.
RECODE
    ATBM03A ATBM03B ATBM03C ATBM03D ATBM03E ATBM03F ATBM03G ATBM03H
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM03A ATBM03B ATBM03C ATBM03D ATBM03E ATBM03F ATBM03G ATBM03H
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ATBM03A ATBM03B ATBM03C ATBM03D ATBM03E ATBM03F ATBM03G ATBM03H
        (-99).
RENAME VARIABLES (
    ATBM03A ATBM03B ATBM03C ATBM03D ATBM03E ATBM03F ATBM03G ATBM03H
    =
    MTExpln MTMemrz MTGuid MTWork MTOccup MTExpAn MTDalyLi MTTest
    ).

* M4: Math teaching resources.
RECODE
    ATBM04A ATBM04B ATBM04C ATBM04D
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM04A ATBM04B ATBM04C ATBM04D
        0 'Not used'
        1 'Supplement'
        2 'Basis for instruction'.
MISSING VALUES
    ATBM04A ATBM04B ATBM04C ATBM04D
        (-99).
RENAME VARIABLES (
        ATBM04A ATBM04B ATBM04C ATBM04D
        =
        MResTxbk MResWkbk MResObje MResSoft
    ).

* M5: Math teaching and access to calculator.
RECODE
    ATBM05
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM05
        0 'No, calculators are not permitted'
        1 'Yes, with restricted use'
        2 'Yes, with unrestricted use'.
MISSING VALUES
    ATBM05
        (-99).
RENAME VARIABLES (
    ATBM05 = MUseCal
    ).

* M6A: Mathteaching and access to computer.
RECODE
    ATBM06A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM06A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM06A
        (-99).
RENAME VARIABLES (
    ATBM06A = MPCAva
    ).

* M6B: Mathteaching and access to computer.
RECODE
    ATBM06B
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM06B
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM06B
        (-99).
RENAME VARIABLES (
    ATBM06B = MPCIntNt
    ).

* M6C: Math teaching using computer.
RECODE
    ATBM06CA ATBM06CB ATBM06CC
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM06CA ATBM06CB ATBM06CC
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every or almost every day'.
MISSING VALUES
    ATBM06CA ATBM06CB ATBM06CC
        (-99).
RENAME VARIABLES (
    ATBM06CA ATBM06CB ATBM06CC
    =
    MPCConc MPCPrac MPCSear
    ).

* M7: Mathematics topics taught.
RECODE
    ATBM07AA ATBM07AB ATBM07AC ATBM07AD ATBM07AE ATBM07AF ATBM07AG ATBM07AH
    ATBM07BA ATBM07BB ATBM07BC ATBM07BD ATBM07BE ATBM07BF ATBM07BG
    ATBM07CA ATBM07CB ATBM07CC
        (1=1) (2=2) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM07AA ATBM07AB ATBM07AC ATBM07AD ATBM07AE ATBM07AF ATBM07AG ATBM07AH
    ATBM07BA ATBM07BB ATBM07BC ATBM07BD ATBM07BE ATBM07BF ATBM07BG
    ATBM07CA ATBM07CB ATBM07CC
        0 'Not yet taught or just introduced'
        1 'Mostly taught before this year'
        2 'Mostly taught this year'.
MISSING VALUES
    ATBM07AA ATBM07AB ATBM07AC ATBM07AD ATBM07AE ATBM07AF ATBM07AG ATBM07AH
    ATBM07BA ATBM07BB ATBM07BC ATBM07BD ATBM07BE ATBM07BF ATBM07BG
    ATBM07CA ATBM07CB ATBM07CC
        (-99).
RENAME VARIABLES (
    ATBM07AA ATBM07AB ATBM07AC ATBM07AD ATBM07AE ATBM07AF ATBM07AG ATBM07AH
    ATBM07BA ATBM07BB ATBM07BC ATBM07BD ATBM07BE ATBM07BF ATBM07BG
    ATBM07CA ATBM07CB ATBM07CC
    =
    MTopNum MTopSim MTopFraC MTopFraU MTopDecC MTopDecU MTopSent MTopPat
    MTopLine MTopAngl MTopCood MTopShap MTopRota MTopDim MTopArea
    MTopTabl MTopConc MTopData
    ).

* M8: Mathematics content coverage.
RECODE
    ATBM08A ATBM08B ATBM08C ATBM08D
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBM08A ATBM08B ATBM08C ATBM08D
        (-99).

* M9A: Mathematics homework.
RECODE
    ATBM09A
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM09A
        0 'I do not assign mathematics homework'
        1 'Less than once a week'
        2 '1 or 2 times a week'
        3 '3 or 4 times a week'
        4 'Every day'.
MISSING VALUES
    ATBM09A
        (-99).
RENAME VARIABLES (
    ATBM09A = MHomeW
    ).

* M9B: Mathematics homework.
RECODE
    ATBM09B
        (1=0) (2=1) (3=2) (4=3)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM09B
        0 '15 minutes or less'
        1 '16--30 minutes'
        2 '31--60 minutes'
        3 'More than 60 minutes'.
MISSING VALUES
    ATBM09B
        (-99).
RENAME VARIABLES (
    ATBM09B = MTimeHW
    ).

* M9C: Mathematics homework.
RECODE
    ATBM09CA ATBM09CB ATBM09CC
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM09CA ATBM09CB ATBM09CC
        0 'Never or almost never'
        1 'Sometimes'
        2 'Always or almost always'.
MISSING VALUES
    ATBM09CA ATBM09CB ATBM09CC
        (-99).
RENAME VARIABLES (
    ATBM09CA ATBM09CB ATBM09CC
    =
    MHWCor MHWDis MHWMntr
    ).

* M10: Math assessment.
RECODE
    ATBM10A ATBM10B ATBM10C
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM10A ATBM10B ATBM10C
        0 'Little or no emphasis'
        1 'Some emphasis'
        2 'Major emphasis'.
MISSING VALUES
    ATBM10A ATBM10B ATBM10C
        (-99).
RENAME VARIABLES (
    ATBM10A ATBM10B ATBM10C
    =
    MAsOngo MAsTest MAsNati
    ).

* M11: PD to teach mathematics.
RECODE
    ATBM11A ATBM11B ATBM11C ATBM11D ATBM11E ATBM11F
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM11A ATBM11B ATBM11C ATBM11D ATBM11E ATBM11F
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBM11A ATBM11B ATBM11C ATBM11D ATBM11E ATBM11F
        (-99).
RENAME VARIABLES (
    ATBM11A ATBM11B ATBM11C ATBM11D ATBM11E ATBM11F
    =
    MPDCont MPDPed MPDCur MPDTech MPDAss MPDNeed
    ).

* M12: Preparation to teach mathematics.
RECODE
    ATBM12AA ATBM12AB ATBM12AC ATBM12AD ATBM12AE ATBM12AF ATBM12AG ATBM12AH
    ATBM12BA ATBM12BB ATBM12BC ATBM12BD ATBM12BE ATBM12BF ATBM12BG
    ATBM12CA ATBM12CB ATBM12CC
        (1=0) (2=3) (3=2) (4=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBM12AA ATBM12AB ATBM12AC ATBM12AD ATBM12AE ATBM12AF ATBM12AG ATBM12AH
    ATBM12BA ATBM12BB ATBM12BC ATBM12BD ATBM12BE ATBM12BF ATBM12BG
    ATBM12CA ATBM12CB ATBM12CC
        0 'Not applicable'
        1 'Not well prepared'
        2 'Somewhat prepared'
        3 'Very well prepared'.
MISSING VALUES
    ATBM12AA ATBM12AB ATBM12AC ATBM12AD ATBM12AE ATBM12AF ATBM12AG ATBM12AH
    ATBM12BA ATBM12BB ATBM12BC ATBM12BD ATBM12BE ATBM12BF ATBM12BG
    ATBM12CA ATBM12CB ATBM12CC
        (-99).
RENAME VARIABLES (
    ATBM12AA ATBM12AB ATBM12AC ATBM12AD ATBM12AE ATBM12AF ATBM12AG ATBM12AH
    ATBM12BA ATBM12BB ATBM12BC ATBM12BD ATBM12BE ATBM12BF ATBM12BG
    ATBM12CA ATBM12CB ATBM12CC
    =
    MPrpNum MPrpSim MPrpFraC MPrpFraU MPrpDecC MPrpDecU MPrpSent MPrpPat
    MPrpLine MPrpAngl MPrpCood MPrpShap MPrpRota MPrpDim MPrpArea
    MPrpTabl MPrpData MPrpConc
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
    ATBS01BA ATBS01BB
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBS01BA ATBS01BB
        (-99).
RENAME VARIABLES (
    ATBS01BA ATBS01BB
    =
    SciHour SciMinu
    ).

* S2: Science teaching confidence.
RECODE
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E
        0 'Not confident'
        1 'Somewhat confident'
        2 'Very confident'.
MISSING VALUES
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E
        (-99).
RENAME VARIABLES (
    ATBS02A ATBS02B ATBS02C ATBS02D ATBS02E
    =
    SCfAnsw SCfExpl SCfChal SCfEnga SCfAppr
    ).

* S3: Science teaching practices.
RECODE
    ATBS03A ATBS03B ATBS03C ATBS03D ATBS03E ATBS03F ATBS03G ATBS03H ATBS03I ATBS03J
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS03A ATBS03B ATBS03C ATBS03D ATBS03E ATBS03F ATBS03G ATBS03H ATBS03I ATBS03J
        0 'Never'
        1 'Some lessons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ATBS03A ATBS03B ATBS03C ATBS03D ATBS03E ATBS03F ATBS03G ATBS03H ATBS03I ATBS03J
        (-99).
RENAME VARIABLES (
    ATBS03A ATBS03B ATBS03C ATBS03D ATBS03E ATBS03F ATBS03G ATBS03H ATBS03I ATBS03J
    =
    STObs STDem STPlanEx STConEx STReadTx STFact STExpl STRelLif STFieldW STTest
    ).

* S4: Science teaching resources.
RECODE
    ATBS04A ATBS04B ATBS04C ATBS04D ATBS04E
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS04A ATBS04B ATBS04C ATBS04D ATBS04E
        0 'Not used'
        1 'Supplement'
        2 'Basis for instruction'.
MISSING VALUES
    ATBS04A ATBS04B ATBS04C ATBS04D ATBS04E
        (-99).
RENAME VARIABLES (
    ATBS04A ATBS04B ATBS04C ATBS04D ATBS04E
    =
    SResTxbk SResWkbk SResEqip SResSoft SResRef
    ).

* S5A: Science teaching and computer availability.
RECODE
    ATBS05A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS05A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS05A
        (-99).
RENAME VARIABLES (
    ATBS05A = SPCAva
    ).

* S5B: Science teaching and access to computer.
RECODE
    ATBS05B
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS05B
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS05B
        (-99).
RENAME VARIABLES (
    ATBS05B = SPCIntNt
    ).

* S5C: Science teaching using computer.
RECODE
    ATBS05CA ATBS05CB ATBS05CC ATBS05CD
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS05CA ATBS05CB ATBS05CC ATBS05CD
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every or almost every day'.
MISSING VALUES
    ATBS05CA ATBS05CB ATBS05CC ATBS05CD
        (-99).
RENAME VARIABLES (
    ATBS05CA ATBS05CB ATBS05CC ATBS05CD
    =
    SPCSkil SPCSear SPCProc SPCSimu
    ).

* S6: Science topics taught.
RECODE
    ATBS06AA ATBS06AB ATBS06AC ATBS06AD ATBS06AE ATBS06AF
    ATBS06BA ATBS06BB ATBS06BC ATBS06BD ATBS06BE ATBS06BF ATBS06BG ATBS06BH
    ATBS06CA ATBS06CB ATBS06CC ATBS06CD ATBS06CE ATBS06CF
        (1=1) (2=2) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS06AA ATBS06AB ATBS06AC ATBS06AD ATBS06AE ATBS06AF
    ATBS06BA ATBS06BB ATBS06BC ATBS06BD ATBS06BE ATBS06BF ATBS06BG ATBS06BH
    ATBS06CA ATBS06CB ATBS06CC ATBS06CD ATBS06CE ATBS06CF
        0 'Not yet taught or just introduced'
        1 'Mostly taught before this year'
        2 'Mostly taught this year'.
MISSING VALUES
    ATBS06AA ATBS06AB ATBS06AC ATBS06AD ATBS06AE ATBS06AF
    ATBS06BA ATBS06BB ATBS06BC ATBS06BD ATBS06BE ATBS06BF ATBS06BG ATBS06BH
    ATBS06CA ATBS06CB ATBS06CC ATBS06CD ATBS06CE ATBS06CF
        (-99).
RENAME VARIABLES (
    ATBS06AA ATBS06AB ATBS06AC ATBS06AD ATBS06AE ATBS06AF
    ATBS06BA ATBS06BB ATBS06BC ATBS06BD ATBS06BE ATBS06BF ATBS06BG ATBS06BH
    ATBS06CA ATBS06CB ATBS06CC ATBS06CD ATBS06CE ATBS06CF
    =
    STopBody STopLife STopFeat STopComm STopEnvi STopHum
    STopMat STopClas STopMix STopChg STopEne STopLigt STopElec STopForc
    STopWate STopLand STopWeat STopFosl STopSolr STopMotn
    ).

* S7: Science content coverage.
RECODE
    ATBS07A ATBS07B ATBS07C ATBS07D
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBS07A ATBS07B ATBS07C ATBS07D
        (-99).

* S8A: Time for science homework.
RECODE
    ATBS08A
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS08A
        0 'I do not assign science homework'
        1 'Less than one a week'
        2 '1 or 2 times a week'
        3 '3 or 4 times a week'
        4 'Every day'.
MISSING VALUES
    ATBS08A
        (-99).
RENAME VARIABLES (
    ATBS08A = SHomeW
    ).

* S8B: Time for science homework.
RECODE
    ATBS08B
        (1=0) (2=1) (3=2) (4=3)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS08B
        0 '15 minutes or less'
        1 '16--30 minutes'
        2 '31--60 minutes'
        3 'More than 60 minutes'.
MISSING VALUES
    ATBS08B
        (-99).
RENAME VARIABLES (
    ATBS08B = STimeHW
    ).

* S8C: Assessing science homework.
RECODE
    ATBS08CA ATBS08CB ATBS08CC
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS08CA ATBS08CB ATBS08CC
        0 'Never or almost never'
        1 'Sometimes'
        2 'Always or almost always'.
MISSING VALUES
    ATBS08CA ATBS08CB ATBS08CC
        (-99).
RENAME VARIABLES (
    ATBS08CA ATBS08CB ATBS08CC
    =
    SHWCor SHWDis SHWMntr
    ).

* S9: Science assessment.
RECODE
    ATBS09A ATBS09B ATBS09C
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS09A ATBS09B ATBS09C
        0 'Little or no emphasis'
        1 'Some emphasis'
        2 'Major emphasis'.
MISSING VALUES
    ATBS09A ATBS09B ATBS09C
        (-99).
RENAME VARIABLES (
    ATBS09A ATBS09B ATBS09C
    =
    SAsOngo SAsTest SAsNati
    ).

* S10: PD to teach science.
RECODE
    ATBS10A ATBS10B ATBS10C ATBS10D ATBS10E ATBS10F
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS10A ATBS10B ATBS10C ATBS10D ATBS10E ATBS10F
        0 'No'
        1 'Yes'.
MISSING VALUES
    ATBS10A ATBS10B ATBS10C ATBS10D ATBS10E ATBS10F
        (-99).
RENAME VARIABLES (
    ATBS10A ATBS10B ATBS10C ATBS10D ATBS10E ATBS10F
    =
    SPDCont SPDPed SPDCur SPDTech SPDAss SPDNeed
    ).

* S11: Preparation to teach science.
RECODE
    ATBS11AA ATBS11AB ATBS11AC ATBS11AD ATBS11AE ATBS11AF
    ATBS11BA ATBS11BB ATBS11BC ATBS11BD ATBS11BE ATBS11BF ATBS11BG ATBS11BH
    ATBS11CA ATBS11CB ATBS11CC ATBS11CD ATBS11CE ATBS11CF
        (1=0) (2=3) (3=2) (4=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATBS11AA ATBS11AB ATBS11AC ATBS11AD ATBS11AE ATBS11AF
    ATBS11BA ATBS11BB ATBS11BC ATBS11BD ATBS11BE ATBS11BF ATBS11BG ATBS11BH
    ATBS11CA ATBS11CB ATBS11CC ATBS11CD ATBS11CE ATBS11CF
        0 'Not applicable'
        1 'Not well prepared'
        2 'Somewhat prepared'
        3 'Very well prepared'.
MISSING VALUES
    ATBS11AA ATBS11AB ATBS11AC ATBS11AD ATBS11AE ATBS11AF
    ATBS11BA ATBS11BB ATBS11BC ATBS11BD ATBS11BE ATBS11BF ATBS11BG ATBS11BH
    ATBS11CA ATBS11CB ATBS11CC ATBS11CD ATBS11CE ATBS11CF
        (-99).
RENAME VARIABLES (
    ATBS11AA ATBS11AB ATBS11AC ATBS11AD ATBS11AE ATBS11AF
    ATBS11BA ATBS11BB ATBS11BC ATBS11BD ATBS11BE ATBS11BF ATBS11BG ATBS11BH
    ATBS11CA ATBS11CB ATBS11CC ATBS11CD ATBS11CE ATBS11CF
    =
    SPrpBody SPrpLife SPrpFeat SPrpComm SPrpEnvi SPrpHum
    SPrpMat SPrpClas SPrpMix SPrpChg SPrpEne SPrpLigt SPrpElec SPrpForc
    SPrpWate SPrpLand SPrpWeat SPrpFosl SPrpSolr SPrpMotn
    ).

**************************
** Compound variables **
**************************

* System ID teacher file.

* TIMSS compound variables: Working condition problem.
RECODE
    ATBGTWC
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGTWC
        (-99).
RENAME VARIABLES (
     ATBGTWC = SCLWCond
    ).

RECODE
    ATDGTWC
        (1=0) (2=1) (3=2)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGTWC
        0 'Hardly any problems'
        1 'Minor problems'
        2 'Moderate problems'.
MISSING VALUES
    ATDGTWC
        (-99).
RENAME VARIABLES (
    ATDGTWC = IDXWCond
    ).

* TIMSS compound variables: SEAS.
RECODE
    ATBGEAS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGEAS
        (-99).
RENAME VARIABLES (
    ATBGEAS = SCLSeasT
    ).

RECODE
    ATDGEAS
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGSOS
        (-99).
RENAME VARIABLES (
    ATBGSOS = SCLSafe
    ).

RECODE
    ATDGSOS
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGSOS
        0 'Not safe and orderly'
        1 'Somewhat safe and orderly'
        2 'Safe and orderly'.
MISSING VALUES
    ATDGSOS
        (-99).
RENAME VARIABLES (
    ATDGSOS = IDXSafe
    ).

* TIMSS compound variables: Math confidence.
RECODE
    ATBMCTM
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBMCTM
        (-99).
RENAME VARIABLES (
    ATBMCTM = SCLMConf
    ).

RECODE
    ATDMCTM
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDMCTM
        0 'Somewhat confident'
        1 'Confident'.
MISSING VALUES
    ATDMCTM
        (-99).
RENAME VARIABLES (
    ATDMCTM = IDXMConf
    ).

* TIMSS compound variables: Science confidence.
RECODE
    ATBSCTS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBSCTS
        (-99).
RENAME VARIABLES (
    ATBSCTS = SCLSConf
    ).

RECODE
    ATDSCTS
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDSCTS
        0 'Somewhat confident'
        1 'Confident'.
MISSING VALUES
    ATDSCTS
        (-99).
RENAME VARIABLES (
    ATDSCTS = IDXSConf
    ).

* TIMSS compound variables: Career satisfaction.
RECODE
    ATBGTCS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGTCS
        (-99).
RENAME VARIABLES (
    ATBGTCS = SCLCaree
    ).

RECODE
    ATDGTCS
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGTCS
        0 'Less than satisfied'
        1 'Somewhat satisfied'
        2 'Satisfied'.
MISSING VALUES
    ATDGTCS
        (-99).
RENAME VARIABLES (
    ATDGTCS = IDXCaree
    ).

* TIMSS compound variables: Collaborate to improve teaching.
RECODE
    ATBGCIT
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGCIT
        (-99).
RENAME VARIABLES (
    ATBGCIT = SCLColl
    ).

RECODE
    ATDGCIT
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGCIT
        0 'Sometimes collaborative'
        1 'Collaborative'
        2 'Very collaborative'.
MISSING VALUES
    ATDGCIT
        (-99).
RENAME VARIABLES (
    ATDGCIT = IDXColl
    ).

* TIMSS compound variables: Instruction to engage students in learning.
RECODE
    ATBGIES
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBGIES
        (-99).
RENAME VARIABLES (
    ATBGIES = SCLEnga
    ).

RECODE
    ATDGIES
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDGIES
        0 'Some lessons'
        1 'About half the lessons'
        2 'Most lessons'.
MISSING VALUES
    ATDGIES
        (-99).
RENAME VARIABLES (
    ATDGIES = IDXEnga
    ).

* TIMSS compound variables: Teacher emphasis on science investigation.
RECODE
    ATBSESI
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATBSESI
        (-99).
RENAME VARIABLES (
    ATBSESI = SCLExprm
    ).

RECODE
    ATDSESI
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDM05
        0 'No post-secondary education'
        1 'All other majors'
        2 'Major in mathematics but no major in primary education'
        3 'Major in primary education but no major in mathematics'
        4 'Major in primary education and major in mathematics'.
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDS05
        0 'No post-secondary education'
        1 'All other majors'
        2 'Major in science but no major in primary education'
        3 'Major in primary education but no major in science'
        4 'Major in primary education and major in science'.
MISSING VALUES
    ATDS05
        (-99).
RENAME VARIABLES (
    ATDS05 = STchMjr
    ).

* Teachers' year of experience.
RECODE
    ATDG01
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ATDG01
        0 'Less than 5 years'
        1 'At least 5 but less than 10 years'
        2 'At least 10 but less than 20 years'
        3 '20 years or more'.
MISSING VALUES
    ATDG01
        (-99).
RENAME VARIABLES (
    ATDG01 = YearExpe
    ).

* Math instruction hours.
RECODE
    ATDMHW
        (9996=-99) (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDMHW
        (-99).
RENAME VARIABLES (
    ATDMHW = HourMat
    ).

* Science instruction hours.
RECODE
    ATDSHW
        (9996=-99) (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDSHW
        (-99).
RENAME VARIABLES (
    ATDSHW = HourSci
    ).

* Teacher preparedness.
RECODE
    ATDM12NU ATDM12GE ATDM12DT ATDS11LI ATDS11PH ATDS11ES
        (9996=-99) (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDM12NU ATDM12GE ATDM12DT ATDS11LI ATDS11PH ATDS11ES
        (-99).
RENAME VARIABLES (
    ATDM12NU ATDM12GE ATDM12DT ATDS11LI ATDS11PH ATDS11ES
    =
    PrepNum PrepGeo PrepDat PrepLif PrepPhy PrepEar
    ).

* Percent of students taught math topics.
RECODE
    ATDM07NU ATDM07GE ATDM07DT
        (9996=-99) (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDM07NU ATDM07GE ATDM07DT
        (-99).
RENAME VARIABLES (
    ATDM07NU ATDM07GE ATDM07DT
    =
    PTpNumb PTpGeo PTpData
    ).

* Percent of students taught science topics.
RECODE
    ATDS06LI ATDS06PH ATDS06ES
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ATDS06LI ATDS06PH ATDS06ES
        (-99).
RENAME VARIABLES (
    ATDS06LI ATDS06PH ATDS06ES
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
    DPCDATE
    idbid
    .

* Update data set.
SAVE OUTFILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_11\T11_G4_3_Teacher.sav".

***** End script *****
