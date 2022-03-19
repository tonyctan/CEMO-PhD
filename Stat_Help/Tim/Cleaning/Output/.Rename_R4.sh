for i in *.txt; do
    mv "$i" "${i%.*}_R4.txt";
done
