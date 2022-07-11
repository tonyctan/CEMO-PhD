* Encoding: UTF-8.

**** ADMIN INFO *****
* Date: 10 July 2021
* Author: Tony Tan
* Email: tctan@uio.no
* Position: PhD Candidate
* Organisation: CEMO, UV, UiO
* Script purpose: Data cleaning--School

***** DATA ATTRIBUTES *****
* ILSA: TIMSS
* Cycle: 2019
* Questionnaire: School
* Grade: Grade 4
* Subject: Math and Science

***** Begin script *****

* Import data.
GET FILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\T19_G4_0_Merge_school.sav".

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

* 06AB: Instructional time.
RECODE
    ACBG06A ACBG06B
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG06A ACBG06B
        (-99).
RENAME VARIABLES (
    ACBG06A ACBG06B
    =
    SchDays SchTime
    ).

* 06C: Instructional time.
RECODE
    ACBG06C
        (1=4) (2=3) (3=2) (4=1) (5=0) (6=5)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG06C
        0 '4 days'
        1 '4 1/2 days'
        2 '5 days'
        3 '5 1/2 days'
        4 '6 days'
        5 'Other'.
MISSING VALUES
    ACBG06C
        (-99).
RENAME VARIABLES (
    ACBG06C = InstDay
    ).

* 07: Number of computers at school.
RECODE
    ACBG07
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG07
        (-99).
RENAME VARIABLES (
    ACBG07 = NumComp
    ).

* 08AB,9,10A: Science laborat, Available assisstant for experiment,Access to learning management system,School library.
RECODE
    ACBG08A ACBG08B ACBG09 ACBG10A
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG08A ACBG08B ACBG09 ACBG10A
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG08A ACBG08B ACBG09 ACBG10A
        (-99).
RENAME VARIABLES (
    ACBG08A ACBG08B ACBG09 ACBG10A
    =
    SciLab AssLab NettLMS Library
    ).

* 10B: The number of books in the library.
RECODE
    ACBG10B
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG10B
        (-99).
RENAME VARIABLES (
    ACBG10B = ManyBook
    ).

* 11,12: Classroom library, Access to digital learning resources.
RECODE
    ACBG11 ACBG12
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG11 ACBG12
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG11 ACBG12
        (-99).
RENAME VARIABLES (
    ACBG11 ACBG12
    =
    LibClass DgtlLearn
    ).

* 13: Shortage affecting school’s capacity to provide general instruction.
RECODE
    ACBG13AA ACBG13AB ACBG13AC ACBG13AD ACBG13AE ACBG13AF
    ACBG13AG ACBG13AH ACBG13AI ACBG13BA ACBG13BB ACBG13BC
    ACBG13BD ACBG13BE ACBG13CA ACBG13CB ACBG13CC ACBG13CD
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG13AA ACBG13AB ACBG13AC ACBG13AD ACBG13AE ACBG13AF
    ACBG13AG ACBG13AH ACBG13AI ACBG13BA ACBG13BB ACBG13BC
    ACBG13BD ACBG13BE ACBG13CA ACBG13CB ACBG13CC ACBG13CD
        0 'Not at all'
        1 'A little'
        2 'Some'
        3 'A lot'.
MISSING VALUES
    ACBG13AA ACBG13AB ACBG13AC ACBG13AD ACBG13AE ACBG13AF
    ACBG13AG ACBG13AH ACBG13AI ACBG13BA ACBG13BB ACBG13BC
    ACBG13BD ACBG13BE ACBG13CA ACBG13CB ACBG13CC ACBG13CD
        (-99).
RENAME VARIABLES (
    ACBG13AA ACBG13AB ACBG13AC ACBG13AD ACBG13AE ACBG13AF
    ACBG13AG ACBG13AH ACBG13AI ACBG13BA ACBG13BB ACBG13BC
    ACBG13BD ACBG13BE ACBG13CA ACBG13CB ACBG13CC ACBG13CD
    =
    SrtMatrl SrtSuply SrtBuild SrtHeat SrtSpace SrtTech
    SrtAudio SrtComp SrtDisab SrtMTch SrtMComp SrtMLib
    SrtMCal SrtMEqu SrtSTch SrtSComp SrtSLib SrtSEqu
    ).

* 14: School emphasis on academic success.
RECODE
    ACBG14A ACBG14B ACBG14C ACBG14D
    ACBG14E ACBG14F ACBG14G ACBG14H
    ACBG14I ACBG14J ACBG14K
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG14A ACBG14B ACBG14C ACBG14D
    ACBG14E ACBG14F ACBG14G ACBG14H
    ACBG14I ACBG14J ACBG14K
        0 'Very low'
        1 'Low'
        2 'Medium'
        3 'High'
        4 'Very high'.
