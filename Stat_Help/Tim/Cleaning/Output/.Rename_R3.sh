for i in *.txt; do
    mv "$i" "${i%.*}_R3.txt";
done
