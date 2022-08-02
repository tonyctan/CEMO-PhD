* Encoding: UTF-8.

**** ADMIN INFO *****
* Date: 29 July 2021
* Author: Tony Tan
* Email: tctan@uio.no
* Position: PhD Candidate
* Organisation: CEMO, UV, UiO
* Script purpose: Data cleaning--School

***** DATA ATTRIBUTES *****
* ILSA: TIMSS
* Cycle: 2011
* Questionnaire: School
* Grade: Grade 4
* Subject: Math and Science

***** Begin script *****

* Import data.
GET FILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_11\T11_G4_0_Merge_school.sav".

**************************
** Admin variables **
**************************
*1: Country ID - Numeric ISO Code.


*2: School ID.

**************************
** School variables **
**************************

* 01: Enrolment total.
RECODE
    ACBG01
        (99999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG01
        (-99).
RENAME VARIABLES (
    ACBG01 = SchEnrTo
    ).

* 02: Enrolment 4th Grade.
RECODE
    ACBG02
        (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG02
        (-99).
RENAME VARIABLES (
    ACBG02 = SchEnr4G
    ).

* 03A: Percentage of disadvantaged students attending the school (REVERSE CODING).
RECODE
    ACBG03A
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG03A
        0 '0 to 10%'
        1 '11 to 25%'
        2 '26 to 50%'
        3 'More than 50%'.
MISSING VALUES
    ACBG03A
        (-99).
RENAME VARIABLES (
    ACBG03A
    =
    SchDisad
    ).

* 03A: Percentage of affluent students attending the school.
RECODE
    ACBG03B
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG03B
        0 '0 to 10%'
        1 '11 to 25%'
        2 '26 to 50%'
        3 'More than 50%'.
MISSING VALUES
    ACBG03B
        (-99).
RENAME VARIABLES (
    ACBG03B
    =
    SchEco
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
        (1=5) (2=4) (3=3) (4=2) (5=1) (6=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG05A
        0 '3,000 people or fewer'
        1 '3,001 to 15,000 people'
        2 '15,001 to 50,000 people'
        3 '50,001 to 100,000 people'
        4 '100,001 to 500,000 people'
        5 'More than 500,000 people'.
MISSING VALUES
    ACBG05A
        (-99).
RENAME VARIABLES (
    ACBG05A = SchPop
    ).

* 05B: School location.
RECODE
    ACBG05B
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG05B
        0 'Remote rural'
        1 'Small town or village'
        2 'Medium size city or large town'
        3 'Suburban--On fridge or outskirts of urban area'
        4 'Urban--Densely populated'.
MISSING VALUES
    ACBG05B
        (-99).
RENAME VARIABLES (
    ACBG05B = SchArea
    ).

* 05C: School area average income.
RECODE
    ACBG05C
        (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG05C
        0 'Low'
        1 'Medium'
        2 'High'.
MISSING VALUES
    ACBG05C
        (-99).
RENAME VARIABLES (
    ACBG05C = SchIncom
    ).

* 06A: Instructional time.
RECODE
    ACBG06A
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG06A
        (-99).
RENAME VARIABLES (
    ACBG06A = SchDays
    ).

* 06B: Instructional time.
RECODE
    ACBG06BA ACBG06BB
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG06BA ACBG06BB
        (-99).
RENAME VARIABLES (
        ACBG06BA ACBG06BB
        =
        SchHour SchMinu
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
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBG07
        (-99).
RENAME VARIABLES (
    ACBG07 = NumComp
    ).

* 08: Science laboratory.
RECODE
    ACBG08
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG08
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG08
        (-99).
RENAME VARIABLES (
    ACBG08 = SciLab
    ).

* 09: School library.
RECODE
    ACBG09
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG09
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG09
        (-99).
RENAME VARIABLES (
    ACBG09 = Library
    ).

* 09A: School library: Books.
RECODE
    ACBG09A
        (1=0) (2=1) (3=2) (4=3) (5=4) (6=5)
        (96=-99) (99=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG09A
        0 '250 or fewer'
        1 '251--500'
        2 '501--2,000'
        3 '2,001--5,000'
        4 '5,001--10,000'
        5 'More than 10,000'.
MISSING VALUES
    ACBG09A
        (-99).
RENAME VARIABLES (
    ACBG09A = ManyBook
    ).

* 09B: School library: Magazines.
RECODE
    ACBG09B
        (1=0) (2=1) (3=2) (4=3) (5=4)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG09B
        0 '0'
        1 '1--5'
        2 '6--10'
        3 '11--30'
        4 '31 or more'.
MISSING VALUES
    ACBG09B
        (-99).
RENAME VARIABLES (
    ACBG09B = ManyMaga
    ).

* 10: Shortage affecting school’s capacity to provide general instruction.
RECODE
    ACBG10AA ACBG10AB ACBG10AC ACBG10AD ACBG10AE ACBG10AF ACBG10AG
    ACBG10BA ACBG10BB ACBG10BC ACBG10BD
    ACBG10CA ACBG10CB ACBG10CC ACBG10CD ACBG10CE
    ACBG10DA ACBG10DB ACBG10DC ACBG10DD ACBG10DE
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG10AA ACBG10AB ACBG10AC ACBG10AD ACBG10AE ACBG10AF ACBG10AG
    ACBG10BA ACBG10BB ACBG10BC ACBG10BD
    ACBG10CA ACBG10CB ACBG10CC ACBG10CD ACBG10CE
    ACBG10DA ACBG10DB ACBG10DC ACBG10DD ACBG10DE
        0 'A lot'
        1 'Some'
        2 'A little'
        3 'Not at all'.
MISSING VALUES
    ACBG10AA ACBG10AB ACBG10AC ACBG10AD ACBG10AE ACBG10AF ACBG10AG
    ACBG10BA ACBG10BB ACBG10BC ACBG10BD
    ACBG10CA ACBG10CB ACBG10CC ACBG10CD ACBG10CE
    ACBG10DA ACBG10DB ACBG10DC ACBG10DD ACBG10DE
        (-99).
RENAME VARIABLES (
    ACBG10AA ACBG10AB ACBG10AC ACBG10AD ACBG10AE ACBG10AF ACBG10AG
    ACBG10BA ACBG10BB ACBG10BC ACBG10BD
    ACBG10CA ACBG10CB ACBG10CC ACBG10CD ACBG10CE
    ACBG10DA ACBG10DB ACBG10DC ACBG10DD ACBG10DE
    =
    SrtMatrl SrtSuply SrtBuild SrtHeat SrtSpace SrtTech SrtComp
    SrtRtch SrtRComp SrtRLib SrtRAud
    SrtMTch SrtMComp SrtMLib SrtMAud SrtMCal
    SrtSTch SrtSComp SrtSLib SrtSAud SrtSEqu
    ).

* 11: Involving parents in school.
RECODE
    ACBG11AA ACBG11AB ACBG11AC ACBG11AD
    ACBG11BA ACBG11BB
    ACBG11CA ACBG11CB ACBG11CC ACBG11CD ACBG11CE ACBG11CF ACBG11CG
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG11AA ACBG11AB ACBG11AC ACBG11AD
    ACBG11BA ACBG11BB
    ACBG11CA ACBG11CB ACBG11CC ACBG11CD ACBG11CE ACBG11CF ACBG11CG
        0 'Never'
        1 'Once a year'
        2 '2--3 times a year'
        3 'More than 3 times a year'.
MISSING VALUES
    ACBG11AA ACBG11AB ACBG11AC ACBG11AD
    ACBG11BA ACBG11BB
    ACBG11CA ACBG11CB ACBG11CC ACBG11CD ACBG11CE ACBG11CF ACBG11CG
        (-99).
RENAME VARIABLES (
    ACBG11AA ACBG11AB ACBG11AC ACBG11AD
    ACBG11BA ACBG11BB
    ACBG11CA ACBG11CB ACBG11CC ACBG11CD ACBG11CE ACBG11CF ACBG11CG
    =
    SParProg SParBeha SParConc SParSupp
    SParVolu SParComm
    SParAcad SParAcco SParGoal SParRule SParWish SParMate SParWork
    ).

* 12: School emphasis on academic success.
RECODE
    ACBG12A ACBG12B ACBG12C ACBG12D ACBG12E ACBG12F ACBG12G ACBG12H
        (1=4) (2=3) (3=2) (4=1) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG12A ACBG12B ACBG12C ACBG12D ACBG12E ACBG12F ACBG12G ACBG12H
        0 'Very low'
        1 'Low'
        2 'Medium'
        3 'High'
        4 'Very high'.
MISSING VALUES
    ACBG12A ACBG12B ACBG12C ACBG12D ACBG12E ACBG12F ACBG12G ACBG12H
        (-99).
RENAME VARIABLES (
    ACBG12A ACBG12B ACBG12C ACBG12D ACBG12E ACBG12F ACBG12G ACBG12H
    =
    STchJSat STchUndC STchSucC STchExpC SParSuppC SParInvC SStdRespC SStdWellC
    ).

* 13A: School discipline and safety.
RECODE
    ACBG13AA ACBG13AB ACBG13AC ACBG13AD ACBG13AE
    ACBG13AF ACBG13AG ACBG13AH ACBG13AI ACBG13AJ
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG13AA ACBG13AB ACBG13AC ACBG13AD ACBG13AE
    ACBG13AF ACBG13AG ACBG13AH ACBG13AI ACBG13AJ
        0 'Not a problem'
        1 'Minor problem'
        2 'Moderate problem'
        3 'Serious problem'.
MISSING VALUES
    ACBG13AA ACBG13AB ACBG13AC ACBG13AD ACBG13AE
    ACBG13AF ACBG13AG ACBG13AH ACBG13AI ACBG13AJ
        (-99).
RENAME VARIABLES (
    ACBG13AA ACBG13AB ACBG13AC ACBG13AD ACBG13AE
    ACBG13AF ACBG13AG ACBG13AH ACBG13AI ACBG13AJ
    =
    SDLate SDAbsnt SDDistrb SDCheat SDProfnt
    SDVandl SDTheft SDIntim SDFight SDAbuse
    ).

* 13B: Teacher problem.
RECODE
    ACBG13BA ACBG13BB
        (1=3) (2=2) (3=1) (4=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG13BA ACBG13BB
        0 'Not a problem'
        1 'Minor problem'
        2 'Moderate problem'
        3 'Serious problem'.
MISSING VALUES
    ACBG13BA ACBG13BB
        (-99).
RENAME VARIABLES (
    ACBG13BA ACBG13BB
    =
    TchLate TchAbsent
    ).

* 14: Teacher evaluation.
RECODE
    ACBG14A ACBG14B ACBG14C ACBG14D
        (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG14A ACBG14B ACBG14C ACBG14D
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG14A ACBG14B ACBG14C ACBG14D
        (-99).
RENAME VARIABLES (
    ACBG14A ACBG14B ACBG14C ACBG14D
    =
    TEvObSta TEvObIns TEvStAch TEvPeer
    ).

* 15: Pricipal activites.
RECODE
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
    ACBG15K ACBG15L ACBG15M
        (1=0) (2=1) (3=2)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG15A ACBG15B ACBG15C ACBG15D ACBG15E
    ACBG15F ACBG15G ACBG15H ACBG15I ACBG15J
    ACBG15K ACBG15L ACBG15M
        0 'No time'
        1 'Some time'
        2 'A lot of time'.
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
    PrAcGoal PrAcCurr PrAcMonT PrAcMonS PrAcOrde
    PrAcRule PrAcBeha PrAcTrus PrAcDisc PrAcAdvi
    PrAcVisi PrAcProj PrAcPD
    ).

* 16: School readiness.
RECODE
    ACBG16A ACBG16B ACBG16C ACBG16D ACBG16E ACBG16F ACBG16G ACBG16H
        (1=0) (2=1) (3=2) (4=3)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG16A ACBG16B ACBG16C ACBG16D ACBG16E ACBG16F ACBG16G ACBG16H
        0 'Less than 25%'
        1 '25 - 50%'
        2 '51 - 75%'
        3 'More than 75%'.
MISSING VALUES
    ACBG16A ACBG16B ACBG16C ACBG16D ACBG16E ACBG16F ACBG16G ACBG16H
        (-99).
RENAME VARIABLES (
    ACBG16A ACBG16B ACBG16C ACBG16D ACBG16E ACBG16F ACBG16G ACBG16H
    =
    SRLetter SRWord SRSenten SRWrite SRWrtWo SRCount SRNumber SRWrtNum
    ).

* 17: Reading skills.
RECODE
    ACBG17A ACBG17B ACBG17C ACBG17D ACBG17E
    ACBG17F ACBG17G ACBG17H ACBG17I ACBG17J
    ACBG17K ACBG17L ACBG17M ACBG17N
        (1=1) (2=2) (3=3) (4=4) (5=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG17A ACBG17B ACBG17C ACBG17D ACBG17E
    ACBG17F ACBG17G ACBG17H ACBG17I ACBG17J
    ACBG17K ACBG17L ACBG17M ACBG17N
        0 'Not in these grades'
        1 '<First grade> or earlier'
        2 '<Second grade>'
        3 '<Third grade>'
        4  '<Fourth grade>'.
MISSING VALUES
    ACBG17A ACBG17B ACBG17C ACBG17D ACBG17E
    ACBG17F ACBG17G ACBG17H ACBG17I ACBG17J
    ACBG17K ACBG17L ACBG17M ACBG17N
        (-99).
RENAME VARIABLES (
    ACBG17A ACBG17B ACBG17C ACBG17D ACBG17E
    ACBG17F ACBG17G ACBG17H ACBG17I ACBG17J
    ACBG17K ACBG17L ACBG17M ACBG17N
    =
    RdAlphab RdPhonem RdWords RdSenten RdText
    RdLocate RdIdea RdUnders RdPerson RdCompar
    RdPredic RdGenera RdStyle RdPerspe
    ).

* 18: school's emphasis.
RECODE
    ACBG18A ACBG18B ACBG18C
       (1=2) (2=1) (3=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG18A ACBG18B ACBG18C
        0 'Less emphasis'
        1 'Some emphasis'
        2 'More emphasis'.
MISSING VALUES
    ACBG18A ACBG18B ACBG18C
        (-99).
RENAME VARIABLES (
    ACBG18A ACBG18B ACBG18C
    =
    EmphRead EmphWrit EmphSpea
    ).

* 19: Provision for non-native speakers.
RECODE
    ACBG19
       (1=1) (2=0)
        (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACBG19
        0 'No'
        1 'Yes'.
MISSING VALUES
    ACBG19
        (-99).
RENAME VARIABLES (
    ACBG19 = NonNativ
    ).

**************************
** Compound Variables **
**************************

* System ID school file.

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

* Stratification.
RECODE
    IDSTRATE IDSTRATI
        (999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    IDSTRATE IDSTRATI
        (-99).

* Weights.
RECODE
    SCHWGT STOTWGTU WGTADJ1 WGTFAC1
        (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    SCHWGT STOTWGTU WGTADJ1 WGTFAC1
        (-99).

* Replicate code.
RECODE
    JKCREP
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKCREP
        (-99).

* Zone code.
RECODE
    JKCZONE
        (99=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    JKCZONE
        (-99).

* TIMSS construct: Instruction affected by science resource shortage.
RECODE
    ACBGSRS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGSRS
        0 'Affected a lot'
        1 'Somewhat affected'
        2  'Not affected'.
MISSING VALUES
    ACDGSRS
        (-99).
RENAME VARIABLES (
    ACDGSRS = IDXSRes
    ).

* TIMSS construct: Instruction affected by math resource shortage.
RECODE
    ACBGMRS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGMRS
        0 'Affected a lot'
        1 'Somewhat affected'
        2  'Not affected'.
MISSING VALUES
    ACDGMRS
        (-99).
RENAME VARIABLES (
    ACDGMRS = IDXMRes
    ).

* TIMSS construct: SEAS principal.
RECODE
    ACBGEAS
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
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
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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
        (999996=-99) (999999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACBGDAS
        (-99).
RENAME VARIABLES (
    ACBGDAS = SCLdiscp
    ).

* TIMSS construct: School discipline--principal.
RECODE
    ACDGDAS
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGDAS
        0 'Moderate problems'
        1 'Minor problems'
        2 'Hardly any problems'.
MISSING VALUES
    ACDGDAS
        (-99).
RENAME VARIABLES (
    ACDGDAS = IDXdiscp
    ).

* TIMSS construct: School composition.
RECODE
    ACDG03
        (1=2) (2=1) (3=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
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

* TIMSS construct: Students enter with early numeracy skills.
RECODE
    ACDGENS
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGENS
        0 'Less than 25% enter with skills'
        1 '25--50% enter with skills'
        2 '51--75% enter with skills'
        3 'More than 75% enter with skills'.
MISSING VALUES
    ACDGENS
        (-99).
RENAME VARIABLES (
    ACDGENS = IDXReady
    ).

* TIMSS construct: School library books.
RECODE
    ACDG09
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDG09
        0 'No school library'
        1 'School library with 500 books or less'
        2 'School library with 501--5,000 books'
        3 'School library with more than 5,000 books'.
MISSING VALUES
    ACDG09
        (-99).
RENAME VARIABLES (
    ACDG09 = IDXLibra
    ).

* TIMSS construct: School computers.
RECODE
    ACDGCMP
        (1=3) (2=2) (3=1) (4=0)
        (6=-99) (9=-99) (SYSMIS=-99) (MISSING=-99).
VALUE LABELS
    ACDGCMP
        0 'No computers available'
        1 '1 computer for 6 or more students'
        2 '1 computer for 3--5 students'
        3 '1 computer for 1--2 students'.
MISSING VALUES
    ACDGCMP
        (-99).
RENAME VARIABLES (
    ACDGCMP = IDXCompu
    ).

* Total instructional hours per year.
RECODE
    ACDG06HY
        (9996=-99) (9999=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACDG06HY
        (-99).
RENAME VARIABLES (
    ACDG06HY = IDXHour
    ).

* Days per week for instruction.
RECODE
    ACDG06
        (9=-99) (SYSMIS=-99) (MISSING=-99).
MISSING VALUES
    ACDG06
        (-99).
RENAME VARIABLES (
    ACDG06 = IDXDays
    ).

* Run script.
EXECUTE.

* Remove unwanted variable(s).
DELETE VARIABLES
    DPCDATE
    idbid
    .

* Update data set.
SAVE OUTFILE =
    "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_11\T11_G4_4_School.sav".

***** End script *****
