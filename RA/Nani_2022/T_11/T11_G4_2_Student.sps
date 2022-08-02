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

*6: Grade ID.
RECODE
    IDGRADE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADE
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

* G2: Studen birth year and month.
RECODE
    ASBG02A ASBG02B
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBG02A ASBG02B
        (-99).

* G3: Student language at home.
RECODE
    ASBG03
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG03
        0 'Never'
        1 'Sometimes'
        2 'Always or almost always'.
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
       0 'None or few (0--10)'
       1 'One shelf (11--25)'
       2 'One bookcase (26--100)'
       3 'Two bookcases (101--200)'
       4 'Three or more bookcases (200+)'.
MISSING VALUES
    ASBG04
        (-99).
RENAME VARIABLES (
    ASBG04 = SESBook
    ).

* G5: SES: Home possession.
RECODE
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E
    ASBG05F ASBG05G ASBG05H ASBG05I ASBG05J ASBG05K
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E
    ASBG05F ASBG05G ASBG05H ASBG05I ASBG05J ASBG05K
        0 'No'
        1 'Yes'.
MISSING VALUES
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E
    ASBG05F ASBG05G ASBG05H ASBG05I ASBG05J ASBG05K
        (-99).
RENAME VARIABLES (
    ASBG05A ASBG05B ASBG05C ASBG05D ASBG05E
    ASBG05F ASBG05G ASBG05H ASBG05I ASBG05J ASBG05K
    =
    SESCom SESDesk SESOwnBk SESRoom SESInter
    SESCnt1 SESCnt2 SESCnt3 SESCnt4 SESCnt5 SESCnt6
    ).

* G6: Computer use.
RECODE
    ASBG06A ASBG06B ASBG06C
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG06A ASBG06B ASBG06C
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every day or almost every day'.
MISSING VALUES
    ASBG06A ASBG06B ASBG06C
        (-99).
RENAME VARIABLES (
    ASBG06A ASBG06B ASBG06C
    =
    CompHom CompSch CompOth
    ).

