unit module setDefaults;

# Read standard work file: csvFile
# Read Hendrix Order Export: xmlFile
our $vinDir is export = './data/vinXML';
our $prodTackDir is export = './data/prodTasks';
our $prodScheduleDir is export = './data/prodSchedule';
our $prodScheduleData is export = '1611xx';

our $vinSt1 = '206493';
our $vinSt2 = '206511';
our $vinSt3 = '206112';
our $vinSt4 = '206173';
our $vinSt5 = '206129';

our $prodTaskSt1 = "prodTaskSt1.csv";
our $prodTaskSt2 = "prodTaskSt2.csv";
our $prodTaskSt3 = "prodTaskSt3.csv";
our $prodTaskSt4 = "prodTaskSt4.csv";
our $prodTaskSt5 = "prodTaskSt5.csv";

our @ProductionCycle1 is export = [
  {$vinSt5 => $prodTaskSt5},
  {$vinSt4 => $prodTaskSt4},
  {$vinSt3 => $prodTaskSt3},
  {$vinSt2 => $prodTaskSt2},
  {$vinSt1 => $prodTaskSt1},
];
