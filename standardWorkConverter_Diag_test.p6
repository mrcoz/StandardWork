use v6;
use XML;
use Test;

# Read standard work file: csvFile
# Read Hendrix Order Export: xmlFile
my $vinSt1 = '206202';
my $vinSt2 = '205167';
my $vinSt3 = '206129';
my $vinSt4 = '206112';
my $vinSt5 = '206173';

my $prodTaskSt1 = "prodTaskSt1.csv";
my $prodTaskSt2 = "prodTaskSt2.csv";
my $prodTaskSt3 = "prodTaskSt3.csv";
my $prodTaskSt4 = "prodTaskSt4.csv";
my $prodTaskSt5 = "prodTaskSt5.csv";

my %ProductionCycle = {
  Station0 => # Prep / Offline Kitting
  Station1 =>
  Station2 =>
  Station3 =>
  Station4 =>
  Station5 =>
}

# Generate VIN Specific Standard Work File: csv Format
my $cnt = 0;
my $xmlFileName;
my @xmlFileList = dir(test => /:i '.' xml$/)».Str;
for @xmlFileList -> $xmlDirFile {
  $xmlFileName = $xmlDirFile;
  my $xmlFile = slurp($xmlFileName);
  my $xml = XML::Element.new($xmlFile);
  ok $xml ~~ XML::Element, 'Element parsed properly.';

  my @items = $xml.elements();
  is @items.elems, 5, 'elements() returns correct number.';

  my %Order;
  my @orderElements;
  my $orderElementAttributes;
  for @items {
    if .name ~~ 'Templates' {
      @orderElements = .elements();
      for @orderElements -> $orderElementAttributes {
        if $orderElementAttributes.attribs<value> && $orderElementAttributes.attribs<name> {
          %Order.push: ($orderElementAttributes.attribs<name> => $orderElementAttributes.attribs<value>);
          if $orderElementAttributes.attribs<value>.contains("Error") {
            say "You have an error in your xml: " ~ $orderElementAttributes.attribs<name>;
          }
        }
      }
    }
  }
  # say %Order;
  say "Order: " ~ %Order{"WidthSpec"};
  my @trailerWidth = %Order{"WidthSpec"}.split('x');
  say @trailerWidth[0];

  if @trailerWidth[0] ~~ '8.5' {
    %Order.push: ('trailerWidth85' => '1');
  }
  else {
    %Order.push: ('trailerWidth70' => '1');
  }

  my $trailerSize = %Order{"WidthSpec"};
  if %Order{"Package_FrontBedroom_Choices_Prod"} != 0 {
    $trailerSize = $trailerSize ~ "FB";
  }
  say $trailerSize;
  # *****************************************************************************
  # my $csvFile = "ProcessFlow3.csv";
  # my $csvFile = "Process Flow - st1.csv";
  # my $csvFile = "Process Flow - st2.csv";
  my $csvFile = "Process Flow - st3.csv";
  # my $csvFile = "Process Flow - st4.csv";
  # my $csvFile = "Process Flow - st5.csv";
  my %standardWork;
  my $cnt = 0;
  my $colCnt = 0;
  my @columnName;

# my @data;
# my $data-file = open $csvFile;
# for $data-file.lines -> $line {
#  @data.push($line.split(','))
#v}

  for $csvFile.IO.lines -> $line {
      my @standardWorkItem = $line.split(',');
      if @standardWorkItem[2] {
        if $cnt == 0 { # Set 1st Row as Key for column
          @columnName = @standardWorkItem;
          $cnt++;
        }
        for @columnName -> $standardWorkHeader {
          %standardWork.push: ($standardWorkHeader => @standardWorkItem[$colCnt]);
          $colCnt++;
        }
        $colCnt = 0;
    }
  }
  $csvFile = $xmlFileName ~ ".csv";
  say $csvFile;

  my $totalMin;
  my $fh = open $csvFile, :w;

  #say %standardWork{"Process_Name"}[].elems;
  $fh.say(%standardWork{"Station"}[0] ~ ", " ~ %standardWork{"Process_#"}[0] ~ ", "
  ~ %standardWork{"Process_Name"}[0] ~ ", " ~ %standardWork{$trailerSize}[0] ~ ", " ~ %standardWork{"People"}[0] ~ ", " ~ %standardWork{"Respoinsible"}[0]);

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
            ~ %standardWork{"Process_Name"}[$i] ~ ", " ~ %standardWork{$trailerSize}[$i] ~ ", " ~ %standardWork{"People"}[$i] ~ ", " ~ %standardWork{"Respoinsible"}[$i]);
            $totalMin += %standardWork{$trailerSize}[$i];
          }
        }
      }
      else {
        $fh.say(%standardWork{"Station"}[$i] ~ ", " ~ %standardWork{"Process_#"}[$i] ~ ", "
        ~ %standardWork{"Process_Name"}[$i] ~ ", " ~ %standardWork{$trailerSize}[$i] ~ ", " ~ %standardWork{"People"}[$i] ~ ", " ~ %standardWork{"Respoinsible"}[$i]);
        $totalMin += %standardWork{$trailerSize}[$i];
      }
    }
  }

  $fh.say(",,," ~ $totalMin);
  $fh.say(",,," ~ $totalMin/60);
  $fh.close;
}
