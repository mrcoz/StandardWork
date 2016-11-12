use v6;
use XML;
use Test;

# Read standard work file: csvFile
# Read Hendrix Order Export: xmlFile
my $vinDir = './data/vinXML';
my $prodTackDir = './data/prodTasks';
my $prodScheduleDir = './data/prodSchedule';
my $prodScheduleData = '1611xx';

say "Directory $vinDir exists: " ~ $vinDir.IO.e;
say "Directory $prodTackDir exists: " ~ $prodTackDir.IO.e;
say "Directory $prodScheduleDir exists: " ~ $prodScheduleDir.IO.e;

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

my $xmlFileName;
my $csvFile;

my %ProductionCycle;
%ProductionCycle.push: ($vinSt5 => $prodTaskSt5);
%ProductionCycle.push: ($vinSt4 => $prodTaskSt4);
%ProductionCycle.push: ($vinSt3 => $prodTaskSt3);
%ProductionCycle.push: ($vinSt2 => $prodTaskSt2);
%ProductionCycle.push: ($vinSt1 => $prodTaskSt1);


for %ProductionCycle.sort(*.key)>>.kv -> ($xmlFileName, $csvFile) {
  "$xmlFileName: $csvFile".say;

  # :i - ignore case
  # ^ - matches at start of string
  # $ - matches at end of string

  #my @xmlFileList = $vinDir.IO.dir(test => /:i '.' xml$/)».Str;
  my @xmlFileList = $vinDir.IO.dir(test => /^ $xmlFileName /)».Str;
  say @xmlFileList.elems;

  if @xmlFileList[0].IO.f {
      say "file exists";
      readXML (@xmlFileList)
  }
  else {
      say "file doesn't exist";
  }

}

sub readXML (@xmlFileList) {
  my $xmlFile = slurp(@xmlFileList[0]);
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
}


#say "testfile".IO.e;  # True
#say "lib".IO.e;       # True
# However, since only one of them is a directory, the directory test method d will give a different result:

#say "testfile".IO.d;  # False
#say "lib".IO.d;       # True
# Naturally the tables are turned if we check to see if the path is a file via the file test method f:

#say "testfile".IO.f;  # True
#say "lib".IO.f;       # False
