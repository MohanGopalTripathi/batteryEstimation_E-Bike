% This script will be used to prepare the workspace for the simulation.
%
% First, an example .gpx file will be parsed to get a matrix of gps 
% coordinates and distance information.
%
% Next, this information will be used to extend the spatial data by
% assigning a timespan to each track segment and computing derived factors
% like acceleration.
%
% The result will be stored in the variable "route" (accessible from the
% workspace).
%
% See also loadgpx, assign_speed
disp( '#######################' );
%% load track
disp( 'Loading track "track_01.gpx".' );
track = loadgpx( 'track_01.gpx' );
%% assign speed
disp( 'Assigning segment speed and computing segment timespan and acceleration.' );
track = assign_speed( track );
disp( 'Creating simulation input.' );
%% prepare the workspace
% select the sim input from the route matrix and set standard parameters
simin = track( :, [const.COL_CUM_TIME, const.COL_SPEED, const.COL_SLOPE, const.COL_ACC] );

%plot_track( track );


disp( 'Done.' );
disp( '#######################' );