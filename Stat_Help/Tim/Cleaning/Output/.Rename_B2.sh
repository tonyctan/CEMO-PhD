for i in *.txt; do
    mv "$i" "${i%.*}_B2.txt";
done