MISSING VALUES
    ACBG14A ACBG14B ACBG14C ACBG14D
    ACBG14E ACBG14F ACBG14G ACBG14H
    ACBG14I ACBG14J ACBG14K
        (-99).
RENAME VARIABLES (
    ACBG14A ACBG14B ACBG14C ACBG14D
    ACBG14E ACBG14F ACBG14G ACBG14H
    ACBG14I ACBG14J ACBG14K
    =
    STchUndC STchSucC STchExpC STchInsC
    SParInvC SParComC SParExpC SParSuppC
    SStdWellC SStdGoalC SStdRespC
    ).

* 15: School discipline and safety.
RECODE
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
        0 'Not a problem'
        1 'Minor problem'
        2 'Moderate problem'
        3 'Serious problem'.
MISSING VALUES
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
        (-99).
RENAME VARIABLES (
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
    =
    SDLate SDAbsnt SDDistrb SDCheat SDProfnt
    SDVandl SDTheft SDIntim SDFight SDAbuse
    ).

* 16: Teacher problem.
RECODE
    ACBG16A ACBG16B
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG16A ACBG16B
        0 'Not a problem'
        1 'Minor problem'
        2 'Moderate problem'
        3 'Serious problem'.
MISSING VALUES
    ACBG16A ACBG16B
        (-99).
RENAME VARIABLES (
    ACBG16A ACBG16B
    =
    TchLate TchAbsent
    ).

* 17: School readiness.
RECODE
    ACBG17A ACBG17B ACBG17C ACBG17D ACBG17E ACBG17F
    ACBG17G ACBG17H ACBG17I ACBG17J ACBG17K ACBG17L
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG17A ACBG17B ACBG17C ACBG17D ACBG17E ACBG17F
    ACBG17G ACBG17H ACBG17I ACBG17J ACBG17K ACBG17L
        0 'less than 25%'
        1 '25 - 50%'
        2 '51 - 75%'
        3 'More than 75%'.
MISSING VALUES
    ACBG17A ACBG17B ACBG17C ACBG17D ACBG17E ACBG17F
    ACBG17G ACBG17H ACBG17I ACBG17J ACBG17K ACBG17L
        (-99).
RENAME VARIABLES (
    ACBG17A ACBG17B ACBG17C ACBG17D ACBG17E ACBG17F
    ACBG17G ACBG17H ACBG17I ACBG17J ACBG17K ACBG17L
    =
    SRLetter SRWord SRSenten SRWrite SRName SRWrtWo
    SRCount SRNumber SRNumHIg SRWrtNum SRAdditn SRSubtr
    ).

* 18,19: Principal years of experience.
RECODE
    ACBG18 ACBG19
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG18 ACBG19
        (-99).
RENAME VARIABLES (
    ACBG18 ACBG19
    =
    PrcplYear PrYearSc
    ).

* 20: Principal highest level of education.
RECODE
    ACBG20
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG20
        0 'Did not complete <Bachelor’s or equivalent level--ISCED Level 6>'
        1 '<Bachelor’s or equivalent level--ISCED Level 6>'
        2 '<Master’s or equivalent level--ISCED Level 7>'
        3 '<Doctor or equivalent level--ISCED Level 8>'.
MISSING VALUES
    ACBG20
        (-99).
RENAME VARIABLES (
    ACBG20 = PrEdu
    ).

* 21: Principal qualification in educational leadership.
RECODE
    ACBG21A ACBG21B ACBG21C
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG21A ACBG21B ACBG21C
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG21A ACBG21B ACBG21C
        (-99).
RENAME VARIABLES (
    ACBG21A ACBG21B ACBG21C
    =
    PrLdrCer PrLdrMas PrLdrDoc
    ).

**************************
** Compound Variables **
**************************

* Language of school questionnaire.
RECODE
    ITLANG_C
        (99=-99).
MISSING VALUES
    ITLANG_C
        (-99).

* Locale ID of school questionnaire.
RECODE
    LCID_C
        (9999999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    LCID_C
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
    ACDGSBC
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGSBC
        0 'More disadvantaged'
        1 'Neither more affluent nor more disadvantaged'
        2 'More affluent'.
MISSING VALUES
    ACDGSBC
        (-99).
RENAME VARIABLES (
    ACDGSBC = SchSES
    ).

* Total instructional hours per year.
RECODE
    ACDGTIHY
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACDGTIHY
        (-99).
RENAME VARIABLES (
    ACDGTIHY = InstHour
    ).

* Run script.
EXECUTE.

* Remove unwanted variable(s).
DELETE VARIABLES
    IDCNTRY
    IDSCHOOL
    IDPOP
    IDGRADER
    IDGRADE
    SCHWGT
    STOTWGTU
    WGTADJ1
    WGTFAC1
    JKCREP
    JKCZONE
    VERSION
    SCOPE
    idbid
    .

* Update data set.
SAVE OUTFILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\T19_G4_4_School.sav".

***** End script *****
