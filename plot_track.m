function plot_track( track )
%PLOT_ROUTE creates several plots to visualize the route.

p = figure( const.FIGURE_TRACK );

set(p, 'Units', 'normalized', 'Position', [0.2, 0.01, 0.6, 0.92]); 

% plot the height profile
    subplot(6,1,1)
    plot( track(:,const.COL_CUM_DST), 1000 * track(:,const.COL_Z) );
    xlabel( 'distance [km]' );
    ylabel( 'height [m]' );
    

    % plot the slope along the route
    subplot(6,1,2)
    plot( track(:,const.COL_CUM_DST),track(:,const.COL_SLOPE) );
    xlabel( 'distance [km]' );
    ylabel( 'slope [deg.]' );
% plot the speed along the route
    
 subplot(6,1,3)
    plot( track(:,const.COL_CUM_DST),1000*track(:,const.COL_SPEED) );
    xlabel( 'distance [km]' );
    ylabel( 'speed[m/s]' );
    
% plot the acceleration along the route
     subplot(6,1,4)
    plot( track(:,const.COL_CUM_DST),track(:,const.COL_ACC) );
    xlabel( 'distance [km]' );
    ylabel( 'acceleration[m/s^2]' );
   

%creat a 3D plot of the route

subplot(6,1,5:6)
    plot3( track(:,const.COL_X), ...
           track(:,const.COL_Y), ...
           1000 * track(:,const.COL_Z), ...
           '.-', ...
           'MarkerSize', 5, ...
           'LineWidth', 1 );
    xlabel( 'X (long) [km]' );
    ylabel( 'Y (lat) [km]' );
    zlabel( 'height [m]' );
    grid( 'on' );
    box( 'on' );
    rotate3d( 'on' );
    colormap( 'Jet' );
end

