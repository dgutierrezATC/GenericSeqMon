%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Angel Jimenez-Fernandez
% Adapted by Juan Pedro Dominguez-Morales & Daniel Gutierrez-Galan
% University of Seville 2020
% Last modification: 17/nov/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (isempty(usb0))
    usb0=factory.getFirstAvailableInterface;
end

if ~usb0.isOpen()
    usb0.open
end

startup

current_path = pwd;

folder_name = strcat(current_path,'\dataset\audio');
dest_folder_name = strcat(current_path,'\dataset\events');

classes_folders = dir(folder_name);
classes_folders = classes_folders(3:5);     %change in case of different dataset

usb0.setOperationMode(1);
usb0.setEventAcquisitionEnabled(true);


for i = 1 : length(classes_folders)

    save_folder_name = strcat(classes_folders(i).name, '_aedats');
    mkdir(strcat(dest_folder_name, '\', save_folder_name));
    
    % Get a list of all files and folders in this folder.
    files_in_class = dir(strcat(folder_name, '\', classes_folders(i).name));
    %files_in_class = files_in_class(3:length(files_in_class));
    
    for j = 3 : size(files_in_class, 1)        
        [y,Fs] = audioread(strcat(strcat(strcat(folder_name,'\',classes_folders(i).name),'\'), files_in_class(j).name));
        playAndRecord(y, Fs, strcat(strcat(dest_folder_name, '\', save_folder_name, '\', files_in_class(j).name)), usb0);
        %pause(0.25);
    end
end