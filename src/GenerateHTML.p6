use strict;
use warnings;
use FileHandle;

my $Title = "The Edge Project";
my $Name  = "8528";
my @MenuSystem;
my $A0;
my $A1;
my $A2;
my @header;
my @MenuGroup;
my $ttt;
my $A0cnt = 0;
my $linecnt =0;

my $fh = FileHandle->new;
if ( $fh->open("< DisplayOptions.csv") ) {
	while (<$fh>) {
	if ($linecnt eq 0){ # Read Headers for use in hash
	print "Here\n";
	@header = split( ',', $_ );
	$linecnt ++;
	}
	else {
		@MenuSystem = split( ',', $_ );
		my $cnt = 0;
		foreach my $item (@MenuSystem) {
		if ($item) {
			print "$item, $cnt, $header[$cnt]\n";
			$A0         = $MenuSystem[0];
			}
			$cnt ++;
		}
	}
	}

}
exit(0);
foreach my $item (@MenuGroup) {
	print "$item\n";
}

$fh->close;
PrintNav(\@MenuGroup);


# ***
PrintHeader( $Title, $Name );
PrintNav(\@MenuGroup);
PrintButtonMenu();
PrintPriceDisplay();
PrintX3D();
PrintForm();
PrintFooter();

# ***

sub PrintOptionNumbers {
	my $i;
	for ( $i = 1 ; $i <= 15 ; $i++ ) {
		print '      <option value="' . $i . '">' . $i . '</option>' . "\n";
	}
}

sub PrintOptionColors {

	my %ColorOptions = (
		"black"           => "Black",
		"purple"          => "Purple",
		"cyan"            => "Cyan",
		"brandywine"      => "Brandywine",
		"bronze"          => "Bronze",
		"emeraldGreen"    => "Emerald Green",
		"indigoBlue"      => "Indigo Blue",
		"lightPewter"     => "Light Pewter",
		"mediumCharcoal"  => "Medium Charcoal",
		"penskeYellow"    => "Yellow",
		"polarWhite"      => "White",
		"schniederOrange" => "Orange",
		"silverFrost"     => "Silver Frost",
		"victoryRed"      => "Red",
	);

	foreach my $key ( sort keys %ColorOptions ) {
		print '      <option value="'
		  . $key . '">'
		  . $ColorOptions{$key}
		  . '</option>' . "\n";
	}
}

sub PrintHeader {
	my ( $Title, $Name ) = @_;

	print '<!DOCTYPE html>' . "\n";
	print '<html>' . "\n";
	print '  <head>' . "\n";
	print '  <title>' . $Title . '</title>' . "\n";
	print
'  <link rel="stylesheet" type="text/css" href="../../css/StyleSheet.css"></link>'
	  . "\n";
	print
	  '  <link href="../../Images/ATC_Logo.jpg" rel="icon" type="image/png" />'
	  . "\n";
	print '  <link rel="stylesheet" href="../../css/bootstrap.min.css">' . "\n";
	print '  </head>' . "\n";
	print '  <header>' . "\n";
	print '    <h1 id="header" name="' . $Name . '">' . $Title . '</h1>' . "\n";
	print '  </header>' . "\n";
	print "\n";
}

sub PrintNav {
my ( @MenuGroup ) = @_;
	# my @idref = [ exterior,sleepingOptions1,];

	print '  <body>' . "\n";
	print "\n";
	print '  <nav id="mySidenav" class="sidenav">' . "\n";
	print '    <ul id="tab">' . "\n";
	foreach my $item (@MenuGroup) {
	print "$item\n";
		print '      <li><a href="#" idref="exterior" class="tablinks">Exterior</a></li>' . "\n";
}
	print
'      <li><a href="#" idref="exterior" class="tablinks">Exterior</a></li>'
	  . "\n";
	print
'      <li><a href="#" idref="sleepingOptions1" class="tablinks">Sleeping and Seating Options test</a></li>'
	  . "\n";
	print
'      <li><a href="#" idref="heatingAndCooling" class="tablinks">Heating And Cooling</a></li>'
	  . "\n";
	print
'      <li><a href="#" idref="interior" class="tablinks">Interior</a></li>		  '
	  . "\n";
	print
'      <li><a href="#" idref="loadingAndTieDowns" class="tablinks">Loading And Tie Down</a></li>'
	  . "\n";
	print "\n";
	print
'      <li><a href="#" idref="electrical" class="tablinks">Electrical</a></li>'
	  . "\n";
	print '    </ul>' . "\n";
	print '  </nav>' . "\n";
	print "\n";
}

