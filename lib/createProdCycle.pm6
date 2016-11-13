unit module createProdCycle;

sub createCsvFile (%standardWork, %Order, $xmlFileName) {
  my $csvFile = $xmlFileName ~ ".csv";
  say $csvFile;

  my $totalMin;
  my $fh = open $csvFile, :w;

  #say %standardWork{"Process_Name"}[].elems;
  $fh.say(%standardWork{"Station"}[0] ~ ", " ~ %standardWork{"Process_#"}[0] ~ ", "
  ~ %standardWork{"Process_Name"}[0] ~ ", " ~ %standardWork{"trailerSize"}[0] ~ ", " ~ %standardWork{"People"}[0] ~ ", " ~ %standardWork{"Respoinsible"}[0]);

  loop (my $i = 1; $i <= %standardWork{"Process_Name"}[].elems; $i++ ) {
    if %standardWork{"Station"}[$i] {
      if %standardWork{"Choice_Name"}[$i] {
        if !%Order{%standardWork{"Choice_Name"}[$i]} {
          say %standardWork{"Choice_Name"}[$i] ~ " - Missing from xmlFile";
        }
        else {
          if %Order{%standardWork{"Choice_Name"}[$i]} eq %standardWork{"Choice_Value"}[$i] {
            say %standardWork{"Choice_Name"}[$i] ~ " - Options";
            $fh.say(%standardWork{"Station"}[$i] ~ ", ***" ~ %standardWork{"Process_#"}[$i] ~ "***, "
            ~ %standardWork{"Process_Name"}[$i] ~ ", " ~ %standardWork{"trailerSize"}[$i] ~ ", " ~ %standardWork{"People"}[$i] ~ ", " ~ %standardWork{"Respoinsible"}[$i]);
            $totalMin += %standardWork{"trailerSize"}[$i];
          }
        }
      }
      else {
        $fh.say(%standardWork{"Station"}[$i] ~ ", " ~ %standardWork{"Process_#"}[$i] ~ ", "
        ~ %standardWork{"Process_Name"}[$i] ~ ", " ~ %standardWork{"trailerSize"}[$i] ~ ", " ~ %standardWork{"People"}[$i] ~ ", " ~ %standardWork{"Respoinsible"}[$i]);
        $totalMin += %standardWork{"trailerSize"}[$i];
      }
    }
  }

  $fh.say(",,," ~ $totalMin);
  $fh.say(",,," ~ $totalMin/60);
  $fh.close;
}
