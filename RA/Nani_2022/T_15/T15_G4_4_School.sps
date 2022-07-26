* Encoding: UTF-8.

**** ADMIN INFO *****
* Date: 19 July 2021
* Author: Tony Tan
* Email: tctan@uio.no
* Position: PhD Candidate
* Organisation: CEMO, UV, UiO
* Script purpose: Data cleaning--School

***** DATA ATTRIBUTES *****
* ILSA: TIMSS
* Cycle: 2015
* Questionnaire: School
* Grade: Grade 4
* Subject: Math and Science

***** Begin script *****

* Import data.
GET FILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\T15_G4_0_Merge_school.sav".

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

*2: School ID.
RECODE
    IDSCHOOL
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDSCHOOL
        (-99).

**************************
** School variables **
**************************

* 03: Percentage of disadvantaged students attending the school.
RECODE
    ACBG03A ACBG03B
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG03A ACBG03B
        0 '0 to 10%'
        1 '11 to 25%'
        2 '26 to 50%'
        3 'More than 50%'.
MISSING VALUES
    ACBG03A ACBG03B
        (-99).
RENAME VARIABLES (
    ACBG03A ACBG03B
    =
    SchDisad SchEco
    ).

* 04: Percentage of students having the language of test as their native language.
RECODE
    ACBG04
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG04
        0 '25% or less'
        1 '26 to 50%'
        2 '51 to 75%'
        3 '76 to 90%'
        4 'More than 90%'.
MISSING VALUES
    ACBG04
        (-99).
RENAME VARIABLES (
    ACBG04 = SchLang
    ).

