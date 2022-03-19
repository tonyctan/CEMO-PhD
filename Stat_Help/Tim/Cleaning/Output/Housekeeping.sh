# Clense all folders
rm ./S1_Sentence/B1_Block1/*.txt
rm ./S1_Sentence/B2_Block2/*.txt
rm ./S2_Theme/B1_Block1/*.txt
rm ./S2_Theme/B2_Block2/*.txt

./.Randomise_S1_Sentence.sh &&
./.Randomise_S2_Theme.sh &&
cp .Rename_B1.sh ./S1_Sentence/B1_Block1 &&
cd ./S1_Sentence/B1_Block1 &&
./.Rename_B1.sh &&
rm .Rename_B1.sh &&
cd ../../
cp .Rename_B2.sh ./S1_Sentence/B2_Block2 &&
cd ./S1_Sentence/B2_Block2 &&
./.Rename_B2.sh &&
rm .Rename_B2.sh &&
cd ../../
cp .Rename_B1.sh ./S2_Theme/B1_Block1 &&
cd ./S2_Theme/B1_Block1 &&
./.Rename_B1.sh &&
rm .Rename_B1.sh &&
cd ../../
cp .Rename_B2.sh ./S2_Theme/B2_Block2 &&
cd ./S2_Theme/B2_Block2 &&
./.Rename_B2.sh &&
rm .Rename_B2.sh &&
cd ../../
