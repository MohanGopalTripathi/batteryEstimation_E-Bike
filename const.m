classdef const
    %CONST Contains the constants used throughout this example.
    %   Detailed explanation goes here
    %
    %   COL_X, COL_Y, COL_Z are the indices to the X, Y, and Z coordinates.
    %   COL_LAT, COL_LNG are the indices to the latitude and longitude in degtrees
    %   COL_SEG_DST is the index to the distance between the track point and its predecessor
    %   COL_CUM_DST is the index to the cumulative track length
    %   COL_SLOPE is the index to the slope between the track point and its predecessor
    %   COL_SPEED is the index to the speed in km/h
    %   COL_SEG_TIME is the index to the time in hours
    %   COL_CUM_TIME is the index to the accumulated time in hours
    %   COL_ACC is the index to the acceleration in m/s�.
    %
    %   FIGURE_TRACK is the id for the track visualization figure.
    
    % Column identifiers for better readability
    properties (Constant = true)
        COL_X = 1;
        COL_Y = 2;
        COL_Z = 3;
        COL_LAT = 4;
        COL_LNG = 5;
        COL_SEG_DST = 6;
        COL_CUM_DST = 7;
        COL_SLOPE = 8;
        COL_SPEED = 9;
        COL_SEG_TIME = 10;
        COL_CUM_TIME = 11;
        COL_ACC = 12;
        
               
        
        FIGURE_TRACK = 10001;
    end  
end