* 05A: Number of people live in the school area.
RECODE
    ACBG05A
        (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) (7=0)
        (99=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG05A
        0 '3,000 people or fewer'
        1 '3,001 to 15,000 people'
        2 '15,001 to 30,000 people'
        3 '30,001 to 50,000 people'
        4 '50,001 to 100,000 people'
        5 '100,001 to 500,000 people'
        6 'More than 500,000 people'.
MISSING VALUES
    ACBG05A
        (-99).
RENAME VARIABLES (
    ACBG05A = SchPop
    ).

* 05B: School location.
RECODE
    ACBG05B
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG05B
        (-99).
RENAME VARIABLES (
    ACBG05B = SchArea
    ).

* 06: Free meals.
RECODE
    ACBG06A ACBG06B
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG06A ACBG06B
        0 'No'
        1 'Yes, for some students'
        2 'Yes, for all students'.
MISSING VALUES
    ACBG06A ACBG06B
        (-99).
RENAME VARIABLES (
    ACBG06A ACBG06B
    =
    FreeBkf FreeLch
    ).

* 07: Health topics.
RECODE
    ACBG07A ACBG07B ACBG07C ACBG07D
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG07A ACBG07B ACBG07C ACBG07D
        0 'Low'
        1 'Medium'
        2 'High'
        3 'Very high'.
MISSING VALUES
    ACBG07A ACBG07B ACBG07C ACBG07D
        (-99).
RENAME VARIABLES (
    ACBG07A ACBG07B ACBG07C ACBG07D
    =
    HTopHand HTopTeth HTopNutr HTopPrev
    ).

* 08A & 08B: Instructional time.
RECODE
    ACBG08A ACBG08B
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG08A ACBG08B
        (-99).
RENAME VARIABLES (
    ACBG08A ACBG08B
    =
    SchDays SchTime
    ).

* 08C: Instructional time.
RECODE
    ACBG08C
        (1=4) (2=3) (3=2) (4=1) (5=0) (6=5)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG08C
        0 '4 days'
        1 '4 1/2 days'
        2 '5 days'
        3 '5 1/2 days'
        4 '6 days'
        5 'Other'.
MISSING VALUES
    ACBG08C
        (-99).
RENAME VARIABLES (
    ACBG08C = InstDay
    ).

* 09A: Schoolwork assistance place.
RECODE
    ACBG09A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG09A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG09A
        (-99).
RENAME VARIABLES (
    ACBG09A = WkAstPlc
    ).

* 09B: Schoolwork assistance staff.
RECODE
    ACBG09B
        (1=1) (2=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG09B
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG09B
        (-99).
RENAME VARIABLES (
    ACBG09B = WkAstStf
    ).

* 10: Achievement tracking.
RECODE
    ACBG10A ACBG10B
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
     ACBG10A ACBG10B
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG10A ACBG10B
        (-99).
RENAME VARIABLES (
    ACBG10A ACBG10B
    =
    AchTrM AchTrS
    ).

* 11: Number of computers at school.
RECODE
    ACBG11
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG11
        (-99).
RENAME VARIABLES (
    ACBG11 = NumComp
    ).

* 12A, 12B, & 13: Science laborat, Available assisstant for experiment, School library.
RECODE
    ACBG12A ACBG12B ACBG13
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG12A ACBG12B ACBG13
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG12A ACBG12B ACBG13
        (-99).
RENAME VARIABLES (
    ACBG12A ACBG12B ACBG13
    =
    SciLab AssLab Library
    ).

* 13AA & 13AB: Library books.
RECODE
    ACBG13AA ACBG13AB
        (1=0) (2=1) (3=2) (4=3) (5=4) (6=5)
        (96=-99) (99=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG13AA ACBG13AB
        0 '250 or fewer'
        1 '251--50'
        2 '501--2,000'
        3 '2,001--5,000'
        4 '5,001--10,000'
        5 'More than 10,000'.
MISSING VALUES
    ACBG13AA ACBG13AB
        (-99).
RENAME VARIABLES (
    ACBG13AA ACBG13AB
    =
    LibBkPt LibBkDg
    ).

* 13BA & 13BB: Library magazines.
RECODE
    ACBG13BA ACBG13BB
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG13BA ACBG13BB
        0 '0'
        1 '1--5'
        2 '6--10'
        3 '11--30'
        4 '31 or more'.
MISSING VALUES
    ACBG13BA ACBG13BB
        (-99).
RENAME VARIABLES (
    ACBG13BA ACBG13BB
    =
    LibMgPt LibMgDg
    ).

* 14: Shortage affecting school’s capacity to provide general instruction.
RECODE
    ACBG14AA ACBG14AB ACBG14AC ACBG14AD ACBG14AE ACBG14AF ACBG14AG ACBG14AH ACBG14AI
    ACBG14BA ACBG14BB ACBG14BC ACBG14BD ACBG14BE
    ACBG14CA ACBG14CB ACBG14CC ACBG14CD
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG14AA ACBG14AB ACBG14AC ACBG14AD ACBG14AE ACBG14AF ACBG14AG ACBG14AH ACBG14AI
    ACBG14BA ACBG14BB ACBG14BC ACBG14BD ACBG14BE
    ACBG14CA ACBG14CB ACBG14CC ACBG14CD
        0 'Not at all'
        1 'A little'
        2 'Some'
        3 'A lot'.
MISSING VALUES
    ACBG14AA ACBG14AB ACBG14AC ACBG14AD ACBG14AE ACBG14AF ACBG14AG ACBG14AH ACBG14AI
    ACBG14BA ACBG14BB ACBG14BC ACBG14BD ACBG14BE
    ACBG14CA ACBG14CB ACBG14CC ACBG14CD
        (-99).
RENAME VARIABLES (
    ACBG14AA ACBG14AB ACBG14AC ACBG14AD ACBG14AE ACBG14AF ACBG14AG ACBG14AH ACBG14AI
    ACBG14BA ACBG14BB ACBG14BC ACBG14BD ACBG14BE
    ACBG14CA ACBG14CB ACBG14CC ACBG14CD
    =
    SrtMatrl SrtSuply SrtBuild SrtHeat SrtSpace SrtTech SrtAudio SrtComp SrtDisab
    SrtMTch SrtMComp SrtMLib SrtMCal SrtMEqu
    SrtSTch SrtSComp SrtSLib SrtSEqu
    ).

* 15: School emphasis on academic success.
RECODE
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
    ACBG15K ACBG15L ACBG15M
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
    ACBG15K ACBG15L ACBG15M
        0 'Very low'
        1 'Low'
        2 'Medium'
        3 'High'
        4 'Very high'.
MISSING VALUES
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
    ACBG15K ACBG15L ACBG15M
        (-99).
RENAME VARIABLES (
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
    ACBG15K ACBG15L ACBG15M
    =
    STchUndC STchSucC STchExpC STchTogC STchInsC
    SParInvC SParComC SParExpC SParSuppC SParPresC
    SStdWellC SStdGoalC SStdRespC
    ).

* 16: School discipline and safety.
RECODE
    ACBG16A ACBG16B ACBG16C ACBG16D ACBG16E
    ACBG16F ACBG16G ACBG16H ACBG16I ACBG16J
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG16A ACBG16B ACBG16C ACBG16D ACBG16E
    ACBG16F ACBG16G ACBG16H ACBG16I ACBG16J
        0 'Not a problem'
        1 'Minor problem'
        2 'Moderate problem'
        3 'Serious problem'.
MISSING VALUES
    ACBG16A ACBG16B ACBG16C ACBG16D ACBG16E
    ACBG16F ACBG16G ACBG16H ACBG16I ACBG16J
        (-99).
RENAME VARIABLES (
    ACBG16A ACBG16B ACBG16C ACBG16D ACBG16E
    ACBG16F ACBG16G ACBG16H ACBG16I ACBG16J
    =
    SDLate SDAbsnt SDDistrb SDCheat SDProfnt
    SDVandl SDTheft SDIntim SDFight SDAbuse
    ).

* 17: Teacher problem.
RECODE
    ACBG17A ACBG17B
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG17A ACBG17B
        0 'Not a problem'
        1 'Minor problem'
        2 'Moderate problem'
        3 'Serious problem'.
MISSING VALUES
    ACBG17A ACBG17B
        (-99).
RENAME VARIABLES (
    ACBG17A ACBG17B
    =
    TchLate TchAbsent
    ).

* 18: School readiness.
RECODE
    ACBG18A ACBG18B ACBG18C ACBG18D ACBG18E
    ACBG18F ACBG18G ACBG18H ACBG18I ACBG18J ACBG18K
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG18A ACBG18B ACBG18C ACBG18D ACBG18E
    ACBG18F ACBG18G ACBG18H ACBG18I ACBG18J ACBG18K
        0 'less than 25%'
        1 '25 - 50%'
        2 '51 - 75%'
        3 'More than 75%'.
MISSING VALUES
    ACBG18A ACBG18B ACBG18C ACBG18D ACBG18E
    ACBG18F ACBG18G ACBG18H ACBG18I ACBG18J ACBG18K
        (-99).
RENAME VARIABLES (
    ACBG18A ACBG18B ACBG18C ACBG18D ACBG18E
    ACBG18F ACBG18G ACBG18H ACBG18I ACBG18J ACBG18K
    =
    SRLetter SRWord SRSenten SRWrite SRWrtWo
    SRCount SRNumber SRNumHIg SRWrtNum SRAdditn SRSubtr
    ).

* 19 & 20: Principal years of experience.
RECODE
    ACBG19 ACBG20
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG19 ACBG20
        (-99).
RENAME VARIABLES (
    ACBG19 ACBG20
    =
    PrcplYear PrYearSc
    ).

* 21: Principal highest level of education.
RECODE
    ACBG21
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG21
        0 'Did not complete <Bachelor’s or equivalent level--ISCED Level 6>'
        1 '<Bachelor’s or equivalent level--ISCED Level 6>'
        2 '<Master’s or equivalent level--ISCED Level 7>'
        3 '<Doctor or equivalent level--ISCED Level 8>'.
MISSING VALUES
    ACBG21
        (-99).
RENAME VARIABLES (
    ACBG21 = PrEdu
    ).

* 22: Principal qualification in educational leadership.
RECODE
    ACBG22A ACBG22B
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG22A ACBG22B
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG22A ACBG22B
        (-99).
RENAME VARIABLES (
    ACBG22A ACBG22B
    =
    PrLdrMas PrLdrDoc
    ).

**************************
** Compound Variables **
**************************

* Population ID.
RECODE
    IDPOP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDPOP
        (-99).

* Grade ID.
RECODE
    IDGRADE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADE
        (-99).

* Standardized grade ID.
RECODE
    IDGRADER
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDGRADER
        (-99).

* Weights, adjustments and factors.
RECODE
    SCHWGT STOTWGTU WGTADJ1 WGTFAC1
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    SCHWGT STOTWGTU WGTADJ1 WGTFAC1
        (-99).

* School-level Jackknife replicate.
RECODE
    JKCREP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKCREP
        (-99).

* School-level Jackknife zone.
RECODE
    JKCZONE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKCZONE
        (-99).

* TIMSS construct: Instruction affected by math resource shortage.
RECODE
    ACBGMRS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBGMRS
        (-99).
RENAME VARIABLES (
    ACBGMRS = SCLMRes
    ).

* TIMSS construct: Instruction affected by math resource shortage.
RECODE
    ACDGMRS
        (1=0) (2=1) (3=2)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGMRS
        0 'Not affected'
        1 'Somewhat affected'
        2 'Affected a lot'.
MISSING VALUES
    ACDGMRS
        (-99).
RENAME VARIABLES (
    ACDGMRS = IDXMRes
    ).

* TIMSS construct: Instruction affected by science resource shortage.
RECODE
    ACBGSRS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBGSRS
        (-99).
RENAME VARIABLES (
    ACBGSRS = SCLSRes
    ).

* TIMSS construct: Instruction affected by science resource shortage.
RECODE
    ACDGSRS
        (1=0) (2=1) (3=2)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGSRS
        0 'Not affected'
        1 'Somewhat affected'
        2 'Affected a lot'.
MISSING VALUES
    ACDGSRS
        (-99).
RENAME VARIABLES (
    ACDGSRS = IDXSRes
    ).

* TIMSS construct: SEAS principal.
RECODE
    ACBGEAS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBGEAS
        (-99).
RENAME VARIABLES (
    ACBGEAS = SCLseasC
    ).

* TIMSS construct: SEAS principal.
RECODE
    ACDGEAS
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGEAS
        0 'Medium emphasis'
        1 'High emphasis'
        2 'Very high emphasis'.
MISSING VALUES
    ACDGEAS
        (-99).
RENAME VARIABLES (
    ACDGEAS = IDXseasC
    ).

* TIMSS construct: School discipline--principal.
RECODE
    ACBGDAS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBGDAS
        (-99).
RENAME VARIABLES (
    ACBGDAS = SCLdiscp
    ).

* TIMSS construct: School discipline--principal.
RECODE
    ACDGDAS
        (1=0) (2=1) (3=2)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGDAS
        0 'Hardly any problems'
        1 'Minor problems'
        2 'Moderate to severe problems'.
MISSING VALUES
    ACDGDAS
        (-99).
RENAME VARIABLES (
    ACDGDAS = IDXdiscp
    ).

* TIMSS construct: Students enter with literacy and numeracy skills.
RECODE
    ACBGLNS
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBGLNS
        (-99).
RENAME VARIABLES (
    ACBGLNS = SCLready
    ).

* TIMSS construct: Students enter with literacy and numeracy skills.
RECODE
    ACDGLNS
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGLNS
        0 'Less than 25% enter with skills'
        1 '25--75% enter with skills'
        2 'More than 75% enter with skills'.
MISSING VALUES
    ACDGLNS
        (-99).
RENAME VARIABLES (
    ACDGLNS = IDXready
    ).

* School composition by socioeconomic background.
RECODE
    ACDG03
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDG03
        0 'More disadvantaged'
        1 'Neither more affluent nor more disadvantaged'
        2 'More affluent'.
MISSING VALUES
    ACDG03
        (-99).
RENAME VARIABLES (
    ACDG03 = SchSES
    ).

* Total instructional hours per year.
RECODE
    ACDG08HY
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACDG08HY
        (-99).
RENAME VARIABLES (
    ACDG08HY = InstHour
    ).

* Run script.
EXECUTE.

* Remove unwanted variable(s).
DELETE VARIABLES
    VERSION
    idbid
    .

* Update data set.
SAVE OUTFILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\T15_G4_4_School.sav".

***** End script *****
