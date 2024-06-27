#! user/bin/perl -w

my $ARGC = @ARGV;                                        
my $seq_flag = 0;
my $seq_length;
my $temp = "";
my @prot_seq;
my $i;
my $j;
my $transmem_start;
my $transmem_end;
my $transmem_counter = 0;
my $transmem_flag = 0;
my $offset = 5;
my $prot_id;

if($ARGC == 1)                                                                          #Open file from command line, if given
    {
    open(INPUT, '<', $ARGV[0]) || die "Couldn't open $ARGV[1]\n";
    }
else                                                                                    #If no input file was given on program run, ask for input
    {
    print"Give the name of input file\n";
    $input_file = <STDIN>;
    chomp $input_file;
    open(INPUT, '<', $input_file) || die "Coundn't open $input_file\n";
    }

open($output_file, '>', "transmembrane_domains_out.txt");

while($temp = <INPUT>)                                                                  #Load sequence to variable
    {
    if($transmem_flag == 0 && $temp =~ /^FT   TRANSMEM        (\d*)..(\d*)/)
        {
        $transmem_start = $1;
        $transmem_end = $2;
        $transmem_flag = 1;
        }
    elsif($temp =~ /AC   (\w*);/)
        {
        $prot_id = $1;
        chomp($prot_id);
        }
    elsif($temp =~ /^\/\/*/)
        {
        $prot_seq =~ s/[^\w]//g;
        my @seq_array = split("",$prot_seq);
        print $output_file "> ", $prot_id, "\n";
        for($i = $transmem_start - $offset-1; $i < $transmem_end + $offset+1; $i++)
            {
            print $output_file $seq_array[$i];
            }
        print $output_file "\n";
        $prot_seq = '';
        $seq_flag = 0;
        $transmem_flag = 0;
        }
    elsif($seq_flag == 1)
        {
        $prot_seq .= $temp;
        }
    elsif($temp =~ /SQ   SEQUENCE*/)
        {
        $seq_flag = 1;
        }
    }

close($output_file);
