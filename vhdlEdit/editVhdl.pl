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
my ${opt_sigtype} = "signal" ;
my ${opt_signame} = "SIG_NAME" ;
my ${opt_bitwidth} = 0 ;
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
    'signame=s' => \${opt_signame}  ,
    'sigtype=s' => \${opt_sigtype}  ,
    'bitwidth=i' => \${opt_bitwidth} ,
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
elsif (${opt_desc} eq "ila") {
    inssert_ila() ;
}
elsif (${opt_desc} eq "if") {
    print_if() ;
}
elsif (${opt_desc} eq "entity") {
    print_entity() ;
}
elsif (${opt_desc} eq "logic") {
    print_logic((${opt_sigtype},${opt_signame})) ;
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

sub conv_enity2component{
    my ${line} = $_[0] ;
    ${line} =~ s/^\s*entity\s+?(\w*)\s+?is/    component $_[0]/ ;
    ${line} =~ s/^\s*end\s+?\w*\s+?;/    end component ;/ ;
}

sub inssert_ila{
    my ${desc} = <<EOS ;
    component module
      Port ( 
        clk : in STD_LOGIC;
        probe0 : in STD_LOGIC_VECTOR ( 63 downto 0 );
        probe1 : in STD_LOGIC_VECTOR ( 63 downto 0 );
        probe2 : in STD_LOGIC_VECTOR ( 63 downto 0 )
      );
    end component ;

    instance: module 
        Port map ( 
        clk                                 =>    clk                                      ,
        probe0    (63  downto  0 )          =>    probe0    (63  downto  0 )               ,
        probe1    (63  downto  0 )          =>    probe1    (63  downto  0 )               ,
        probe2    (63  downto  0 )          =>    probe2    (63  downto  0 )
        );
EOS
    print ${desc} ;
}

sub print_if {
    my ${desc} = <<EOS ;
    if () then
    elsif () then
    else
    end if;
EOS
    print ${desc} ;
}

sub print_entity {
    my ${desc} = <<EOS ;
entity MODULE is
  port(
  ) ;
end MODULE ;
EOS
    print ${desc} ;
}

sub print_logic {
    my ${type} = $_[0] ;
    my ${sig_name} = $_[1] ;
    my ${desc} = "" ;
    if (${type} eq "signal"){
    ${desc} = "signal ${sig_name}     : std_logic  ;\n";
} else {
    ${desc} = "${sig_name}     : ${type} std_logic  ;\n";
}
    print ${desc} ;
}
