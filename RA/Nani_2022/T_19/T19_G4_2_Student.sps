* Encoding: UTF-8.

**** ADMIN INFO *****
* Date: 21 July 2021
* Author: Tony Tan
* Email: tctan@uio.no
* Position: Research Assistant
* Organisation: CEMO, UV, UiO
* Script purpose: Data cleaning--Student

***** DATA ATTRIBUTES *****
* ILSA: TIMSS
* Cycle: 2019
* Questionnaire: Student
* Grade: Grade 4
* Subject: Math and Science

***** Begin script *****

* Import data.
GET FILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\T19_G4_0_Merge_student.sav".

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

**************************
** Student variables **
**************************

* G1: Student gender.
RECODE
    ASBG01
        (1=0) (2=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG01
        0 'Girl'
        1 'Boy'.
MISSING VALUES
    ASBG01
        (-99).
RENAME VARIABLES (
    ASBG01 = GendBoy
    ).

* G2: Studen birth year and month. No action required.

* G3: Student language at home.
RECODE
    ASBG03
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG03
        0 'I never speak <language of test> at home'
        1 'I sometimes speak <language of test> and sometimes speak another language at home'
        2 'I almost always speak <language of test> at home'
        3 'I always speak <language of test> at home'.
MISSING VALUES
    ASBG03
        (-99).
RENAME VARIABLES (
    ASBG03 = StdLang
    ).

* G4: SES: Number of books at home.
RECODE
    ASBG04
         (1=0) (2=1) (3=2) (4=3) (5=4)
         (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG04
       0 'None or very few (0--10 books)'
       1 'Enough to fill one shelf (11--25 books)'
       2 'Enough to fill one bookcase (26--100 books)'
       3 'Enough to fill two bookcases (101--200 books)'
       4 'Enough to fill three or more bookcases (more than 200)'.
MISSING VALUES
    ASBG04
        (-99).
RENAME VARIABLES (
    ASBG04 = SESBook
    ).

* G5: SES: Home possession.
RECODE
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E ASBG05F ASBG05G ASBG05H ASBG05I
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E ASBG05F ASBG05G ASBG05H ASBG05I
        0 'No'
        1 'Yes'.
MISSING VALUES
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E ASBG05F ASBG05G ASBG05H ASBG05I
        (-99).
RENAME VARIABLES (
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E ASBG05F ASBG05G ASBG05H ASBG05I
    =
    SESComp SESDesk SESRoom SESInter SESPhone SESCnt1 SESCnt2 SESCnt3 SESCnt4
    ).

* G6: Parents' country of birth.
RECODE
    ASBG06A ASBG06B
        (1=1) (2=0) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG06A ASBG06B
        0 'No'
        1 'Yes'
        2 'I do not know'
        3 'Not applicable'.
MISSING VALUES
    ASBG06A ASBG06B
        (-99).
RENAME VARIABLES (
    ASBG06A ASBG06B
    =
    FaBorn MoBorn
    ).

* G7: Student's country of birth.
RECODE
    ASBG07
    (1=1) (2=0)
    (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG07
        0 'No'
        1 'Yes'.
MISSING VALUES
    ASBG07
        (-99).
RENAME VARIABLES (
    ASBG07 = StdBorn
    ).

* G8: Student absenteism.
RECODE
    ASBG08
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG08
        0 'Never or almost never'
        1 'Once every two months'
        2 'Once a month'
        3 'Once every two weeks'
        4 'Once a week'.
MISSING VALUES
    ASBG08
        (-99).
RENAME VARIABLES (
    ASBG08 = Absent
    ).

* G9: Student tired and hungry.
RECODE
    ASBG09A ASBG09B
        (1=0) (2=2) (3=3) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG09A ASBG09B
        0 'Every day'
        1 'Almost every day'
        2 'Sometimes'
        3 'Never'.
MISSING VALUES
    ASBG09A ASBG09B
        (-99).
RENAME VARIABLES (
    ASBG09A ASBG09B
    =
    Tired Hungry
    ).

* G10: Student sense of belonging.
RECODE
    ASBG10A ASBG10B ASBG10C ASBG10D ASBG10E
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBG10A ASBG10B ASBG10C ASBG10D ASBG10E
        (-99).
RENAME VARIABLES (
    ASBG10A ASBG10B ASBG10C ASBG10D ASBG10E
    =
    BlgLike BlgSafe BlgSch BlgFair BlgProud
    ).

* G11: Bullying.
RECODE
    ASBG11A ASBG11B ASBG11C ASBG11D ASBG11E ASBG11F
    ASBG11G ASBG11H ASBG11I ASBG11J ASBG11K
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG11A ASBG11B ASBG11C ASBG11D ASBG11E ASBG11F
    ASBG11G ASBG11H ASBG11I ASBG11J ASBG11K
        0 'At least once a week'
        1 'Once or twice a month'
        2 'A few times a year'
        3 'Never'.
MISSING VALUES
    ASBG11A ASBG11B ASBG11C ASBG11D ASBG11E ASBG11F
    ASBG11G ASBG11H ASBG11I ASBG11J ASBG11K
        (-99).
RENAME VARIABLES (
    ASBG11A ASBG11B ASBG11C ASBG11D ASBG11E ASBG11F
    ASBG11G ASBG11H ASBG11I ASBG11J ASBG11K
    =
    BlyFun BlyLeft BlyLies BlySteal BlyDamge BlyHit
    BlyForce BlyMsg BlyRmr BlyPics BlyThrt
    ).

* MS1: Math work problem.
RECODE
    ASBM01
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM01
        0 'Never'
        1 'Some lesons'
        2 'About half the lessons'
        3 'Every or almost every lesson'.
MISSING VALUES
    ASBM01
        (-99).
RENAME VARIABLES (
    ASBM01 = WorkProb
    ).

* MS2: Intrinsic motivation for learning math (except B and C).
RECODE
    ASBM02A ASBM02D ASBM02E ASBM02F ASBM02G ASBM02H ASBM02I
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM02A ASBM02D ASBM02E ASBM02F ASBM02G ASBM02H ASBM02I
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM02A ASBM02D ASBM02E ASBM02F ASBM02G ASBM02H ASBM02I
        (-99).
RENAME VARIABLES (
    ASBM02A ASBM02D ASBM02E ASBM02F ASBM02G ASBM02H ASBM02I
    =
    MEnjoy MIntrst MLike MWrkNum MProblem MLokFrwd MFavSub
    ).

* MS2: Intrinsic motivation for learning math (B and C: REVERSE CODING).
RECODE
    ASBM02B ASBM02C
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM02B ASBM02C
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disagree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ASBM02B ASBM02C
        (-99).
RENAME VARIABLES (
    ASBM02B ASBM02C
    =
    MNotStdy MBorng
    ).

* MS3: Math teaching: Teacher support.
RECODE
    ASBM03A ASBM03B ASBM03C ASBM03D ASBM03E ASBM03F
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM03A ASBM03B ASBM03C ASBM03D ASBM03E ASBM03F
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM03A ASBM03B ASBM03C ASBM03D ASBM03E ASBM03F
        (-99).
RENAME VARIABLES (
    ASBM03A ASBM03B ASBM03C ASBM03D ASBM03E ASBM03F
    =
    MTcExp MTcEasy MTcClear MTcGood MTcVary MTcExpA
    ).

* MS4: Math teaching: Classroom management.
RECODE
    ASBM04A ASBM04B ASBM04C ASBM04D ASBM04E ASBM04F
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM04A ASBM04B ASBM04C ASBM04D ASBM04E ASBM04F
        0 'Every or almost every lesson'
        1 'About half the lessons'
        2 'Some lessons'
        3 'Never'.
MISSING VALUES
    ASBM04A ASBM04B ASBM04C ASBM04D ASBM04E ASBM04F
        (-99).
RENAME VARIABLES (
    ASBM04A ASBM04B ASBM04C ASBM04D ASBM04E ASBM04F
    =
    MTcListen MTcNoise MTcDisor MTcQuiet MTcIntrpt MTcRule
    ).

* MS5: Self concept for math (except B, C, E, H, and I).
RECODE
    ASBM05A ASBM05D ASBM05F ASBM05G
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM05A ASBM05D ASBM05F ASBM05G
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM05A ASBM05D ASBM05F ASBM05G
        (-99).
RENAME VARIABLES (
    ASBM05A ASBM05D ASBM05F ASBM05G
    =
    MSCWell MSCLearn MSCWork MSCGood
    ).

* MS5: Self concept for math (B, C, E, H, and I: REVERSE CODING).
RECODE
    ASBM05B ASBM05C ASBM05E ASBM05H ASBM05I
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM05B ASBM05C ASBM05E ASBM05H ASBM05I
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disagree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ASBM05B ASBM05C ASBM05E ASBM05H ASBM05I
        (-99).
RENAME VARIABLES (
    ASBM05B ASBM05C ASBM05E ASBM05H ASBM05I
    =
    MSCHMate MSCNoGod MSCNervs MSCHSubj MSCConfs
    ).

* MS6: Science experiment.
RECODE
    ASBS06
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS06
        0 'Never'
        1 'A few times a year'
        2 'Once or twice a month'
        3 'At least once a week'.
MISSING VALUES
    ASBS06
        (-99).
RENAME VARIABLES (
    ASBS06 = SconExpr
    ).

* MS7: Intrinsic motivation for learning science (except B and C).
RECODE
    ASBS07A ASBS07D ASBS07E ASBS07F ASBS07G ASBS07H ASBS07I
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS07A ASBS07D ASBS07E ASBS07F ASBS07G ASBS07H ASBS07I
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS07A ASBS07D ASBS07E ASBS07F ASBS07G ASBS07H ASBS07I
        (-99).
RENAME VARIABLES (
    ASBS07A ASBS07D ASBS07E ASBS07F ASBS07G ASBS07H ASBS07I
    =
    SEnjoy SIntrst SLike SLokFrwd STeach SSciEx SFavSub
    ).


* MS7: Intrinsic motivation for learning science (B and C: REVERSE CODING).
RECODE
    ASBS07B ASBS07C
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS07B ASBS07C
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disagree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ASBS07B ASBS07C
        (-99).
RENAME VARIABLES (
    ASBS07B ASBS07C
    =
    SNotStdy SBorng
    ).

* MS8: Science teaching: Teacher support.
RECODE
     ASBS08A ASBS08B ASBS08C ASBS08D ASBS08E ASBS08F
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS08A ASBS08B ASBS08C ASBS08D ASBS08E ASBS08F
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS08A ASBS08B ASBS08C ASBS08D ASBS08E ASBS08F
        (-99).
RENAME VARIABLES (
    ASBS08A ASBS08B ASBS08C ASBS08D ASBS08E ASBS08F
    =
    STcExp STcEasy STcClear STcGood STcVary STcExpA
    ).

* MS9: Self concept for science (except B, C, F, and G).
RECODE
    ASBS09A ASBS09D ASBS09E
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS09A ASBS09D ASBS09E
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS09A ASBS09D ASBS09E
        (-99).
RENAME VARIABLES (
    ASBS09A ASBS09D ASBS09E
    =
    SSCWell SSCLearn SSCGood
    ).

* MS9: Self concept for science (B, C, F, and G: REVERSE CODING).
RECODE
    ASBS09B ASBS09C ASBS09F ASBS09G
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS09B ASBS09C ASBS09F ASBS09G
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disagree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ASBS09B ASBS09C ASBS09F ASBS09G
        (-99).
RENAME VARIABLES (
    ASBS09B ASBS09C ASBS09F ASBS09G
    =
    SSCHard SSCNoGod SSCHardMe SSCConfs
    ).

* e1A: Like test on computer or tablet.
RECODE
    ASBE01A
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBE01A
        0 'I did not like it at all'
        1 'I did not like it very much'
        2 'I liked it a little'
        3 'I liked it a lot'.
MISSING VALUES
    ASBE01A
        (-99).
RENAME VARIABLES (
    ASBE01A = CBALike
    ).

* e1B: Difficulties in computer based testing.
RECODE
    ASBE01BA ASBE01BB ASBE01BC ASBE01BD ASBE01BE ASBE01BF
        (1=1) (2=0) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBE01BA ASBE01BB ASBE01BC ASBE01BD ASBE01BE ASBE01BF
        0 'No'
        1 'Yes'.
MISSING VALUES
    ASBE01BA ASBE01BB ASBE01BC ASBE01BD ASBE01BE ASBE01BF
        (-99).
RENAME VARIABLES (
    ASBE01BA ASBE01BB ASBE01BC ASBE01BD ASBE01BE ASBE01BF
    =
    CBAType CBAPad CBADrag CBAPlace CBASlow CBAProb
    ).

* e2: Using computer or tablet for school work.
RECODE
    ASBE02A ASBE02B ASBE02C ASBE02D
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBE02A ASBE02B ASBE02C ASBE02D
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every day or almost every day'.
MISSING VALUES
    ASBE02A ASBE02B ASBE02C ASBE02D
        (-99).
RENAME VARIABLES (
    ASBE02A ASBE02B ASBE02C ASBE02D
    =
    PCSchAss PCMatSch PCSciSch PCQuiz
    ).

* e3: Student familiarity in using computer or tablet.
RECODE
    ASBE03A ASBE03B ASBE03C ASBE03D ASBE03E ASBE03F ASBE03G
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBE03A ASBE03B ASBE03C ASBE03D ASBE03E ASBE03F ASBE03G
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBE03A ASBE03B ASBE03C ASBE03D ASBE03E ASBE03F ASBE03G
        (-99).
RENAME VARIABLES (
    ASBE03A ASBE03B ASBE03C ASBE03D ASBE03E ASBE03F ASBE03G
    =
    PCGood PCType PCScreen PCInfo PCWord PCParag PCText
    ).

**************************
** Compound variables **
**************************
* Population ID.
RECODE
    IDPOP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDPOP
        (-99).

* Standardized grade ID.
RECODE
    IDGRADER
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADER
        (-99).

* Grade ID.
RECODE
    IDGRADE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADE
        (-99).

* Language of student context questionnaire.
RECODE
    ITLANG_SQ
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ITLANG_SQ
        (-99).

* Locale ID of student context questionnaire.
RECODE
    LCID_SQ
        (9999999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    LCID_SQ
        (-99).

* Language of student achievement test.
RECODE
    ITLANG_SA
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ITLANG_SA
        (-99).

* Locale ID of student achievement test.
RECODE
    LCID_SA
        (9999999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    LCID_SA
        (-99).

* Student gender.
RECODE
    ITSEX
        (1=0) (2=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ITSEX
        0 'Female'
        1 'Male'.
MISSING VALUES
    ITSEX
        (-99).
RENAME VARIABLES (
    ITSEX = SexBoy
    ).

* Student age.
RECODE
    ASDAGE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASDAGE
        (-99).
RENAME VARIABLES (
    ASDAGE = StdAge
    ).

* Test administrator position.
RECODE
    ITADMINI
        (1=0) (2=1) (3=2)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ITADMINI
        0 'National center staff'
        1 'Teacher from school'
        2 'Other'.
MISSING VALUES
    ITADMINI
        (-99).
RENAME VARIABLES (
    ITADMINI = TestAdm
    ).

* Weights, adjustments and factors.
RECODE
    TOTWGT HOUWGT SENWGT
    WGTADJ1 WGTADJ2 WGTADJ3
    WGTFAC1 WGTFAC2 WGTFAC3
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    TOTWGT HOUWGT SENWGT
    WGTADJ1 WGTADJ2 WGTADJ3
    WGTFAC1 WGTFAC2 WGTFAC3
        (-99).

* Student-level Jackknife replicate.
RECODE
    JKREP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKREP
        (-99).

* Student-level Jackknife zone.
RECODE
    JKZONE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKZONE
        (-99).

* TIMSS construct: Disorderly behavior during math lesson.
RECODE
    ASBGDML
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGDML
        (-99).
RENAME VARIABLES (
    ASBGDML = SCLDisor
    ).

* TIMSS construct: Disorderly behavior during math lesson.
RECODE
    ASDGDML
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGDML
        0 'Most lessons'
        1 'Some lessons'
        2 'Few or no lessons'.
MISSING VALUES
    ASDGDML
        (-99).
RENAME VARIABLES (
    ASDGDML = IDXDisor
    ).

* TIMSS construct: Instructional clarity in mathematics lessons.
RECODE
    ASBGICM
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGICM
        (-99).
RENAME VARIABLES (
    ASBGICM = SCLClrtM
    ).

* TIMSS construct: Instructional clarity in mathematics lessons.
RECODE
    ASDGICM
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGICM
        0 'Low clarity of instruction'
        1 'Moderate clarity of instruction'
        2 'High clarity of instruction'.
MISSING VALUES
    ASDGICM
        (-99).
RENAME VARIABLES (
    ASDGICM = IDXClrtM
    ).

* TIMSS construct: Student sense of school belonging.
RECODE
    ASBGSSB
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGSSB
        (-99).
RENAME VARIABLES (
    ASBGSSB = SCLBlong
    ).

* TIMSS construct: Student sense of school belonging.
RECODE
    ASDGSSB
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSSB
        0 'Little sense of school belonging'
        1 'Some sense of school belonging'
        2 'High sense of school belonging'.
MISSING VALUES
    ASDGSSB
        (-99).
RENAME VARIABLES (
    ASDGSSB = IDXBlong
    ).

* TIMSS construct: Bullying.
RECODE
    ASBGSB
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGSB
        (-99).
RENAME VARIABLES (
    ASBGSB = SCLBully
    ).

* TIMSS construct: Bullying.
RECODE
    ASDGSB
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSB
        0 'About weekly'
        1 'About monthly'
        2 'Never or almost never'.
MISSING VALUES
    ASDGSB
        (-99).
RENAME VARIABLES (
    ASDGSB = IDXBully
    ).

* TIMSS construct: Students like learning mathematics.
RECODE
    ASBGSLM
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGSLM
        (-99).
RENAME VARIABLES (
    ASBGSLM = SCLLikeM
    ).

* TIMSS construct: Students like learning mathematics.
RECODE
    ASDGSLM
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSLM
        0 'Do not like learning mathematics'
        1 'Somewhat like learning mathematics'
        2 'Very much like learning mathematics'.
MISSING VALUES
    ASDGSLM
        (-99).
RENAME VARIABLES (
    ASDGSLM = IDXLikeM
    ).

* TIMSS construct: Instructional clarity in science lessons.
RECODE
    ASBGICS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGICS
        (-99).
RENAME VARIABLES (
    ASBGICS = SCLClrtS
    ).

* TIMSS construct: Instructional clarity in science lessons.
RECODE
    ASDGICS
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGICS
        0 'Low clarity of instruction'
        1 'Moderate clarity of instruction'
        2 'High clarity of instruction'.
MISSING VALUES
    ASDGICS
        (-99).
RENAME VARIABLES (
    ASDGICS = IDXClrtS
    ).

* TIMSS construct: Students confident in mathematics.
RECODE
    ASBGSCM
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGSCM
        (-99).
RENAME VARIABLES (
    ASBGSCM = SCLConfM
    ).

* TIMSS construct: Students confident in mathematics.
RECODE
    ASDGSCM
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSCM
        0 'Not confident in mathematics'
        1 'Somewhat confident in mathematics'
        2 'Very confident in mathematics'.
MISSING VALUES
    ASDGSCM
        (-99).
RENAME VARIABLES (
    ASDGSCM = IDXConfM
    ).

* TIMSS construct: Students like learning science.
RECODE
    ASBGSLS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGSLS
        (-99).
RENAME VARIABLES (
    ASBGSLS = SCLLikeS
    ).

* TIMSS construct: Students like learning science.
RECODE
    ASDGSLS
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSLS
        0 'Do not learning science'
        1 'Somewhat like learning science'
        2 'Very much like learning science'.
MISSING VALUES
    ASDGSLS
        (-99).
RENAME VARIABLES (
    ASDGSLS = IDXLikeS
    ).

* TIMSS construct: Students confident in science.
RECODE
    ASBGSCS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGSCS
        (-99).
RENAME VARIABLES (
    ASBGSCS = SCLConfS
    ).

* TIMSS construct: Students confident in science.
RECODE
    ASDGSCS
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSCS
        0 'Not confident in science'
        1 'Somewhat confident in science'
        2 'Very confident in science'.
MISSING VALUES
    ASDGSCS
        (-99).
RENAME VARIABLES (
    ASDGSCS = IDXConfS
    ).

* TIMSS construct: Home resources for learning.
RECODE
    ASBGHRL
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGHRL
        (-99).
RENAME VARIABLES (
    ASBGHRL = SCLHmSES
    ).

* TIMSS construct: Home resources for learning.
RECODE
    ASDGHRL
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGHRL
        0 'Few resources'
        1 'Some resources'
        2 'Many resources'.
MISSING VALUES
    ASDGHRL
        (-99).
RENAME VARIABLES (
    ASDGHRL = IDXHmSES
    ).

* TIMSS construct: Self-efficacy for computer use.
RECODE
    ASBGSEC
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGSEC
        (-99).
RENAME VARIABLES (
    ASBGSEC = SCLComSE
    ).

* TIMSS construct: Self-efficacy for computer use.
RECODE
    ASDGSEC
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSEC
        0 'Low self-efficacy'
        1 'Medium self-efficacy'
        2 'High self-efficacy'.
MISSING VALUES
    ASDGSEC
        (-99).
RENAME VARIABLES (
    ASDGSEC = IDXComSE
    ).

* Number of home study supports.
RECODE
    ASDG05S
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASDG05S
        (-99).
RENAME VARIABLES (
    ASDG05S = NStudSup
    ).

* Mathematics achievement too low for estimation.
RECODE
    ASDMLOWP
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDMLOWP
        0 'No'
        1 'Yes'.
MISSING VALUES
    ASDMLOWP
        (-99).
RENAME VARIABLES (
    ASDMLOWP = MAchLow
    ).

* Science achievement too low for estimation.
RECODE
    ASDSLOWP
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDSLOWP
        0 'No'
        1 'Yes'.
MISSING VALUES
    ASDSLOWP
        (-99).
RENAME VARIABLES (
    ASDSLOWP = SAchLow
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
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\T19_G4_2_Student.sav".

***** End script *****
