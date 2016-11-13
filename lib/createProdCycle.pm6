unit module createProdCycle;

# Store in Hash and return for better control!
sub createCsvFile (%standardWork, %Order, $xmlFileName) is export {
  my @header = ["Station", "Process_#", "Process_Name", %Order{"trailerSize"}, "People", "Responsible"];
  my @configOrder;
  my $totalMin;
  my $row = '';
  for @header -> $colName { $row ~= %standardWork{$colName}[0] ~ ", "; }
  @configOrder.append($row);

  loop (my $i = 1; $i <= %standardWork{"Process_Name"}[].elems; $i++ ) {
    if %standardWork{"Station"}[$i] {
      if %standardWork{"Choice_Name"}[$i] {
        if !%Order{%standardWork{"Choice_Name"}[$i]} {
          say %standardWork{"Choice_Name"}[$i] ~ " - Missing from xmlFile";
        }
        else {
          if %Order{%standardWork{"Choice_Name"}[$i]} eq %standardWork{"Choice_Value"}[$i] {
            $row = '';
            for @header -> $colName { $row ~= %standardWork{$colName}[$i] ~ ", "; }
            @configOrder.append($row);
            $totalMin += %standardWork{@header[3]}[$i];
          }
        }
      }
      else {
        $row = '';
        for @header -> $colName { $row ~= %standardWork{$colName}[$i] ~ ", "; }
        @configOrder.append($row);
        $totalMin += %standardWork{@header[3]}[$i];
      }
    }
  }
  @configOrder;
}