sub PrintButtonMenu {
	print "\n";
	print '  <div id="main">' . "\n";
	print
'    <a><span id="menuIcon" class="glyphicon glyphicon-th-list"></span></a>'
	  . "\n";
	print
'    <input id="slct_exteriorViewEnable" type="submit" value="Interior View" class="topButton"><br>'
	  . "\n";
	print
'    <input id="slct_nightView" type="submit" value="Night View" class="topButton"><br>'
	  . "\n";
	print
'    <input id="slct_collisionRendering" type="submit" value="Enable Collision Rendering" class="topButton"><br>'
	  . "\n";
	print
'    <input id="slct_pricingToggle" type="submit" value="Show Price Information" class="topButton"><br>'
	  . "\n";
	print
'    <input id="slct_path" type="submit" value="Begin Virtual Tour" class="topButton"><br>'
	  . "\n";
	print '  </div>' . "\n";
	print "\n";
}

sub PrintPriceDisplay {
	print '  <div id="priceInfo" class="dropdown">' . "\n";
	print '    <p id="priceTotal">Total: $29295</p><br>' . "\n";
	print
'    <button id="priceBreakdownBtn" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"> '
	  . "\n";
	print
'    <span id="menuDownIcon" class="glyphicon glyphicon-menu-down"></span>'
	  . "\n";
	print
'    <span id="menuUpIcon" class="glyphicon glyphicon-menu-up"></span></button>'
	  . "\n";
	print '    <ul id="priceBreakdown" class="dropdown-menu">' . "\n";
	print
'      <li class="priceComponent">Base Model<p class="componentPrice">$29245</p></li>'
	  . "\n";
	print '      <li class="divider" id="divider"><li>' . "\n";
	print
'      <li class="priceComponent">Total:<p id="priceTotalBreakdown" class="componentPrice">$29245</p></li>'
	  . "\n";
	print '    </ul>' . "\n";
	print '  </div>' . "\n";
	print '' . "\n";
}

sub PrintX3D {
	print '  <X3D showStat="false" showLog="false" PrimitiveQuality="low"> '
	  . "\n";
	print "\n";
	print '    <Scene id="ARV">' . "\n";
	print "\n";
	print '    <!-- Scene -->' . "\n";
	print
'    <navigationInfo id="head" headlight="true" type=\'"EXAMINE"\'></navigationInfo>'
	  . "\n";
	print '    <background skyColor=".8 .8 .8 "></background>' . "\n";
	print
'    <Viewpoint id="viewPoint" centerOfRotation="0 60 -150" position="289.04603 137.47154 217.53466" orientation="-0.27896 0.95432 0.10702 0.76444" description="defaultX3DViewpointNode"></Viewpoint>'
	  . "\n";
	print "\n";
	print
'    <Inline id="dayNightView" nameSpaceName="dayNightView" url="Options/dayNightView.x3d" render="true"></Inline>'
	  . "\n";
	print '    <Inline id="ground" url="x3d_Library/Ground.x3d"> </Inline>'
	  . "\n";
	print "\n";
	print
'    <Inline id="baseModel" nameSpaceName="baseModel" mapDEFToID="true" url="Options/baseModel.x3d" render="true"> </Inline>'
	  . "\n";
	print "\n";
	print '    <!-- Options -->' . "\n";
	print
'    <Inline id="sleepingOptions" nameSpaceName="sleepingOptions" mapDEFToID="true" url="Options/sleepingOptions.x3d" render="true"> </Inline>'
	  . "\n";
	print
'    <Inline id="heatingAndCoolingOptions" nameSpaceName="heatingAndCoolingOptions" mapDEFToID="true" url="Options/heatingAndCoolingOptions.x3d" render="true"> </Inline>'
	  . "\n";
	print
'    <Inline id="interiorOptions" nameSpaceName="interiorOptions" mapDEFToID="true" url="Options/interiorOptions.x3d" render="true"> </Inline> '
	  . "\n";
	print
'    <Inline id="loadingAndTieDownOptions" nameSpaceName="loadingAndTieDownOptions" url="Options/loadingAndTieDownOptions.x3d" render="true"> </Inline>'
	  . "\n";
	print
'    <Inline id="exteriorOptions" nameSpaceName="exteriorOptions" mapDEFToID="true" url="Options/exteriorOptions.x3d" render="true"> </Inline>'
	  . "\n";
	print
'    <Inline id="electricalOptions" nameSpaceName="electricalOptions" mapDEFToID="true" url="Options/electricalOptions.x3d" render="true" onClick="console.log(this.id);"> </Inline>'
	  . "\n";
	print "\n";
	print '    <!--  Other parts -->' . "\n";
	print
'    <!--Inline id="tableFoldDown" nameSpaceName="tableFoldDown" mapDEFToID="true" url="Options/tableFoldDown.x3d" render="true"> </Inline-->'
	  . "\n";
	print
'    <Inline id="shell" nameSpaceName="shell" mapDEFToID="true" url="Options/shell.x3d" render="true">  </Inline>'
	  . "\n";
	print "\n";
	print
'    <!--Inline id="Scene" url="x3d_Library/HadesScene.x3d" render="true"></Inline-->'
	  . "\n";
	print "\n";
	print '    </Scene>' . "\n";
	print '  </X3D>' . "\n";
	print "\n";
}

