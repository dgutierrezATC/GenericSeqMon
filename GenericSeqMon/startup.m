%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Angel Jimenez-Fernandez
% Adapted by Juan Pedro Dominguez-Morales & Daniel Gutierrez-Galan
% University of Seville 2020
% Last modification: 17/nov/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%function startup
% on startup setup the java class path for the stuff here
set(0,'defaultaxesfontsize',14);

% sets up path to use usb2 java classes
disp 'setting up java classpath for jAER interfacing'

current_path = pwd;

javaaddpath(strcat(current_path,'\host\java\jars\swing-layout-1.0.4.jar'));
javaaddpath(strcat(current_path,'\host\java\jars\UsbIoJava.jar'));
javaaddpath(strcat(current_path,'\host\java\dist\jAER.jar'));
javaaddpath(strcat(current_path,'\host\java\jars\jogl.jar'));
javaaddpath(strcat(current_path,'\host\java\jars\gluegen-rt.jar'));
javaaddpath(strcat(current_path,'\host\java\jars\comm.jar'));

javaaddpath(strcat(current_path,'\host\java\jars\prefs-0.8.jar'));
javaaddpath(strcat(current_path,'\host\java\jars\RXTXcomm.jar'));
javaaddpath(strcat(current_path,'\host\java\jars\spread.jar'));
javaaddpath(strcat(current_path,'\host\java\jars\UsbIoJava.jar'));

factory= net.sf.jaer.hardwareinterface.usb.cypressfx2.USBIOHardwareInterfaceFactory.instance();

usb0=factory.getInterface(0);