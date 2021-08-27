#============================================
# (C) Copyright All rights reserved. Artiza networks Inc.
#DESCRIPTION: script to read verilog description and do some translation
#AUTHOR:Zeng
#HISTORY
#REV        EDITOR     DATE         DESCITPTION
#001        Zeng       21.08.16     Initial
#============================================
#!/usr/local/bin/perl
use Getopt::Long ;

##################
#HANDLING ARGUMENT
##################
my ${file_in} = "NO_FILE";
my @text = "NO_TEXT" ;
my ${help} = 0;
my ${en_text_pipe} = 0;
my ${vh2v} = "NOT_ACTIVE" ;
my ${opt_desc} = "NO_DESC" ;
my ${opt_clk} = "CLK" ;
my ${opt_rst} = "RST" ;
my ${opt_active} = 0 ;
my ${opt_procname} = "PROCESS_NAME" ;
GetOptions (
    'f=s'     => \${file_in} ,
    't=s'     => \$text ,
    'tp!'     => \$en_text_pipe ,
    'd|desc=s'  => \${opt_desc} ,
    'clk=s'  => \${opt_clk} ,
    'rst=s'  => \${opt_rst} ,
    'activeh!'  => \${opt_active} ,
    'procname' => \${opt_procname} ,
    'help|h!' => \${help} ,
    'v!'      => \${verbose} 
);

if (${verbose} == 1) {
    my ${verbose_info} = <<EOS ;
    input file : ${file_in} 
EOS
    print ${verbose_info} ;
}

if (${help} == 1) {
    my ${hel_info} = <<EOS ;
    USAGE: perl <option> -f XXX.v
    OPTION:
        -h : display help info
EOS
    print ${hel_info} ;
    exit(0) ;
}

if (${file_in} ne "NO_FILE") {
    open(FILE_IN1, "<", ${file_in}) or die ("can't open file_in ${file_in} ($!)");
    my ${lnArr1} = <FILE_IN1> ;
    close(FILE_IN1) or die ("can't close file_in ${file_in} ($!)");
}
#=====================
#=== MAIN FUNCTION ===
#=====================
if (${opt_desc} eq "process") {
    print_process((${opt_clk},${opt_rst},${opt_active},${opt_procname})) ;
}

#==============================
#=== SUB-ROUTINE DEFINITION ===
#==============================
sub get_text_from_pipe {
    my @raw_text ;
    my @organized_text ;
    @raw_text = "@raw_text<$_>\n" while <> ;
    #@raw_text = grep {$_ !~ />/} @raw_text;
    foreach ${line} (@raw_text) {
        ${line} =~ s/<//g ;
        ${line} =~ s/>\n//g ;
        ${line} =~ s/\t/    /g ;
        #print "${line}" ;
        @organized_text = split(/\n/,${line}) ;
    }
    return @organized_text ;
}

sub print_process {
    my ${clk} = $_[0] ;
    my ${reset} = $_[1] ;
    my ${active} = $_[2] ;
    my ${process} = $_[3] ;
    my ${description} = <<EOS ;
    ${process}:process(${reset},${clk})
    begin
        if(${reset}='${active}') then
            SIG_NAME <= '0' ;
        elsif(${clk}'event and ${clk}='1') then
            if(CONDITION)then
                SIG_NAME <= ASSIGN_NAME ;
            end if ;
        end if ;
    end process;
EOS
    print ${description} ;

}
