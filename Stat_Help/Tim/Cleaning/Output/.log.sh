# Remove existing log.txt file
rm log.txt

# Print date and time
echo "Log generated on $(date)


File list in S1_Sentence/B1_Block1:" >> log.txt
# Insert S1_B1 list
cat .file_list_S1_B1.txt >> log.txt
echo "

File list in S1_Sentence/B2_Block2:" >> log.txt
# Insert S1_B2 list
cat .file_list_S1_B2.txt >> log.txt
echo "

File list in S2_Theme/B1_Block1:" >> log.txt
# Insert S2_B1 list
cat .file_list_S2_B1.txt >> log.txt
echo "

File list in S2_Theme/B2_Block2:" >> log.txt
# Insert S2_B2 list
cat .file_list_S2_B2.txt >> log.txt
echo "
End of log." >> log.txt

rm .file_list_S1_B1.txt
rm .file_list_S1_B2.txt
rm .file_list_S2_B1.txt
rm .file_list_S2_B2.txt
