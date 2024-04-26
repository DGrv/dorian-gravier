echo "SCRIPT from Dori : Dependencies tree RR"

grep -Ev "^\|" Dependencies.txt | grep -Ev "^$" | perl -pe "s|: .*||g" > Ids.txt
grep -Ev "^\|" Dependencies.txt | grep -Ev "^$" | perl -pe "s|.*: ||g" > Variables.txt

cp Dependencies.txt DependenciesBU.txt


nrow=$(cat Ids.txt | wc -l)
j=1
echo "echo Script running" > Change_names.sh
for i in $( eval echo {001..$nrow} )
do 
in=$(sed "${j}q;d" Ids.txt)
out=$(sed "${j}q;d" Variables.txt)
echo "perl -i -pe 's|${in} \[\.\.\.\]|${in} [ ${out} ]|g' Dependencies.txt" >> Change_names.sh
echo "echo ${j} / ${nrow} --- ${in}   to   ${out}" >> Change_names.sh
((j++))
done



cp DependenciesBU.txt Dependencies.txt

