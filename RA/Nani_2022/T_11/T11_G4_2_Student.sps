* Encoding: UTF-8.

**** ADMIN INFO *****
* Date: 29 July 2021
* Author: Tony Tan
* Email: tctan@uio.no
* Position: PhD Candidate
* Organisation: CEMO, UV, UiO
* Script purpose: Data cleaning--Student

***** DATA ATTRIBUTES *****
* ILSA: TIMSS
* Cycle: 2011
* Questionnaire: Student
* Grade: Grade 4
* Subject: Math and Science

***** Begin script *****

* Import data.
GET FILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_11\T11_G4_0_Merge_student.sav".

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

*6: Grade ID.
RECODE
    IDGRADE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADE
        (-99).

* 7: Student gender.
RECODE
    ITSEX
        (1=0) (2=1)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ITSEX
        0 'Girl'
        1 'Boy'.
MISSING VALUES
    ITSEX
        (-99).
RENAME VARIABLES (
    ITSEX = SexBoy
    ).

* 8: Test administrator position.
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

*9: Language of student questionnaire.
RECODE
    ITLANG
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ITLANG
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
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E ASBG05F ASBG05G ASBG05H ASBG05I ASBG05J ASBG05K
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E ASBG05F ASBG05G ASBG05H ASBG05I ASBG05J ASBG05K
        0 'No'
        1 'Yes'.
MISSING VALUES
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E ASBG05F ASBG05G ASBG05H ASBG05I ASBG05J ASBG05K
        (-99).
RENAME VARIABLES (
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E ASBG05F ASBG05G ASBG05H ASBG05I ASBG05J ASBG05K
    =
    SESComO SESComS SESDesk SESRoom SESInter SESPhone SESGame SESCnt1 SESCnt2 SESCnt3 SESCnt4
    ).

* G6: Parents' country of birth.
RECODE
    ASBG06A ASBG06B
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG06A ASBG06B
        0 'Yes'
        1 'No'
        2 'I do not know'.
MISSING VALUES
    ASBG06A ASBG06B
        (-99).
RENAME VARIABLES (
    ASBG06A ASBG06B
    =
    MoBorn FaBorn
    ).

