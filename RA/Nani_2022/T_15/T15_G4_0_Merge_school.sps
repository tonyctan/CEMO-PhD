* Encoding: windows-1252.
* Script created using the IEA IDB Analyzer (Version 5.0.12).
* Created on 13/07/2022 at 23:40.
* Press Ctrl+A followed by Ctrl+R to submit this merge. 

include file = "C:\Users\Tony\AppData\Roaming\IEA\IDBAnalyzerV5\bin\Data\Templates\SPSS_Macros\IDBAnalyzer.ieasps".
include file = "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\IDBAnalyzerCountries.ieasps".

mcrComb 
	 indir="C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\3_International_database\1_SPSS_data"/
	 infile=ACGDNKM6 ACGFINM6 ACGNO4M6 ACGNORM6 ACGSWEM6/
	 outdir="C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15"/
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
       ACBG07A 
       ACBG07B 
       ACBG07C 
       ACBG07D 
       ACBG08A 
       ACBG08B 
       ACBG08C 
       ACBG09A 
       ACBG09B 
       ACBG10A 
       ACBG10B 
       ACBG11 
       ACBG12A 
       ACBG12B 
       ACBG13 
       ACBG13AA 
       ACBG13AB 
       ACBG13BA 
       ACBG13BB 
       ACBG14AA 
       ACBG14AB 
       ACBG14AC 
       ACBG14AD 
       ACBG14AE 
       ACBG14AF 
       ACBG14AG 
       ACBG14AH 
       ACBG14AI 
       ACBG14BA 
       ACBG14BB 
       ACBG14BC 
       ACBG14BD 
       ACBG14BE 
       ACBG14CA 
       ACBG14CB 
       ACBG14CC 
       ACBG14CD 
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
       ACBG15K 
       ACBG15L 
       ACBG15M 
       ACBG16A 
       ACBG16B 
       ACBG16C 
       ACBG16D 
       ACBG16E 
       ACBG16F 
       ACBG16G 
       ACBG16H 
       ACBG16I 
       ACBG16J 
       ACBG17A 
       ACBG17B 
       ACBG18A 
       ACBG18B 
       ACBG18C 
       ACBG18D 
       ACBG18E 
       ACBG18F 
       ACBG18G 
       ACBG18H 
       ACBG18I 
       ACBG18J 
       ACBG18K 
       ACBG19 
       ACBG20 
       ACBG21 
       ACBG22A 
       ACBG22B 
       IDPOP 
       IDGRADE 
       IDGRADER 
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
       ACDG03 
       ACDG08HY 
       VERSION/
	 idbID='MM6'.
EXECUTE.


ctylabls.
SAVE OUTFILE='C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\T15_G4_0_Merge_school.sav'.
EXECUTE.
NEW FILE.

