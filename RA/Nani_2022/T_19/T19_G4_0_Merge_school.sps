* Script created using the IEA IDB Analyzer (Version 5.0.12).
* Created on 03/08/2022 at 13:51.
* Press Ctrl+A followed by Ctrl+R to submit this merge. 

include file = "C:\Users\Tony\AppData\Roaming\IEA\IDBAnalyzerV5\bin\Data\Templates\SPSS_Macros\IDBAnalyzer.ieasps".
include file = "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\IDBAnalyzerCountries.ieasps".

mcrComb 
	 indir="C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\3_International_database\1_SPSS_data"/
	 infile=ACGDNKM7 ACGFINM7 ACGNORM7 ACGSWEM7/
	 outdir="C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19"/
	 outfile=tmpACG/
	 keepVar=
       IDCNTRY 
       IDSCHOOL 
       ACBG03A 
       ACBG03B 
       ACBG04 
       ACBG05A 
       ACBG05B 
       ACBG06A 
       ACBG06B 
       ACBG06C 
       ACBG07 
       ACBG08A 
       ACBG08B 
       ACBG09 
       ACBG10A 
       ACBG10B 
       ACBG11 
       ACBG12 
       ACBG13AA 
       ACBG13AB 
       ACBG13AC 
       ACBG13AD 
       ACBG13AE 
       ACBG13AF 
       ACBG13AG 
       ACBG13AH 
       ACBG13AI 
       ACBG13BA 
       ACBG13BB 
       ACBG13BC 
       ACBG13BD 
       ACBG13BE 
       ACBG13CA 
       ACBG13CB 
       ACBG13CC 
       ACBG13CD 
       ACBG14A 
       ACBG14B 
       ACBG14C 
       ACBG14D 
       ACBG14E 
       ACBG14F 
       ACBG14G 
       ACBG14H 
       ACBG14I 
       ACBG14J 
       ACBG14K 
       ACBG15A 
       ACBG15B 
       ACBG15C 
       ACBG15D 
       ACBG15E 
       ACBG15F 
       ACBG15G 
       ACBG15H 
       ACBG15I 
       ACBG15J 
       ACBG16A 
       ACBG16B 
       ACBG17A 
       ACBG17B 
       ACBG17C 
       ACBG17D 
       ACBG17E 
       ACBG17F 
       ACBG17G 
       ACBG17H 
       ACBG17I 
       ACBG17J 
       ACBG17K 
       ACBG17L 
       ACBG18 
       ACBG19 
       ACBG20 
       ACBG21A 
       ACBG21B 
       ACBG21C 
       IDPOP 
       IDGRADER 
       IDGRADE 
       ITLANG_C 
       LCID_C 
       SCHWGT 
       STOTWGTU 
       WGTADJ1 
       WGTFAC1 
       JKCREP 
       JKCZONE 
       ACBGMRS 
       ACDGMRS 
       ACBGSRS 
       ACDGSRS 
       ACBGEAS 
       ACDGEAS 
       ACBGDAS 
       ACDGDAS 
       ACBGLNS 
       ACDGLNS 
       ACDGSBC 
       ACDGTIHY 
       VERSION 
       SCOPE/
	 idbID='MM7'.
EXECUTE.


ctylabls.
SAVE OUTFILE='C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_19\T19_G4_0_Merge_school.sav'.
EXECUTE.
NEW FILE.

