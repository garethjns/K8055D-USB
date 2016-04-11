% For help/explanation see http://matlaboratory.blogspot.co.uk/2013/04/multiple-vellman-k8055d-usb-boards-in.html
% Based on code by jarryd http://hackhole.blogspot.co.uk/2007/11/interface-velleman-k8055-usb-board-with.html

function Addresses = K8055D_Connect(ChannelAddress)
addpath('SET PATH TO .H HERE FIRST'); %folder containing DLL and H files


if max(ChannelAddress) > 3 || min(ChannelAddress) < 0
    disp('Error: 4 cards max!')
    return
end


Addresses = zeros(2,length(ChannelAddress));
for i = 1:length(ChannelAddress)
    fprintf ('    Channel: '); disp(ChannelAddress(i))
    fprintf ('    Status: ')
  
    s = ['loadlibrary(''K8055D',num2str(ChannelAddress(i)), '.dll'',''K8055D.h'');']; %Loads DLL and H file
    eval(s);
    s = ['tmp = calllib(''K8055D',num2str(ChannelAddress(i)),''', ''OpenDevice'',ChannelAddress(i));']; %Connects to board x at given address x
    eval(s);
    if ( tmp == -1)
        fprintf ('\tBoard %d not connected\n\n',ChannelAddress(i))
        Addresses(:,i) = [NaN; NaN];
    else
        fprintf ('\tConnected to board %d\n',ChannelAddress(i) )
        s = ['libfunctionsview(''K8055D',num2str(ChannelAddress(i)),''');'];  %View functions in the K8055Dx Dll
        eval(s);
        Addresses(i) = ChannelAddress(i);
    end  
    %input('Next...')
end

