#! user/bin/perl -w

my $ARGC = @ARGV;
my @ac_list;
my $list_count = 0;
my $count = 0;
my $cont = 0;
my $comp;
my $i;

open(INPUT1, '<', $ARGV[0]);
open($output_file, '>', "accession_number_list.txt");

while($temp = <INPUT1>)
    {
    if($temp =~ />sp.(\w*).*\n/)
        {
        $ac_list[$list_count] = $1;
        $list_count++;
        }
    }
for($i = 0; $i < $list_count; $i++)
    {
    print $output_file $ac_list[$i], "\n";
    }

close(INPUT1);