* G7: Parental interaction.
RECODE
    ASBG07A ASBG07B ASBG07C ASBG07D
        (1=3) (2=2) (3=1) (4=0)
    (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG07A ASBG07B ASBG07C ASBG07D
        0 'Never or almost never'
        1 'Once or twice a month'
        2 'Once or twice a week'
        3 'Every day or almost every day'.
MISSING VALUES
    ASBG07A ASBG07B ASBG07C ASBG07D
        (-99).
RENAME VARIABLES (
    ASBG07A ASBG07B ASBG07C ASBG07D
    =
    ParLearn ParSchWk ParTime ParCheck
    ).

* G8: Student sense of belonging.
RECODE
    ASBG08A ASBG08B ASBG08C
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBG08A ASBG08B ASBG08C
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBG08A ASBG08B ASBG08C
        (-99).
RENAME VARIABLES (
    ASBG08A ASBG08B ASBG08C
    =
    BlgLike BlgSafe BlgSch
    ).

* G9: Bullying.
RECODE
        ASBG09A ASBG09B ASBG09C ASBG09D ASBG09E ASBG09F
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
        ASBG09A ASBG09B ASBG09C ASBG09D ASBG09E ASBG09F
        0 'At least once a week'
        1 'Once or twice a month'
        2 'A few times a year'
        3 'Never'.
MISSING VALUES
        ASBG09A ASBG09B ASBG09C ASBG09D ASBG09E ASBG09F
        (-99).
RENAME VARIABLES (
        ASBG09A ASBG09B ASBG09C ASBG09D ASBG09E ASBG09F
    =
    BlyFun BlyLeft BlyLies BlySteal BlyHit BlyForce
    ).

* MS1: Intrinsic motivation for learning math (except B and C).
RECODE
    ASBM01A ASBM01D ASBM01E ASBM01F
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM01A ASBM01D ASBM01E ASBM01F
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM01A ASBM01D ASBM01E ASBM01F
        (-99).
RENAME VARIABLES (
    ASBM01A ASBM01D ASBM01E ASBM01F
    =
    MEnjoy MIntrst MLike MImport
    ).

* MS1: Intrinsic motivation for learning math (B and C: REVERSE CODING).
RECODE
    ASBM01B ASBM01C
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM01B ASBM01C
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disgree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ASBM01B ASBM01C
        (-99).
RENAME VARIABLES (
    ASBM01B ASBM01C
    =
    MNotStdy MBorng
    ).

* MS2: Math teaching: Teacher support (except B).
RECODE
    ASBM02A ASBM02C ASBM02D ASBM02E
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM02A ASBM02C ASBM02D ASBM02E
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM02A ASBM02C ASBM02D ASBM02E
        (-99).
RENAME VARIABLES (
    ASBM02A ASBM02C ASBM02D ASBM02E
    =
    MTcExp MTcEasy MTcInte MTcThig
    ).

* MS2: Math teaching: Teacher support (B: REVERSE CODING).
RECODE
    ASBM02B
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM02B
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disagree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ASBM02B
        (-99).
RENAME VARIABLES (
    ASBM02B = MTcUnrel
    ).

* MS3: Self concept for math (except B, C, and G).
RECODE
    ASBM03A ASBM03D ASBM03E ASBM03F
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM03A ASBM03D ASBM03E ASBM03F
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBM03A ASBM03D ASBM03E ASBM03F
        (-99).
RENAME VARIABLES (
    ASBM03A ASBM03D ASBM03E ASBM03F
    =
    MSCWell MSCLearn MSCWork MSCGood
    ).

* MS3: Self concept for math (B, C, and G: REVERSE CODING).
RECODE
    ASBM03B ASBM03C ASBM03G
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBM03B ASBM03C ASBM03G
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disagree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ASBM03B ASBM03C ASBM03G
        (-99).
RENAME VARIABLES (
    ASBM03B ASBM03C ASBM03G
    =
    MSCHMate MSCNoGod MSCHSubj
    ).

* MS4: Intrinsic motivation for learning science (except B and D).
RECODE
    ASBS04A ASBS04C ASBS04E ASBS04F ASBS04G
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS04A ASBS04C ASBS04E ASBS04F ASBS04G
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS04A ASBS04C ASBS04E ASBS04F ASBS04G
        (-99).
RENAME VARIABLES (
    ASBS04A ASBS04C ASBS04E ASBS04F ASBS04G
    =
    SEnjoy SSpareTm SIntrst SLike SImport
    ).

* MS4: Intrinsic motivation for learning science (B and D: REVERSE CODING).
RECODE
    ASBS04B ASBS04D
        (1=0) (2=1) (3=2) (4=3)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS04B ASBS04D
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS04B ASBS04D
        (-99).
RENAME VARIABLES (
    ASBS04B ASBS04D
    =
    SNotStdy SBorng
    ).

* MS5: Science teaching: Teacher support (except B).
RECODE
    ASBS05A ASBS05C ASBS05D ASBS05E
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS05A ASBS05C ASBS05D ASBS05E
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS05A ASBS05C ASBS05D ASBS05E
        (-99).
RENAME VARIABLES (
    ASBS05A ASBS05C ASBS05D ASBS05E
    =
    STcExp STcEasy STcInte STcThig
    ).

* MS5: Science teaching: Teacher support (B: REVERSE CODING).
RECODE
    ASBS05B
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS05B
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disgree a little'
        3 'Disgree a lot'.
MISSING VALUES
    ASBS05B
        (-99).
RENAME VARIABLES (
    ASBS05B = STcUnrel
    ).

* MS6: Self concept for science (except B, C, and F).
RECODE
    ASBS06A ASBS06D ASBS06E
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS06A ASBS06D ASBS06E
        0 'Disagree a lot'
        1 'Disagree a little'
        2 'Agree a little'
        3 'Agree a lot'.
MISSING VALUES
    ASBS06A ASBS06D ASBS06E
        (-99).
RENAME VARIABLES (
    ASBS06A ASBS06D ASBS06E
    =
    SSCWell SSCLearn SSCGood
    ).

* MS6: Self concept for science (B, C, and E: REVERSE CODING).
RECODE
    ASBS06B ASBS06C ASBS06F
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASBS06B ASBS06C ASBS06F
        0 'Agree a lot'
        1 'Agree a little'
        2 'Disgree a little'
        3 'Disagree a lot'.
MISSING VALUES
    ASBS06B ASBS06C ASBS06F
        (-99).
RENAME VARIABLES (
    ASBS06B ASBS06C ASBS06F
    =
    SSCHard SSCNoGod SSCHardMe
    ).

**************************
** Compound variables **
**************************

* System ID student background file.

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

* Conditioning variable.
RECODE
    CONDVAR1
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    CONDVAR1
        (-99).

* Student age.
RECODE
    ASDAGE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASDAGE
        (-99).

* Stratification.
RECODE
    IDSTRATE IDSTRATI
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDSTRATE IDSTRATI
        (-99).

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

* TIMSS construct: Bullying.
RECODE
    ASBGSBS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGSBS
        (-99).
RENAME VARIABLES (
    ASBGSBS = SCLBully
    ).

* TIMSS construct: Bullying.
RECODE
    ASDGSBS
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGSBS
        0 'About weekly'
        1 'About monthly'
        2 'Almost never'.
MISSING VALUES
    ASDGSBS
        (-99).
RENAME VARIABLES (
    ASDGSBS = IDXBully
    ).

* TIMSS construct: Students like learning mathematics.
RECODE
    ASBGSLM
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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

* TIMSS construct: Students like learning science.
RECODE
    ASBGSLS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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

* TIMSS construct: Students confident in mathematics.
RECODE
    ASBGSCM
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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


* TIMSS construct: Students confident in science.
RECODE
    ASBGSCS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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

* TIMSS construct: Student engaged in math lessons.
RECODE
    ASBGEML
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGEML
        (-99).
RENAME VARIABLES (
    ASBGEML = SCLEngM
    ).

* TIMSS construct: Student engaged in math lessons.
RECODE
    ASDGEML
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGEML
        0 'Not engaged'
        1 'Somewhat engaged'
        2 'Engaged'.
MISSING VALUES
    ASDGEML
        (-99).
RENAME VARIABLES (
    ASDGEML = IDXEngM
    ).

* TIMSS construct: Student engaged in science lessons.
RECODE
    ASBGESL
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ASBGESL
        (-99).
RENAME VARIABLES (
    ASBGESL = SCLEngS
    ).

* TIMSS construct: Student engaged in science lessons.
RECODE
    ASDGESL
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ASDGESL
        0 'Not engaged'
        1 'Somewhat engaged'
        2 'Engaged'.
MISSING VALUES
    ASDGESL
        (-99).
RENAME VARIABLES (
    ASDGESL = IDXEngS
    ).

* Number of home study supports.
RECODE
    ASDG05S
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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
    ITBIRTHD
    ITBIRTHM
    ITBIRTHY
    ITSEX
    ITADMINI
    ITDATE
    ITLANG
    SSYSTEM
    ITACCOMM1
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
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_11\T11_G4_2_Student.sav".

***** End script *****
