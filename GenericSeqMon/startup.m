%function startup
% on startup setup the java class path for the stuff here
set(0,'defaultaxesfontsize',14);

% sets up path to use usb2 java classes
disp 'setting up java classpath for jAER interfacing'
% here=fileparts(mfilename('fullpath'));
% % jars are up and down from us
% p=[here,'\host\java\'];
% javaaddpath([p,'jars\swing-layout-0.9.jar']);
% javaaddpath([p,'jars\UsbIoJava.jar']);
% javaaddpath([p,'dist\jAER.jar']);
% javaaddpath([p,'jars\jogl.jar']);  % if you get complaint here, remove the jogl in matlab's static classpath.txt
% javaaddpath([p,'jars\gluegen-rt.jar']);
% global
% factory



javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\swing-layout-1.0.4.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\UsbIoJava.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\dist\jAER.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\jogl.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\gluegen-rt.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\comm.jar');
% javaaddpath('C:\Users\Angel\Desktop\GenericSeqMon\host\java\jars\jsr8
% 0-1.0.1.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\prefs-0.8.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\RXTXcomm.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\spread.jar');
javaaddpath('D:\Repositorios\SVNs\JPDominguez\Estancia Paris\GenericSeqMon\host\java\jars\UsbIoJava.jar');

% factory = ch.unizh.ini.caviar.hardwareinterface.usb.CypressFX2Factory.instance();
% factory = net.sf.jaer.hardwareinterface.usb.cypressfx2.CypressFX2Factory.instance()
factory= net.sf.jaer.hardwareinterface.usb.cypressfx2.USBIOHardwareInterfaceFactory.instance()

usb0=factory.getInterface(0)