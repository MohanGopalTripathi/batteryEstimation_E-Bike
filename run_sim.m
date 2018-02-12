% This script will configure and run the simulation.
clc
clear
run ('prepare_sim.m')


%% first simulation run
% update model parameters
disp( 'Updating model parameters, first run' );
Cr=0.006;
Cw=1.1;
A=0.5;
% run simulation
sim('ebike.mdl');
% compute statistics from simulation result
disp( '###################' );
disp('saving the data');
CityComp=PowerComponent;
CityEnergy=Energy;
    

%% second simulation run
% update model parameters
disp( '###################' );
disp( 'Updating model parameters, Second run' );
Cr=0.003;
Cw=0.4;
A=0.38;
% run simulation
sim('ebike.mdl');
% compute statistics from simulation result
t=(0:0.001:0.3);
t';
disp( '###################' );
disp('saving the data');
RaceComp=PowerComponent;
RaceEnergy=Energy;

%plotting data

f = figure;

set(f, 'Units', 'normalized', 'Position', [0.05, 0.0, 0.9, 0.9]); 

    % plots the downhill energy vs time
    subplot(4,2,1)
    plot(t,CityComp(:,1), t,RaceComp(:,1));
    xlabel( 'hours' );
    ylabel( 'Joules' );
    title('Time VS Downhill Slope Energy');
    legend ('City', 'Race','Location','NorthWest');

    % plots time vs acceleration energy
    subplot(4,2,2)
    plot(t,CityComp(:,2),t,RaceComp(:,2));
    xlabel( 'hours' );
    ylabel( 'Joules' );
    title('Time VS Acceleration Energy');
    legend ('City','Race','Location','NorthWest');
    
    %plots time vs rolling friction energy
    subplot(4,2,3)
    plot( t,CityComp(:,3), t,RaceComp(:,3) );
    xlabel( 'hours' );
    ylabel( 'Joules' );
    title('Time VS Rolling Friction Energy');
    legend ('City','Race','Location','NorthWest');
   
    % plots the time vs the Air Darg energy
    subplot(4,2,4)
    plot( t, CityComp(:,4), t, RaceComp(:,4) );
    xlabel( 'hours' );
    ylabel( 'Joules' );
    title('Time VS Air Drag Energy');
   legend ('City','Race','Location','NorthWest');
   
    %plots the Battery vs time 
    subplot(4,2,5)
    plot (t, CityEnergy(:,1), t, RaceEnergy(:,1));
    xlabel( 'hours' );
    ylabel( 'Ah' );
    title ('Battery VS Time');
    legend ('City', 'Race','Location','NorthWest');
    
    %Plots the support energy vs time
    subplot(4,2,6);
    plot(t,CityEnergy(:,2), t, RaceEnergy(:,2));
    xlabel('hours');
    ylabel( 'Joules' );
    title('Support Energy vs Time');
    legend ('City', 'Race', 'Location','NorthWest');
    
    %plots the Driver energy vs the time 
    subplot(4,2,7);
    plot (t, CityEnergy(:,3), t, RaceEnergy(:,3));
    xlabel('hours');
    ylabel('Joules');
    title ('Driver Energy vs Time');
    legend ('City','Race', 'Location','NorthWest');
    
    %plots the total energy vs the time
    subplot (4,2,8);
    plot(t,CityEnergy(:,4), t, RaceEnergy(:,4));
    xlabel('hours');
    ylabel('Joules');
    title ('Total Energy vs Time');
    legend ('City', 'Race','Location','NorthWest');
    
    %%Reporting on command window
    disp( '###################' );
    disp ('CITY BIKE');
    disp( '###################' );
    
    disp ('Battery and Energy required for City bike at the end:');
    disp (' Battery  Support_Energy  Driver_Energy  Total_Energy');
    CityEnergy(301,1:4) 
    
    disp( '###################' );
    disp ('RACING BIKE');
    disp( '###################' );
    disp('Battery and Energy required by the Racing bike at the end:');
    disp (' Battery  Support_Energy  Driver_Energy  Total_Energy');
    RaceEnergy(301,1:4)
     
    
    %Reporting of low battery to user
    if (CityEnergy(301,1)<10.5)
        disp('in City Bike, Battery is low; Electrical support will be shut off');
    elseif ((RaceEnergy(301,1)<10.5))
        disp('in Racing Bike, Battery is low; Electrical support will be shut off');
    end
       
    
    disp( '###################' );
    disp('Plotting Graph');
    
    g = figure;

    set(g, 'Units', 'normalized', 'Position', [0.02, 0.01, 0.3, 0.9]); 
    
    %%PLOTS BAR GRAPH FOR RACING BIKE
    y = RaceEnergy(301,2:4);

    subplot(2,1,1);
    bar (y,0.3,'g'); title ('Energy for Racing Bike');
    set(gca,'XTickLabel',{'Support', 'Driver', 'Total'});
    
    %%PLOTS BAR GRAPH FOR CITY BIKE
    x = CityEnergy(301,2:4);
    subplot (2,1,2);
    bar (x,0.3,'b');title ('Energy for City Bike');
    set(gca,'XTickLabel',{'Support', 'Driver', 'Total'});
    
    % clear parameters
    %clear
    % clear simulation output
    disp( 'Done.' );
    disp( '####################' );