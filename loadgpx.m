function track = loadgpx(filename,varargin)
%LOADGPX Loads route points from a GPS interchange file
% ROUTE = LOADGPX(FILENAME) Loads route point information from a .GPX
%   GPS interchange file.  This utility is not a general-purpose
%   implementation of GPX reading and is only used for demonstration.
%
% GPX_DATA  is a Nx8 array where each row is a track point.
%   Columns 1-3 are the X, Y, and Z coordinates.
%   Columns 4-5 are latitude and longitude
%   Column  6 is the distance between the track point and its predecessor
%   Column  7 is the cumulative track length
%   Column  8 is the slope between a track point and its predecessor in percent.
%
% See also xmlread

% read the gpx file
d = xmlread(filename);
if ~strcmp(d.getDocumentElement.getTagName,'gpx')
    warning('loadgpx:formaterror','file is not in GPX format');
end

% get track points from gpx file
pntList = d.getElementsByTagName('trkpt');
% number of track points
pntCt = pntList.getLength;
% empty matrix with route data
track = nan(pntCt,5);
% loop over all track points
for i=1:pntCt
    pt = pntList.item(i-1);
    % read latitude
    try
        track(i,const.COL_LAT) = str2double(pt.getAttribute('lat'));
    catch
        warning('loadgpx:bad_latitude','Malformed latitutude in point %i.  (%s)',i,lasterr);
    end
    
    % read longitude
    try
        track(i,const.COL_LNG) = str2double(pt.getAttribute('lon'));
    catch
        warning('loadgpx:bad_longitude','Malformed longitude in point %i.  (%s)',i,lasterr);
    end
    
    % read elevation
    ele = pt.getElementsByTagName('ele');
    if ele.getLength>0
        try
            track(i,const.COL_Z) = str2double(ele.item(0).getTextContent)/1000;
        catch
            warning('loadgpx:bad_elevation','Malformed elevation in point %i.  (%s)',i,lasterr);
        end
    end
end

% compute coordinates as X/Y in kilometers
KM_PER_DEG = 111.3;
track(:,const.COL_X) = KM_PER_DEG * cos(track(:,const.COL_LAT)./180.*pi) .* track(:,const.COL_LNG);
track(:,const.COL_Y) = KM_PER_DEG * track(:,const.COL_LAT);

% compute segment and cumulative distance
track(1,const.COL_SEG_DST) = 0;
track(2:end,const.COL_SEG_DST) = sqrt(sum((track(1:end-1,const.COL_X:const.COL_Y)-track(2:end,const.COL_X:const.COL_Y)).^2,2));
track(:,const.COL_CUM_DST) = cumsum(track(:,const.COL_SEG_DST));

% compute segment slope
track(1,const.COL_SLOPE) = 0;
track(2:end,const.COL_SLOPE) = 100 * (track(2:end,const.COL_Z)-track(1:end-1,const.COL_Z)) ./ track(2:end,const.COL_SEG_DST);

end




