for i in *.txt; do
    mv "$i" "${i%.*}_R2.txt";
done
