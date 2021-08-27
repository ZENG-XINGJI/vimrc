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
GetOptions (
    'f=s'     => \${file_in} ,
    't=s'     => \$text ,
    'tp!'     => \$en_text_pipe ,
    'help|h!' => \${help} ,
    'vh2v=s'  => \${vh2v} ,
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
if ($en_text_pipe != 0) {
    if (${vh2v} eq "module_def") {
        my @{text_pipe} = &get_text_from_pipe() ;
        my ${print_txt} = "" ;
        foreach ${txt_line} (@text_pipe) {
            ${txt_line} =~ s/entity \s*(\w*) \s*is/module $1/ ;
            ${txt_line} =~ s/port \s*\(/\(/ ;
            ${txt_line} =~ s/^\s*(\w*)\s*:\s*(\w*) \s*\w*vector\(\s*(\d*) \s*\w*to \s*(\d*)\s*\)\s*;/\t$2put\t[$3:$4]\t\t$1 ,/ ;
            ${txt_line} =~ s/^\s*(\w*)\s*:\s*(\w*) \s*\w*vector\(\s*(\d*) \s*\w*to \s*(\d*)\s*\)\s*/\t$2put\t[$3:$4]\t\t$1 / ;
            ${txt_line} =~ s/^\s*(\w*)\s*:\s*(\w*) \s*\w*\s*;/\t$2put\t\t\t$1 ,/ ;
            ${txt_line} =~ s/^\s*(\w*)\s*:\s*(\w*) \s*\w*\s*/\t$2put\t\t\t$1 / ;
            ${txt_line} =~ s/--/\/\// ;
            ${txt_line} =~ s/--//g ;
            ${txt_line} =~ s/^\s*end\s*\w*\s*;// ;
            ${print_txt} = "${print_txt}\n${txt_line}";
        }
        print "${print_txt}\n" ;
    } 
    elsif (${vh2v} eq "wire_def"){
        my @{text_pipe} = &get_text_from_pipe() ;
        my ${print_txt} = "" ;
        foreach ${txt_line} (@text_pipe) {
            ${txt_line} =~ s/^\s*signal \s*(\w*)\s*:\s*\w*vector\(\s*(\d*) \s*\w*to \s*(\d*)\s*\)\s*;/\twire\t[$2:$3]\t\t$1 ;/ ;
            ${txt_line} =~ s/^\s*signal \s*(\w*)\s*:\s*\w*\s*;/\twire\t\t\t\t$1 ;/ ;
            ${txt_line} =~ s/--/\/\// ;
            ${txt_line} =~ s/--//g ;
            ${print_txt} = "${print_txt}\n${txt_line}";
        }
        print "${print_txt}\n" ;
    } 
    elsif (${vh2v} eq "reg_def"){
        my @{text_pipe} = &get_text_from_pipe() ;
        my ${print_txt} = "" ;
        foreach ${txt_line} (@text_pipe) {
            ${txt_line} =~ s/^\s*signal \s*(\w*)\s*:\s*\w*vector\(\s*(\d*) \s*\w*to \s*(\d*)\s*\)\s*;/\treg\t[$2:$3]\t\t$1 ;/ ;
            ${txt_line} =~ s/^\s*signal \s*(\w*)\s*:\s*\w*\s*;/\treg\t\t\t\t$1 ;/ ;
            ${txt_line} =~ s/--/\/\// ;
            ${txt_line} =~ s/--//g ;
            ${print_txt} = "${print_txt}\n${txt_line}";
        }
        print "${print_txt}\n" ;
    } 
    elsif (${vh2v} eq "instance"){
        my @{text_pipe} = &get_text_from_pipe() ;
        my ${print_txt} = "" ;
        foreach ${txt_line} (@text_pipe) {
            ${txt_line} =~ s/^\s*(\w*)\s*:\s*(\w*)/$2 $1/ ;
            ${txt_line} =~ s/port \s*map\s*\(/\(/ ;
            ${txt_line} =~ s/\(\s*others\s*=>\s*'(\d)'\s*\)/'b$1/ ;
            #${txt_line} =~ s/(\(\s*others\s*=>\s*'1'\s*\))/NOT SUPPORTED CONVERTION $1!!/ ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(open)\s*,/\t\.$1\t\t\t\t\(\/\*$2\*\/\t\t\t\t\) ,/ ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(open)\s*/\t\.$1\t\t\t\t\(\/\*$2\*\/\t\t\t\t\) ,/ ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(\w++)\s*,/\t\.$1\t\t\t\t\($2\t\t\t\t\) ,/ ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(\w++)\s*/\t\.$1\t\t\t\t\($2\t\t\t\t\)  / ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(\S++)\s*,/\t\.$1\t\t\t\t\($2\t\t\t\t\)  ,/ ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(\S++)\s*$/\t\.$1\t\t\t\t\($2\t\t\t\t\)  / ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(\S++)\s*--$/\t\.$1\t\t\t\t\($2\t\t\t\t\)  --/ ;
            ${txt_line} =~ s/^\s*(.*to.*)\s*=>\s*(\S++)\s*,/\t\.$1\t\t\t\t\($2\t\t\t\t\)  ,/ ;
            ${txt_line} =~ s/^\s*(.*to.*)\s*=>\s*(\S++)\s*$/\t\.$1\t\t\t\t\($2\t\t\t\t\)  / ;
            ${txt_line} =~ s/^\s*(.*to.*)\s*=>\s*(\S++)\s*--$/\t\.$1\t\t\t\t\($2\t\t\t\t\)  --/ ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(.*to.*)\s*,/\t\.$1\t\t\t\t\($2\t\t\t\t\)  ,/ ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(.*to.*)\s*$/\t\.$1\t\t\t\t\($2\t\t\t\t\)  / ;
            ${txt_line} =~ s/^\s*(\w++)\s*=>\s*(.*to.*)\s*--$/\t\.$1\t\t\t\t\($2\t\t\t\t\)  --/ ;
            ${txt_line} =~ s/^\s*(.*to.*)\s*=>\s*(.*to.*)\s*,/\t\.$1\t\t\t\t\($2\t\t\t\t\)  ,/ ;
            ${txt_line} =~ s/^\s*(.*to.*)\s*=>\s*(.*to.*)\s*$/\t\.$1\t\t\t\t\($2\t\t\t\t\)  / ;
            ${txt_line} =~ s/^\s*(.*to.*)\s*=>\s*(.*to.*)\s*--$/\t\.$1\t\t\t\t\($2\t\t\t\t\)  --/ ;
            ${txt_line} =~ s/'(\d)'/1'b$1/ ;
            ${txt_line} =~ s/"(\d++)"/"$1"/ ;
            my ${bit_width} = length($1) ;
            ${txt_line} =~ s/"(\d++)"/${bit_width}'b$1/ ;
            ${txt_line} =~ s/(\w++)\s*\(\s*(\d++)\s++\w*to\s++(\d++)\s*\)/$1\[$2:$3\]/g ;
            ${txt_line} =~ s/--/\/\// ;
            ${txt_line} =~ s/--//g ;
            ${print_txt} = "${print_txt}\n${txt_line}";
        }
        print "${print_txt}\n" ;
    } 
    elsif (${vh2v} eq "NOT_ACTIVE"){
        #print "${vh2v}\n" ;
    } 
    else {
        print "ERROR: Un-supported value ${vh2v} for option -vh2v!\n" ;
        exit(-1) ;
    }
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
