close all
clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input files and set row and column parameters to read text file for import
cd 'C:\Users\mpontr01\Box Sync\Box Sync\tFall_2018\Research\Mexico_City\Data\CE32_data';
output = 'C:\Users\mpontr01\Box Sync\Box Sync\tFall_2018\Research\Mexico_City\Figures\H_V';
set(gca, 'YScale', 'log')
files = dir('*.txt');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'C:\Users\mpontr01\Box Sync\Box Sync\tFall_2018\Research\Mexico_City\Codes';
counter = 0;
for file = files'
    filename = strcat('C:\Users\mpontr01\Box Sync\Box Sync\tFall_2018\Research\Mexico_City\Data\CE32_data\',file.name);

    counter = counter + 1;
    [station, earthquake]=Readtxtfile(filename);
    [data1] = readdata(filename); %get Data from Text file
    evenlen(counter) = (length(data1));
end
zz = min(evenlen);

for file = files'
    filename = strcat('C:\Users\mpontr01\Box Sync\Box Sync\tFall_2018\Research\Mexico_City\Data\CE32_data\',file.name);
    [station, earthquake]=Readtxtfile(filename);
    fs = station.fs; %sampling frequency in hz
    [data1] = readdata(filename); %get Data from Text file
    [xNS, xV, xEW] = Butter(data1, fs); %filter the data
    [N_2, fax_HzN, XNS_magfilt,XV_magfilt,XEW_magfilt] =  Magresp(xNS, xV, xEW, fs); %Compute mag responses and run through triangular filter
    %perform H/V
    for iii = 1:length(XNS_magfilt)
        H_V1(iii) = XNS_magfilt(iii)/XV_magfilt(iii);
    end
    hold on
    fig = plot(fax_HzN(1:N_2), H_V1(1:N_2));
    title(strcat(file.name, ' NS/V'))
    xlabel('Frequency (Hz)')
    ylabel('Ratio')
    grid on
    figure
    plot(xNS)
    
end
cd 'C:\Users\mpontr01\Box Sync\Box Sync\tFall_2018\Research\Mexico_City\Data\CE32_data';

filename='C:\Users\mpontr01\Box Sync\1_Fall_2017\Research\Mexico RACM data\19sep17\test_nrattle_02mar11.nrattle_amps4plot.out';
M = dlmread(filename,' ',19,0);
M(:,1)=[];
M(:,1)=[];
M(:,1)=[];
M(:,1)=[];
M(:,2)=[];
M(:,2)=[];
M(:,3)=[];
M(:,3)=[];

freq=M(:,1);
amps=M(:,3);
a = plot(freq,amps, 'Linewidth', 2, 'Color', 'k');
legend([a],{'SH1D TTF'})
saveas(fig,strcat(output,'CE32test.jpg'))
fclose('all')