# Clense all folders
echo "Cleaning folders..."

# # Powerclean
# ./.power_clean.sh

rm ./S1_Sentence/B1_Block1/R1_Rater1/*.txt
rm ./S1_Sentence/B1_Block1/R2_Rater2/*.txt
rm ./S1_Sentence/B2_Block2/R3_Rater3/*.txt
rm ./S1_Sentence/B2_Block2/R4_Rater4/*.txt

rm ./S2_Theme/B1_Block1/R1_Rater1/*.txt
rm ./S2_Theme/B1_Block1/R2_Rater2/*.txt
rm ./S2_Theme/B2_Block2/R3_Rater3/*.txt
rm ./S2_Theme/B2_Block2/R4_Rater4/*.txt
echo "Folder cleaning completed.
"

# Randomly assign R output files into B1 or B2 folers
echo "Randomising file allocation..."
./.Randomise_S1_Sentence.sh &&
./.Randomise_S2_Theme.sh &&
echo "File allocation completed.
"

# Append "_B1" or "_B2" to file names
echo "Renaming files at block level..."

cp .Rename_B1.sh ./S1_Sentence/B1_Block1 &&
cd ./S1_Sentence/B1_Block1 &&
./.Rename_B1.sh &&
rm .Rename_B1.sh &&
ls $search_path > ../../.file_list_S1_B1.txt
cd ../../

cp .Rename_B2.sh ./S1_Sentence/B2_Block2 &&
cd ./S1_Sentence/B2_Block2 &&
./.Rename_B2.sh &&
rm .Rename_B2.sh &&
ls $search_path > ../../.file_list_S1_B2.txt
cd ../../

cp .Rename_B1.sh ./S2_Theme/B1_Block1 &&
cd ./S2_Theme/B1_Block1 &&
./.Rename_B1.sh &&
rm .Rename_B1.sh &&
ls $search_path > ../../.file_list_S2_B1.txt
cd ../../

cp .Rename_B2.sh ./S2_Theme/B2_Block2 &&
cd ./S2_Theme/B2_Block2 &&
./.Rename_B2.sh &&
rm .Rename_B2.sh &&
ls $search_path > ../../.file_list_S2_B2.txt
cd ../../

echo "Block level renaming completed.
"

# Generate an output log, documenting the file allocation result
echo "Generating log..."
./.log.sh
echo "Log completed.
"

# Distribute files to raters
echo "Distributing files to raters..."
cp ./S1_Sentence/B1_Block1/*.* ./S1_Sentence/B1_Block1/R1_Rater1/
mv ./S1_Sentence/B1_Block1/*.* ./S1_Sentence/B1_Block1/R2_Rater2/
cp ./S1_Sentence/B2_Block2/*.* ./S1_Sentence/B2_Block2/R3_Rater3/
mv ./S1_Sentence/B2_Block2/*.* ./S1_Sentence/B2_Block2/R4_Rater4/

cp ./S2_Theme/B1_Block1/*.* ./S2_Theme/B1_Block1/R1_Rater1/
mv ./S2_Theme/B1_Block1/*.* ./S2_Theme/B1_Block1/R2_Rater2/
cp ./S2_Theme/B2_Block2/*.* ./S2_Theme/B2_Block2/R3_Rater3/
mv ./S2_Theme/B2_Block2/*.* ./S2_Theme/B2_Block2/R4_Rater4/
echo "Rater distribution completed.
"

# Rename files at rater level
echo "Renaming files at rater level..."
cp .Rename_R1.sh ./S1_Sentence/B1_Block1/R1_Rater1 &&
cd ./S1_Sentence/B1_Block1/R1_Rater1 &&
./.Rename_R1.sh &&
rm .Rename_R1.sh &&
cd ../../../

cp .Rename_R2.sh ./S1_Sentence/B1_Block1/R2_Rater2 &&
cd ./S1_Sentence/B1_Block1/R2_Rater2 &&
./.Rename_R2.sh &&
rm .Rename_R2.sh &&
cd ../../../

cp .Rename_R3.sh ./S1_Sentence/B2_Block2/R3_Rater3 &&
cd ./S1_Sentence/B2_Block2/R3_Rater3 &&
./.Rename_R3.sh &&
rm .Rename_R3.sh &&
cd ../../../

cp .Rename_R4.sh ./S1_Sentence/B2_Block2/R4_Rater4 &&
cd ./S1_Sentence/B2_Block2/R4_Rater4 &&
./.Rename_R4.sh &&
rm .Rename_R4.sh &&
cd ../../../



cp .Rename_R1.sh ./S2_Theme/B1_Block1/R1_Rater1 &&
cd ./S2_Theme/B1_Block1/R1_Rater1 &&
./.Rename_R1.sh &&
rm .Rename_R1.sh &&
cd ../../../

cp .Rename_R2.sh ./S2_Theme/B1_Block1/R2_Rater2 &&
cd ./S2_Theme/B1_Block1/R2_Rater2 &&
./.Rename_R2.sh &&
rm .Rename_R2.sh &&
cd ../../../

cp .Rename_R3.sh ./S2_Theme/B2_Block2/R3_Rater3 &&
cd ./S2_Theme/B2_Block2/R3_Rater3 &&
./.Rename_R3.sh &&
rm .Rename_R3.sh &&
cd ../../../

cp .Rename_R4.sh ./S2_Theme/B2_Block2/R4_Rater4 &&
cd ./S2_Theme/B2_Block2/R4_Rater4 &&
./.Rename_R4.sh &&
rm .Rename_R4.sh &&
cd ../../../
echo "Rater level renaming completed."