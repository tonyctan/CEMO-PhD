for i in *.txt; do
    mv "$i" "${i%.*}_R1.txt";
done
