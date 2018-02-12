function track_data = assign_speed(gpx_data)
%ASSIGNSPEED assigns a driving speed to each track point.
% ROUTE = ASSIGNSPEED(TRACK_DATA) extends the gpx data by adding columns
% for velocity, time and acceleration.
%
% GPX_DATA  is a Nx8 array where each row is a track point.
%   Columns 1-3 are the X, Y, and Z coordinates.
%   Columns 4-5 are latitude and longitude
%   Column  6 is the distance between the track point and its predecessor
%   Column  7 is the cumulative track length
%   Column  8 is the slope between the track point and its predecessor.
%
% TRACK_DATA  is a Nx11 array where each row is a track point.
%   Columns 1-3 are the X, Y, and Z coordinates.
%   Columns 4-5 are latitude and longitude
%   Column  6 is the distance between the track point and its predecessor
%   Column  7 is the cumulative track length
%   Column  8 is the slope between the track point and its predecessor
%   Column  9 is the speed in km/h
%   Column  10 is the time in hours
%   Column  11 is the accumulated time in hours
%   Column  12 is the acceleration in m/s^2.
%
% See also loadgpx

% set track_data for speed, time per segment, cumulated time and acceleration to zero
track_data = gpx_data;
track_data(:,const.COL_SPEED:const.COL_ACC) = 0;

% assign speed to each trackpoint
track_data = assign_slope_based_speed(track_data);
track_data = compute_time_and_acceleration( track_data );

end

%% local functions

%function out = assign_fixed_speed( in )
%out = in;
% assign fixed speed of 20 km/h
%out(:,const.COL_SPEED) = 20;

%end

function out = assign_slope_based_speed( in )
out = in;
% assign speed based on the slope of the segment
for i=2:size(in,1)
out(i,const.COL_SPEED) = 20 - 0.5*out(i,const.COL_SLOPE);
end
end

function out = compute_time_and_acceleration( in )
out = in;

out(1,const.COL_SEG_TIME) = 0;  % time
out(1,const.COL_CUM_TIME) = 0;  % cumulated time
out(1,const.COL_ACC) = 0;  		% acceleration

for i = 2:size(in, 1)
    % compute segment time in hours
   out(i,const.COL_SEG_TIME) = (out(i,const.COL_SEG_DST))/(out(i,const.COL_SPEED));

    
    % compute accumulated time in hours
    out(:,const.COL_CUM_TIME) = cumsum (out(:,const.COL_SEG_TIME));
     
     
    % compute acceleration in m/s^2   
        
  out(i,const.COL_ACC) = (out(i,const.COL_SPEED)-out((i-1),const.COL_SPEED))/out(i,const.COL_SEG_TIME);
    
end
    plot_track(out);
end
