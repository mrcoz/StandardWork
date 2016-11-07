use v6;

my $csvFile = "ProcessFlow2.csv";
my %h;
my $cnt = 0;
my $colCnt = 0;
my @columnName;

for $csvFile.IO.lines -> $line {
    my @t = $line.split(',');
    if @t[2] {
      if $cnt == 0 {
        @columnName = @t;
        $cnt++;
      }
      for @columnName -> $al {
        %h.push: ($al => @t[$colCnt]);
        $colCnt++;
      }
      $colCnt = 0;
#    say @t[0] ~ " " ~ @t[1] ~ " " ~ @t[2] ~ " " ~ @t[3] ~ " " ~ @t[4] ~ " " ~ @t[5] ~ " " ~ @t[6];
    if @t[4] {
#      say "Here ******: " ~ @t[5];
    }
  }
#    %h.push: (@t[0] => @t[1]);
#    %h.push: (@t[1] => @t[0]);
}

#for %h{"Station"} -> $key {
#  say $key ~ " " ~ %h{$key}.join(', ');
#}

#say %h{"Station"};
#say %h{"Option"};
#say %h{"7.0x20"};

# JSON Format
#say "[";
for %h.keys.sort -> $key {
    #say "\"$key\",\n [\"%h{$key}.join('", "')\"],";
}
#say "]";

# Array Format
#say "var ConstraintLogic = \{";
#for %h.keys.sort -> $key {
#    say "\"$key\": [\"%h{$key}.join('", "')\"],";
#}
#say "\};";
#my $ProcessName;
say %h{"Process_Name"}[].elems;

for %h{"Process_Name"}[] -> $ProcessName {
  #say $ProcessName;
}

loop (my $i = 0; $i <= %h{"Process_Name"}[].elems; $i++ ) {
  if %h{"Station"}[$i] {
    if !%h{"Choice_name"}[$i] {
      say %h{"Station"}[$i] ~ " " ~ %h{"Process_#"}[$i] ~ " " ~ %h{"Process_Name"}[$i] ~ " " ~ %h{"7.0x20"}[$i];
    }
    else {

    }
  }
}
