path_to_py="."
work_dir=$(mktemp -d)
full_file="$work_dir/full_guide.xml"
gz_file="$full_file.gz"


locale=$1
output=$2


if [ $# -lt 2 ];
    then
        echo "Please enter locale and output location"
        exit 1
fi 

echo "Downloading EPG Info"
curl -LJ  https://github.com/epgshare01/share01/raw/master/epg_ripper_US_LOCALS2.xml.gz -o $gz_file

echo "Inflating EPG Info"
gunzip -c $gz_file >> $full_file

echo "Refining EPG Info..."
 ./"$path_to_py/guide_slimmer.py" $full_file $locale $output

if [ $? -eq 0 ]; then
    echo "$output sucesssfully written"
else
    echo "Something went wrong"
    rm -r $work_dir
    exit 2
fi

rm -r $work_dir

