* Encoding: windows-1252.
* Script created using the IEA IDB Analyzer (Version 5.0.12).
* Created on 13/07/2022 at 23:43.
* Press Ctrl+A followed by Ctrl+R to submit this merge. 

include file = "C:\Users\Tony\AppData\Roaming\IEA\IDBAnalyzerV5\bin\Data\Templates\SPSS_Macros\IDBAnalyzer.ieasps".
include file = "C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\IDBAnalyzerCountries.ieasps".

mcrComb 
	 indir="C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\3_International_database\1_SPSS_data"/
	 infile=ASGDNKM6 ASGFINM6 ASGNO4M6 ASGNORM6 ASGSWEM6/
	 outdir="C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15"/
	 outfile=tmpASG/
	 keepVar=
       IDCNTRY 
       IDBOOK 
       IDSCHOOL 
       IDCLASS 
       IDSTUD 
       IDGRADE 
       ITSEX 
       ITADMINI 
       ITLANG 
       ASBG01 
       ASBG03 
       ASBG04 
       ASBG05A 
       ASBG05B 
       ASBG05C 
       ASBG05D 
       ASBG05E 
       ASBG05F 
       ASBG05G 
       ASBG05H 
       ASBG05I 
       ASBG05J 
       ASBG05K 
       ASBG06A 
       ASBG06B 
       ASBG07 
       ASBG08 
       ASBG09 
       ASBG10A 
       ASBG10B 
       ASBG10C 
       ASBG11A 
       ASBG11B 
       ASBG11C 
       ASBG11D 
       ASBG11E 
       ASBG11F 
       ASBG11G 
       ASBG12A 
       ASBG12B 
       ASBG12C 
       ASBG12D 
       ASBG12E 
       ASBG12F 
       ASBG12G 
       ASBG12H 
       ASBM01A 
       ASBM01B 
       ASBM01C 
       ASBM01D 
       ASBM01E 
       ASBM01F 
       ASBM01G 
       ASBM01H 
       ASBM01I 
       ASBM02A 
       ASBM02B 
       ASBM02C 
       ASBM02D 
       ASBM02E 
       ASBM02F 
       ASBM02G 
       ASBM02H 
       ASBM02I 
       ASBM02J 
       ASBM03A 
       ASBM03B 
       ASBM03C 
       ASBM03D 
       ASBM03E 
       ASBM03F 
       ASBM03G 
       ASBM03H 
       ASBM03I 
       ASBS04A 
       ASBS04B 
       ASBS04C 
       ASBS04D 
       ASBS04E 
       ASBS04F 
       ASBS04G 
       ASBS04H 
       ASBS04I 
       ASBS05A 
       ASBS05B 
       ASBS05C 
       ASBS05D 
       ASBS05E 
       ASBS05F 
       ASBS05G 
       ASBS05H 
       ASBS05I 
       ASBS05J 
       ASBS06A 
       ASBS06B 
       ASBS06C 
       ASBS06D 
       ASBS06E 
       ASBS06F 
       ASBS06G 
       ITACCOMM1 
       IDPOP 
       IDGRADER 
       ASDAGE 
       TOTWGT 
       HOUWGT 
       SENWGT 
       WGTADJ1 
       WGTADJ2 
       WGTADJ3 
       WGTFAC1 
       WGTFAC2 
       WGTFAC3 
       JKZONE 
       JKREP 
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
       ASBGSSB 
       ASDGSSB 
       ASBGSB 
       ASDGSB 
       ASBGSLM 
       ASDGSLM 
       ASBGEML 
       ASDGEML 
       ASBGSCM 
       ASDGSCM 
       ASBGSLS 
       ASDGSLS 
       ASBGESL 
       ASDGESL 
       ASBGSCS 
       ASDGSCS 
       ASBGHRL 
       ASDGHRL 
       ASDG05S 
       ASDMLOWP 
       ASDSLOWP 
       VERSION/
	 idbID='MM6'.
EXECUTE.


ctylabls.
SAVE OUTFILE='C:\Users\Tony\Dropbox (UiO)\Nani\2022\T_15\T15_G4_0_Merge_student.sav'.
EXECUTE.
NEW FILE.