* G7: Student's country of birth.
RECODE
    ASBG07
    (1=0) (2=1)
    (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG07
        0 'Yes'
        1 'No'.
MISSING VALUES
    ASBG07
        (-99).
RENAME VARIABLES (
    ASBG07 = StdBorn
    ).

* G8: Student absenteism.
RECODE
    ASBG08
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG08
        0 'Never or almost never'
        1 'Once a month'
        2 'Once every two weeks'
        3 'Once a week or more'.
MISSING VALUES
    ASBG08
        (-99).
RENAME VARIABLES (
    ASBG08 = Absent
    ).

* G9: Student eat breakfast.
RECODE
    ASBG09
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG09
        0 'Never or almost never'
        1 'Sometimes'
        2 'Most days'
        3 'Every day'.
MISSING VALUES
    ASBG09
        (-99).
RENAME VARIABLES (
    ASBG09 = Breakf
    ).

* G10: Using computer or tablet for school work.
RECODE
    ASBG10A ASBG10B ASBG10C
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG10A ASBG10B ASBG10C
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every day or almost every day'.
MISSING VALUES
    ASBG10A ASBG10B ASBG10C
        (-99).
RENAME VARIABLES (
    ASBG10A ASBG10B ASBG10C
    =
    PCWkHome PCWkSch PCWkOth
    ).

* G11: Student sense of belonging.
RECODE
    ASBG11A ASBG11B ASBG11C ASBG11D ASBG11E ASBG11F ASBG11G
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG11A ASBG11B ASBG11C ASBG11D ASBG11E ASBG11F ASBG11G
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBG11A ASBG11B ASBG11C ASBG11D ASBG11E ASBG11F ASBG11G
        (-99).
RENAME VARIABLES (
    ASBG11A ASBG11B ASBG11C ASBG11D ASBG11E ASBG11F ASBG11G
    =
    BlgLike BlgSafe BlgSch BlgMate BlgFair BlgProud BlgLearn
    ).

* G12: Bullying.
RECODE
    ASBG12A ASBG12B ASBG12C ASBG12D ASBG12E ASBG12F ASBG12G ASBG12H
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG12A ASBG12B ASBG12C ASBG12D ASBG12E ASBG12F ASBG12G ASBG12H
        0 'Never'
        1 'A few times a year'
        2 'Once or twice a month'
        3 'At least once a week'.
MISSING VALUES
    ASBG12A ASBG12B ASBG12C ASBG12D ASBG12E ASBG12F ASBG12G ASBG12H
        (-99).
RENAME VARIABLES (
    ASBG12A ASBG12B ASBG12C ASBG12D ASBG12E ASBG12F ASBG12G ASBG12H
    =
    BlyFun BlyLeft BlyLies BlySteal BlyHit BlyForce BlyEmba BlyThrt
    ).

* MS1: Intrinsic motivation for learning math.
RECODE
    ASBM01A ASBM01B ASBM01C ASBM01D ASBM01E ASBM01F ASBM01G ASBM01H ASBM01I
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM01A ASBM01B ASBM01C ASBM01D ASBM01E ASBM01F ASBM01G ASBM01H ASBM01I
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM01A ASBM01B ASBM01C ASBM01D ASBM01E ASBM01F ASBM01G ASBM01H ASBM01I
        (-99).
RENAME VARIABLES (
    ASBM01A ASBM01B ASBM01C ASBM01D ASBM01E ASBM01F ASBM01G ASBM01H ASBM01I
    =
    MEnjoy MNotStdy MBorng MIntrst MLike MWrkNum MProblem MLokFrwd MFavSub
    ).

* MS2: Math teaching: Teacher support.
RECODE
    ASBM02A ASBM02B ASBM02C ASBM02D ASBM02E
    ASBM02F ASBM02G ASBM02H ASBM02I ASBM02J
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM02A ASBM02B ASBM02C ASBM02D ASBM02E
    ASBM02F ASBM02G ASBM02H ASBM02I ASBM02J
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM02A ASBM02B ASBM02C ASBM02D ASBM02E
    ASBM02F ASBM02G ASBM02H ASBM02I ASBM02J
        (-99).
RENAME VARIABLES (
    ASBM02A ASBM02B ASBM02C ASBM02D ASBM02E
    ASBM02F ASBM02G ASBM02H ASBM02I ASBM02J
    =
    MTcExp MTcEasy MTcInte MTcThig MTcClear
    MTcGood MTcShow MTcVary MTcImpr MTcLisn
    ).

* MS3: Self concept for math.
RECODE
    ASBM03A ASBM03B ASBM03C ASBM03D ASBM03E ASBM03F ASBM03G ASBM03H ASBM03I
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM03A ASBM03B ASBM03C ASBM03D ASBM03E ASBM03F ASBM03G ASBM03H ASBM03I
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM03A ASBM03B ASBM03C ASBM03D ASBM03E ASBM03F ASBM03G ASBM03H ASBM03I
        (-99).
RENAME VARIABLES (
    ASBM03A ASBM03B ASBM03C ASBM03D ASBM03E ASBM03F ASBM03G ASBM03H ASBM03I
    =
    MSCWell MSCHMate MSCNoGod MSCLearn MSCNervs MSCWork MSCGood MSCHSubj MSCConfs
    ).

* MS4: Intrinsic motivation for learning science.
RECODE
    ASBS04A ASBS04B ASBS04C ASBS04D ASBS04E ASBS04F ASBS04G ASBS04H ASBS04I
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS04A ASBS04B ASBS04C ASBS04D ASBS04E ASBS04F ASBS04G ASBS04H ASBS04I
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS04A ASBS04B ASBS04C ASBS04D ASBS04E ASBS04F ASBS04G ASBS04H ASBS04I
        (-99).
RENAME VARIABLES (
    ASBS04A ASBS04B ASBS04C ASBS04D ASBS04E ASBS04F ASBS04G ASBS04H ASBS04I
    =
    SEnjoy SNotStdy SBorng SIntrst SLike SLokFrwd STeach SSciEx SFavSub
    ).

* MS5: Science teaching: Teacher support.
RECODE
     ASBS05A ASBS05B ASBS05C ASBS05D ASBS05E
     ASBS05F ASBS05G ASBS05H ASBS05I ASBS05J
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
     ASBS05A ASBS05B ASBS05C ASBS05D ASBS05E
     ASBS05F ASBS05G ASBS05H ASBS05I ASBS05J
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
     ASBS05A ASBS05B ASBS05C ASBS05D ASBS05E
     ASBS05F ASBS05G ASBS05H ASBS05I ASBS05J
        (-99).
RENAME VARIABLES (
     ASBS05A ASBS05B ASBS05C ASBS05D ASBS05E
     ASBS05F ASBS05G ASBS05H ASBS05I ASBS05J
    =
    STcExp STcEasy STcInte STcThig STcClear
    STcGood STcShow STcVary STcImpr STcLisn
    ).

* MS6: Self concept for science.
RECODE
    ASBS06A ASBS06B ASBS06C ASBS06D ASBS06E ASBS06F ASBS06G
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS06A ASBS06B ASBS06C ASBS06D ASBS06E ASBS06F ASBS06G
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS06A ASBS06B ASBS06C ASBS06D ASBS06E ASBS06F ASBS06G
        (-99).
RENAME VARIABLES (
    ASBS06A ASBS06B ASBS06C ASBS06D ASBS06E ASBS06F ASBS06G
    =
    SSCWell SSCHard SSCNoGod SSCLearn SSCGood SSCHardMe SSCConfs
    ).

**************************
** Compound variables **
**************************

* Special accommodation\achievement session.
RECODE
    ITACCOMM1
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ITACCOMM1
        (-99).

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

* Student-level Jackknife zone.
RECODE
    JKZONE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKZONE
        (-99).

* Student-level Jackknife replicate.
RECODE
    JKREP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKREP
        (-99).

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
        1 'Sense of school belonging'
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
        (1=0) (2=1) (3=2)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSB
        0 'Almost never'
        1 'About monthly'
        2 'About weekly'.
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
        1 'Like learning mathematics'
        2 'Very much like learning mathematics'.
MISSING VALUES
    ASDGSLM
        (-99).
RENAME VARIABLES (
    ASDGSLM = IDXLikeM
    ).

* TIMSS construct: Engaging teaching in math lessons.
RECODE
    ASBGEML
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGEML
        (-99).
RENAME VARIABLES (
    ASBGEML = SCLEngM
    ).

* TIMSS construct: Instructional clarity in science lessons.
RECODE
    ASDGEML
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGEML
        0 'Less than engaging teaching'
        1 'Engaging teaching'
        2 'Very engagin teaching'.
MISSING VALUES
    ASDGEML
        (-99).
RENAME VARIABLES (
    ASDGEML = IDXEngM
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
        1 'Confident in mathematics'
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
        0 'Do not like learning science'
        1 'Like learning science'
        2 'Very much like learning science'.
MISSING VALUES
    ASDGSLS
        (-99).
RENAME VARIABLES (
    ASDGSLS = IDXLikeS
    ).

* TIMSS construct: Engaging teaching in science lessons.
RECODE
    ASBGESL
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGESL
        (-99).
RENAME VARIABLES (
    ASBGESL = SCLEngS
    ).

* TIMSS construct: Instructional clarity in science lessons.
RECODE
    ASDGESL
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGESL
        0 'Less than engaging teaching'
        1 'Engaging teaching'
        2 'Very engagin teaching'.
MISSING VALUES
    ASDGESL
        (-99).
RENAME VARIABLES (
    ASDGESL = IDXEngS
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
        1 'Confident in science'
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
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_11\T11_G4_2_Student.sav".

***** End script *****
