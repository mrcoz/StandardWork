unit module createProdCycle;

# Store in Hash and return for better control!

sub createCsvFile (%standardWork, %Order, $xmlFileName) is export {
  my $col1 = "Station";
  my $col2 = "Process_#";
  my $col3 = "Process_Name";
  my $col4 = %Order{"trailerSize"};
  my $col5 = "People";
  my $col6 = "Responsible";

  my @a = ["Station", "Process_#", "Process_Name", %Order{"trailerSize"}, "People", "Responsible"];
  my @a2;

  my $csvFile = $xmlFileName ~ ".csv";
  my $totalMin;
  my $fh = open $csvFile, :w;
  #$fh.say(%Order);
  #$fh.say(%standardWork);
  say %standardWork{$col1}[].elems;

  $fh.say(%standardWork{$col1}[0] ~ ", " ~ %standardWork{$col2}[0] ~ ", " ~ %standardWork{$col3}[0]
   ~ ", " ~ %standardWork{$col4}[0] ~ ", " ~ %standardWork{$col5}[0] ~ ", " ~ %standardWork{$col6}[0]);

   my $row = "";
   for @a -> $ab { $row ~= %standardWork{$ab}[0] ~ ", "; }
   @a2.append($row);
   say @a2[0];

  loop (my $i = 1; $i <= %standardWork{"Process_Name"}[].elems; $i++ ) {
    if %standardWork{"Station"}[$i] {
      if %standardWork{"Choice_Name"}[$i] {
        if !%Order{%standardWork{"Choice_Name"}[$i]} {
          say %standardWork{"Choice_Name"}[$i] ~ " - Missing from xmlFile";
        }
        else {
          if %Order{%standardWork{"Choice_Name"}[$i]} eq %standardWork{"Choice_Value"}[$i] {
            #say %standardWork{"Choice_Name"}[$i] ~ " - Options";
            $fh.say(%standardWork{$col1}[$i] ~ ", ***" ~ %standardWork{$col2}[$i] ~ "***, "
            ~ %standardWork{$col3}[$i] ~ ", " ~ %standardWork{$col4}[$i] ~ ", "
            ~ %standardWork{$col5}[$i] ~ ", " ~ %standardWork{$col6}[$i]);
            $row = '';
            for @a -> $ab { $row ~= %standardWork{$ab}[$i] ~ ", "; }
            @a2.append($row);
            $totalMin += %standardWork{$col4}[$i];
          }
        }
      }
      else {
        $fh.say(%standardWork{$col1}[$i] ~ ", " ~ %standardWork{$col2}[$i] ~ ", "
        ~ %standardWork{$col3}[$i] ~ ", " ~ %standardWork{$col4}[$i] ~ ", " ~
         %standardWork{$col5}[$i] ~ ", " ~ %standardWork{$col6}[$i]);
         $row = '';
         for @a -> $ab { $row ~= %standardWork{$ab}[$i] ~ ", "; }
         @a2.append($row);
        $totalMin += %standardWork{$col4}[$i];
      }
=begin comment
=end comment
    }
  }

  $fh.say(",,," ~ $totalMin);
  $fh.say(",,," ~ $totalMin/60);
  $fh.close;
  @a2;
}