sub PrintForm {

	print '  <form id="form1">' . "\n";
	print "\n";
	print '  <div id="sleepingOptions1" class="tabcontent">' . "\n";
	print '    <a href="javascript:void(0)" class="closebtn">&times;</a>'
	  . "\n";
	print "\n";
	print '    <h3>Sleeping and Seating Options</h3>' . "\n";
	print "\n";
	print '    <h4>Bed Door Options</h4>' . "\n";
	print
'    <input id="slct_bedDoorCS" type="checkbox" idref="sleepingOptions__bedDoorCS" name="model"><label class="inputText" id="txt_bedDoorCS">Bed Door, Curb Side</label><br>'
	  . "\n";
	print
'    <input id="slct_bedDoorRS" type="checkbox" idref="sleepingOptions__bedDoorRS" name="model"><label class="inputText" id="txt_bedDoorRS">Bed Door, Road Side</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Happijac Bed Options</h4>' . "\n";
	print
'    <input id="slct_happijacMiddle" type="checkbox" idref="sleepingOptions__happijacMiddle" name="model"><label class="inputText" id="txt_happijacMiddle">Happijac Bed, Middle</label><br>'
	  . "\n";
	print
'    <input id="slct_happijacRear" type="checkbox" idref="sleepingOptions__happijacRear" name="model"><label class="inputText" id="txt_happijacRear">Happijac Bed, Rear</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Sofa Options</h4>' . "\n";
	print
'    <input id="slct_sofaCSFront" type="checkbox" idref="sleepingOptions__sofaCSFront" name="sofaCSFront"><label class="inputText" id="txt_sofaCSFront">Sleeper Sofa Curb Side Front</label><br>'
	  . "\n";
	print
'    <input id="slct_sofaRSMiddle" type="checkbox" idref="sleepingOptions__sofaRSMiddle" name="sofaRSMiddle"><label class="inputText" id="txt_sofaRSMiddle">Sleeper Sofa Road Side Middle</label><br>'
	  . "\n";
	print
'    <input id="slct_sofaCSMiddle" type="checkbox" idref="sleepingOptions__sofaCSMiddle" name="sofaCSMiddle"><label class="inputText" id="txt_sofaCSMiddle">Sleeper Sofa Curb Side Middle</label><br>'
	  . "\n";
	print
'    <input id="slct_sofaCSRear" type="checkbox" idref="sleepingOptions__sofaCSRear" name="sofaCSRear"><label class="inputText" id="txt_sofaCSRear">Sleeper Sofa Curb Side Rear</label><br>'
	  . "\n";
	print
'    <input id="slct_sofaRSRear" type="checkbox" idref="sleepingOptions__sofaRSRear" name="sofaRSRear"><label class="inputText" id="txt_sofaRSRear">Sleeper Sofa Road Side Rear</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Dinette Options</h4>' . "\n";
	print
'    <input id="slct_dinetteCSFront" type="checkbox" idref="sleepingOptions__dinetteCSFront" name="model"><label class="inputText" id="txt_dinetteCSFront">Dinette Curb Side, Front</label><br>'
	  . "\n";
	print
'    <input id="slct_dinetteCSMiddle" type="checkbox" idref="sleepingOptions__dinetteCSMiddle" name="model"><label class="inputText" id="txt_dinetteCSMiddle">Dinette Curb Side, Middle</label><br>'
	  . "\n";
	print
'    <input id="slct_dinetteCSRear" type="checkbox" idref="sleepingOptions__dinetteCSRear" name="model"><label class="inputText" id="txt_dinetteCSRear">Dinette Curb Side, Rear</label><br>'
	  . "\n";
	print
'    <input id="slct_dinetteRSMiddle" type="checkbox" idref="sleepingOptions__dinetteRSMiddle" name="model"><label class="inputText" id="txt_dinetteRSMiddle">Dinette Road Side, Middle</label><br>'
	  . "\n";
	print
'    <input id="slct_dinetteRSRear" type="checkbox" idref="sleepingOptions__dinetteRSRear" name="model"><label class="inputText" id="txt_dinetteRSRear">Dinette Road Side, Rear</label><br>'
	  . "\n";
	print "\n";
	print '  </div>' . "\n";
	print '  <div id="heatingAndCooling" class="tabcontent">' . "\n";
	print '    <a href="javascript:void(0)" class="closebtn">&times;</a>'
	  . "\n";
	print "\n";
	print '    <h3>Heating and Cooling Options</h3>' . "\n";
	print "\n";
	print '    <h4>Bathroom</h4>' . "\n";
	print
'    <input id="slct_ventBathroomMaxxAir" type="checkbox" idref="heatingAndCoolingOptions__ventBathroomMaxxAir" name="model"><label class="inputText" id="txt_ventBathroomMaxxAir">MaxxAir Vent Fan</label><br>'
	  . "\n";
	print
'    <input id="slct_ventBathroomMaxxAirCover" type="checkbox" idref="heatingAndCoolingOptions__ventBathroomMaxxAirCover" name="model"><label class="inputText" id="txt_ventBathroomMaxxAirCover">MaxxAir Vent Fan Cover</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Kitchen</h4>' . "\n";
	print
'    <input id="slct_ventKitchenMaxxAir" type="checkbox" idref="heatingAndCoolingOptions__ventKitchenMaxxAir" name="model"><label class="inputText" id="txt_ventKitchenMaxxAir">MaxxAir Vent Fan</label><br>'
	  . "\n";
	print
'    <input id="slct_ventKitchenMaxxAirCover" type="checkbox" idref="heatingAndCoolingOptions__ventKitchenMaxxAirCover" name="model"><label class="inputText" id="txt_ventKitchenMaxxAirCover">MaxxAir Vent Fan Cover</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Garage</h4>' . "\n";
	print
'    <input id="slct_ventGarageMaxxAirCover" type="checkbox" idref="heatingAndCoolingOptions__ventGarageMaxxAirCover" name="model"><label class="inputText" id="txt_ventGarageMaxxAirCover">MaxxAir Vent Fan Cover</label><br>'
	  . "\n";
	print
'    <input id="slct_airConditionerDual" type="checkbox" idref="heatingAndCoolingOptions__airConditionerDual" name="model"><label class="inputText" id="txt_airConditionerDual">Dual 13.5 BTU A/C\'s</label><br>'
	  . "\n";
	print
'    <input id="slct_airConditioner15000" type="checkbox" idref="heatingAndCoolingOptions__airConditioner15000" name="model"><label class="inputText" id="txt_airConditioner15000">15.0 BTU A/C</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Insulation</h4>' . "\n";
	print
'    <input id="slct_insulationFloor" type="checkbox" ><label class="inputText" id="txt_insulationFloor">In Floor Insulation</label><br>'
	  . "\n";
	print '  </div>' . "\n";
	print '  <div id="interior" class="tabcontent">' . "\n";
	print '    <a href="javascript:void(0)" class="closebtn">&times;</a>'
	  . "\n";
	print "\n";
	print '    <h3>Interior</h3>' . "\n";
	print "\n";
	print '    <h4>Interior Color</h4>' . "\n";
	print '    <select id="slct_interiorColor">' . "\n";
	PrintOptionColors();
	print '    </select><br>' . "\n";
	print "\n";
	print '    <h4>Upper Cabinet Curb Side</h4>' . "\n";
	print
	  '    <h5 id="cabinetUpperFrontCS">Overhead Curb Side Front Cabinet</h5>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperFrontCS4" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperFrontCS4" name="cabinetUpperFrontCS"><label class="inputText" id="txt_cabinetUpperFrontCS4">4 ft</label>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperFrontCS8" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperFrontCS8" name="cabinetUpperFrontCS"><label class="inputText" id="txt_cabinetUpperFrontCS8">8 ft</label><br>'
	  . "\n";
	print "\n";
	print
	  '    <h5 id="cabinetUpperMiddleCS">Overhead Curb Side Middle Cabinet</h5>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperMiddleCS4" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperMiddleCS4" name="cabinetUpperMiddleCS"><label class="inputText" id="txt_cabinetUpperMiddleCS4">4 ft</label>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperMiddleCS8" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperMiddleCS8" name="cabinetUpperMiddleCS"><label class="inputText" id="txt_cabinetUpperMiddleCS8">8 ft</label><br>'
	  . "\n";
	print "\n";
	print '    <h5 id="cabinetUpperRearCS">Overhead Curb Side Rear Cabinet</h5>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperRearCS4" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperRearCS4" name="cabinetUpperRearCS"><label class="inputText" id="txt_cabinetUpperRearCS4">4 ft</label>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperRearCS8" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperRearCS8" name="cabinetUpperRearCS"><label class="inputText" id="txt_cabinetUpperRearCS8">8 ft</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Upper Cabinet Road Side</h4>' . "\n";
	print
	  '    <h5 id="cabinetUpperMiddleRS">Overhead Road Side Middle Cabinet</h5>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperMiddleRS4" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperMiddleRS4" name="cabinetUpperMiddleRS"><label class="inputText" id="txt_cabinetUpperMiddleRS4">4 ft</label>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperMiddleRS8" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperMiddleRS8" name="cabinetUpperMiddleRS"><label class="inputText" id="txt_cabinetUpperMiddleRS8">8 ft</label><br>'
	  . "\n";
	print "\n";
	print '    <h5 id="cabinetUpperRearRS">Overhead Road Side Rear Cabinet</h5>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperRearRS4" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperRearRS4" name="cabinetUpperRearRS"><label class="inputText" id="txt_cabinetUpperRearRS4">4 ft</label>'
	  . "\n";
	print
'    <input id="slct_cabinetUpperRearRS8" class="childInput" type="checkbox" idref="interiorOptions__cabinetUpperRearRS8" name="cabinetUpperRearRS"><label class="inputText" id="txt_cabinetUpperRearRS8">8 ft</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Microwave</h4>' . "\n";
	print
'    <input id="slct_microwave" type="checkbox" idref="interiorOptions__microwave" name="model"><label class="inputText" id="txt_microwave">Microwave Convection Oven</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Television</h4>' . "\n";
	print
'    <input id="slct_tvGarage" type="checkbox" idref="interiorOptions__tvGarage" name="model"><label class="inputText" id="txt_tvGarage">24" LED 12V - Garage</label><br>'
	  . "\n";
	print
'    <input id="slct_antenna" type="checkbox" idref="interiorOptions__antenna" name="model"><label class="inputText" id="txt_antenna">Digital TV Antenna</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Radio</h4>' . "\n";
	print
'    <input id="slct_stereoAndSpeakers" type="checkbox" idref="interiorOptions__stereoAndSpeakers" name="model"><label class="inputText" id="txt_stereoAndSpeakers">AM/FM/Bluetooth Radio</label><br>'
	  . "\n";
	print "\n";
	print '	   <h4>Floor Coverings</h4>' . "\n";
	print
'    <input id="slct_carpetKitchen" type="checkbox" idref="" name="model"><label class="inputText" id="txt_carpetKitchen">Pebble Carpet - Kitchen/ Bsthroom Set</label><br>'
	  . "\n";
	print
'    <input id="slct_carpetGarage" type="checkbox" idref="" name="model"><label class="inputText" id="txt_carpetGarage">Carpet - Garage</label><br>'
	  . "\n";

	print '    <h4>Rear Closure</h4>' . "\n";
	print
'    <input id="slct_vinylClosure" type="checkbox" idref="" name="model"><label class="inputText" id="txt_vinylClosure">Vinyl Insert with Door, Window, and Screen</label><br>'
	  . "\n";
	print "\n";
	print '  </div>' . "\n";
	print '  <div id="loadingAndTieDowns" class="tabcontent">' . "\n";
	print '    <a href="javascript:void(0)" class="closebtn">&times;</a>'
	  . "\n";
	print "\n";
	print '    <h3>Loading and Tie Downs</h3>' . "\n";
	print "\n";
	print '    <h4>Floor Tie Downs</h4>' . "\n";
	print
'    <input id="slct_dRings" type="checkbox" idref="loadingAndTieDownOptions__dRings" name="model"><label class="inputText" id="txt_dRings">D-Rings - Recessed</label><br>'
	  . "\n";
	print
'    <input id="slct_airlineTrack55" type="checkbox" idref="loadingAndTieDownOptions__airlineTrack"><label class="inputText" id="txt_airlineTrack55">Floor Mounted Airline Track - Recessed</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Racking</h4>' . "\n";
	print
'    <input id="slct_airlineTrackWall" type="checkbox" idref="loadingAndTieDownOptions__airlineTrackWall" name="model" ><label class="inputText" id="txt_airlineTrackWall">Wall Mounted A-Track - 5 ft Surface Mount</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Tie Down Rings</h4>' . "\n";
	print
'    <input type="checkbox" idref="" name="model" ><label class="inputText" id="">Tie Down Ring - Single Stud - Airline Track</label>'
	  . "\n";
	print '    <select>' . "\n";
	PrintOptionNumbers();
	print '    </select><br>' . "\n";
	print
'    <input type="checkbox" idref="" name="model" ><label class="inputText" id="">Tie Down Ring - Triple Stud - Airline Track</label>'
	  . "\n";
	print '    <select>' . "\n";
	PrintOptionNumbers();
	print '    </select><br>' . "\n";
	print "\n";
	print '    <h4>Certification</h4>						' . "\n";
	print
'    <input id="slct_canadianDot" type="checkbox" idref="" name="model" ><label class="inputText">Canadian Dot</label><br>'
	  . "\n";
	print '  </div>			' . "\n";
	print '  <div id="exterior" class="tabcontent">' . "\n";
	print '    <a href="javascript:void(0)" class="closebtn">&times;</a>'
	  . "\n";
	print "\n";
	print '    <h3>Exterior</h3>' . "\n";
	print "\n";
	print '    <h4>Windows</h4>' . "\n";
	print
'    <input id="slct_windowMiddleCS" type="checkbox" idref="exteriorOptions__windowMiddleCS" name="model" ><label class="inputText" id="txt_windowMiddleCS">Middle Curb Side Window</label><br>'
	  . "\n";
	print
'    <input id="slct_windowMiddleRS" type="checkbox" idref="exteriorOptions__windowMiddleRS" name="model" ><label class="inputText" id="txt_windowMiddleRS">Middle Road Side Window</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Jacks</h4>' . "\n";
	print
'    <input id="slct_powerJack" type="checkbox" idref="exteriorOptions__powerJack" defaultId="exteriorOptions__sideWindJack" name="jacks"><label class="inputText" id="txt_powerJack">Jack - Power</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Roof Storage</h4>						' . "\n";
	print
'    <input id="slct_roofRack" type="checkbox" idref="exteriorOptions__roofRack" name="model" ><label class="inputText" id="txt_roofRack">Storage Racks - Roof Mount</label><br>'
	  . "\n";
	print
'    <input id="slct_roofPlatform" type="checkbox" idref="exteriorOptions__roofPlatform" name="model" ><label class="inputText" id="txt_roofPlatform">Storage Platform - Roof Mount</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Tongue Storage</h4>						' . "\n";
	print
'    <input id="slct_tonguePlate" type="checkbox" idref="exteriorOptions__tonguePlate" name="model" ><label class="inputText" id="txt_tonguePlate">Tongue Mount Plate with Rope Rings</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Shower</h4>						' . "\n";
	print
'    <input id="slct_showerExterior" type="checkbox" idref="exteriorOptions__showerExterior" name="model" ><label class="inputText" id="txt_showerExterior">External Shower</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Exterior Trim</h4>						' . "\n";
	print
'    <input id="slct_stainlessTrim" type="checkbox" name="model" ><label class="inputText" id="txt_stainlessTrim">Stainless Steel Lower Trim</label><br>'
	  . "\n";
	print
'    <input id="slct_blackTrim" type="checkbox" name="model"><label class="inputText" id="txt_blackTrim">Black Trim Package</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Graphics</h4>						' . "\n";
	print
'    <input id="slct_graphics" type="checkbox" name="model"><label class="inputText" id="txt_graphics">Graphics</label>'
	  . "\n";
	print '    <br>' . "\n";
	print "\n";
	print '    <h4>Color</h4>			' . "\n";
	print '    <h5>Single Tone</h5>	' . "\n";
	print '    <select id="singleToneColor">' . "\n";
	PrintOptionColors();
	print '    </select><br><br>' . "\n";
	print
'    <input type="checkbox" name="model" id="slct_twoToneEnable"><label class="inputText" id="txt_twoToneEnable">Two Tone</label><br>'
	  . "\n";
	print '    <select id="twoToneColor">' . "\n";
	PrintOptionColors();
	print '    </select><br>' . "\n";
	print "\n";
	print '  </div>' . "\n";
	print '  <div id="electrical" class="tabcontent">' . "\n";
	print '    <a href="javascript:void(0)" class="closebtn">&times;</a>'
	  . "\n";
	print "\n";
	print '    <h3>Electrical</h3>' . "\n";
	print "\n";
	print '    <h4>Generator</h4>' . "\n";
	print
'    <input id="slct_generator55" type="checkbox" idref="electricalOptions__generator55" name="model" ><label class="inputText" id="txt_generator55">Generator - 5.5 kW</label><br>'
	  . "\n";
	print
'    <input id="slct_fuelStation" type="checkbox" idref="electricalOptions__fuelStation" name="model" ><label class="inputText" id="txt_fuelStation">Fueling Station</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Loading Lights</h4>						' . "\n";
	print
'    <input id="slct_lightsLoading" type="checkbox" idref="electricalOptions__lightsLoading" name="model" ><label class="inputText" id="txt_lightsLoading">Rear Halogen 12V, Swivel Mount Light</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Flood Lights</h4>						' . "\n";
	print
'    <input id="slct_lightsFlood" type="checkbox" idref="electricalOptions__lightsFlood" name="model" ><label class="inputText" id="txt_lightsFlood">Flood Lights Under Awning</label><br>'
	  . "\n";
	print "\n";
	print '    <h4>Battery</h4>						' . "\n";
	print
'    <input id="slct_batteryPrep1" type="checkbox" idref="electricalOptions__batteryPrep1" name="model"><label class="inputText" id="txt_batteryPrep1">Battery Prep</label>'
	  . "\n";
	print
'    <input id="slct_battery1" type="checkbox" idref="" name="model"><label class="inputText" id="txt_battery1">Include Battery, 12V</label><br>'
	  . "\n";
	print "\n";
	print
'    <input id="slct_batteryPrep2" type="checkbox" idref="electricalOptions__batteryPrep2" name="model" ><label class="inputText" id="txt_batteryPrep2">Second Battery Prep</label>'
	  . "\n";
	print
'    <input id="slct_battery2" type="checkbox" idref="" name="model"><label class="inputText" id="txt_battery2">Include Battery, 12V</label><br>'
	  . "\n";
	print "\n";
	print '      <h4>Solar</h4>						' . "\n";
	print
'      <input id="slct_solarPanel150W" type="checkbox" idref="electricalOptions__solarPanel150W" name="model" ><label class="inputText" id="txt_solarPanel150W">150 Watt Solar Panel</label><br>'
	  . "\n";
	print "\n";
	print '      </div>' . "\n";
	print '    </form>' . "\n";
}

sub PrintFooter {
	print "\n";
	print '    <script src="../../Scripts/jquery-2.2.4.min.js"></script>'
	  . "\n";
	print '    <script src="../../Scripts/bootstrap.min.js"></script>' . "\n";
	print
'    <script src="../../Scripts/x3dom.min.js" type="text/javascript"> </script>'
	  . "\n";
	print '    <script src="../../Scripts/Materials.js"></script>' . "\n";
	print '    <script src="../../Scripts/Prices.js"></script>' . "\n";
	print '    <script src="Scripts/Unique.js"></script>' . "\n";
	print '    <script src="../../Scripts/Events.js"></script>' . "\n";
	print '    <script src="../../Scripts/pathLoader.js"></script>' . "\n";
	print '    <script src="../../Scripts/Initialize.js"></script>' . "\n";
	print '    <script src="../../Scripts/Hades.js"></script>' . "\n";
	print '  </body>' . "\n";
	print '</html>  ' . "\n";
}
