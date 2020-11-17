if (isempty(usb0))
    usb0=factory.getFirstAvailableInterface;
end

if ~usb0.isOpen()
    usb0.open
end

startup

%fs = 1000;
folder_name = 'C:\Users\JPDominguez-OfficeMR\Desktop\data_speech_commands_v0.02\on-off'     %Change in case of different dataset
%folder_name = uigetdir

classes_folders = dir(folder_name)
classes_folders = classes_folders(3:5);     %change in case of different dataset


usb0.setOperationMode(1);
usb0.setEventAcquisitionEnabled(true);


for i = 3 : 3%length(classes_folders)

    save_folder_name = strcat(classes_folders(i).name, '_aedats');
    mkdir(strcat(folder_name, '\', save_folder_name));
    
    file='test.aedat';
    fileName = 'test.wav';

    % Get a list of all files and folders in this folder.
    files_in_class = dir(strcat(folder_name, '\', classes_folders(i).name));
    %files_in_class = files_in_class(3:length(files_in_class));
    
    for j = 3 : size(files_in_class, 1)        
        [y,Fs] = audioread(strcat(strcat(strcat(folder_name,'\',classes_folders(i).name),'\'), files_in_class(j).name));
        
        playAndRecord(y, Fs, strcat(strcat(folder_name, '\', save_folder_name, '\', files_in_class(j).name)), usb0);
        %pause(0.25);
    end
    
    
end