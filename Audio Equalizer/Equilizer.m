%Reading file name input
prompt = {'\fontsize{13} File name :'}; %Subtitles
dlgtitle = 'Equilizer'; 
size = [1 50]; 
definput = {'FilePath',}; 
opts.Interpreter = 'tex'; 
answer = inputdlg(prompt,dlgtitle,size,definput,opts);
file_name =  answer{1}; 
[y , fs] = audioread(file_name);

%Gain inputs
% display('Enter gain for the 9 filters..');
prompt = {'Enter 1st gain in dB:','Enter 2nt gain in dB:','Enter 3rd gain in dB:','Enter 4th gain in dB:','Enter 5th gain in dB:','Enter 6th gain in dB:','Enter 7th gain in dB:','Enter 8th gain in dB:','Enter 9th gain in dB:'}; %Subtitles 
size = [1 50]; 
definput = {'0','0','0','0','0','0','0','0','0'}; 
opts.Interpreter = 'tex'; 
answer = inputdlg(prompt,dlgtitle,size,definput);
k_i1 =  str2num(answer{1}); 
k_i2 =  str2num(answer{2});
k_i3 =  str2num(answer{3});
k_i4 =  str2num(answer{4});
k_i5 =  str2num(answer{5});
k_i6 =  str2num(answer{6});
k_i7 =  str2num(answer{7});
k_i8 =  str2num(answer{8});
k_i9 =  str2num(answer{9});

prompt = {'Enter filters type(F for FIR / I for IIR):','Enter output sample rate:'}; %Subtitles 
size = [1 50]; 
definput = {'F','100'}; 
opts.Interpreter = 'tex'; 
answer = inputdlg(prompt,dlgtitle,size,definput);
filter_type =  answer{1};
Output_sample_rate =  str2num(answer{2});

%k_i1 = input('Enter 1st gain in dB: ');
k_i1 = 10 ^ (k_i1/20);
%k_i2 = input('Enter 2nd gain in dB: ');
k_i2 = 10 ^ (k_i2/20);
%k_i3 = input('Enter 3rd gain in dB: ');
k_i3 = 10 ^ (k_i3/20);
%k_i4 = input('Enter 4th gain in dB: ');
k_i4 = 10 ^ (k_i4/20);
%k_i5 = input('Enter 5th gain in dB: ');
k_i5 = 10 ^ (k_i5/20);
%k_i6 = input('Enter 6th gain in dB: ');
k_i6 = 10 ^ (k_i6/20);
%k_i7 = input('Enter 7th gain in dB: ');
k_i7 = 10 ^ (k_i7/20);
%k_i8 = input('Enter 8th gain in dB: ');
k_i8 = 10 ^ (k_i8/20);
%k_i9 = input('Enter 9th gain in dB: ');
k_i9 = 10 ^ (k_i9/20);

%Specify type of filter
%filter_type = input('Enter filters type(F for FIR / I for IIR): ','s');

%Output sample rate
%Output_sample_rate = input('Enter output sample rate: ');

%FIR filters
if filter_type == 'F'
    N = 50;
    fn = fs;
    omega0 = 1/fn;
    omega1 = 170/fn;
    omega2 = 310/fn;
    omega3 = 600/fn;
    omega4 = 1000/fn;
    omega5 = 3000/fn;
    omega6 = 6000/fn;
    omega7 = 12000/fn;
    omega8 = 14000/fn;
    omega9 = 16000/fn;
    
    %h0 = fir1(N , omega0,'low');
    h1  = fir1(N ,omega1,'low');
    h2  = fir1(N ,[omega1 omega2],'bandpass');
    h3  = fir1(N ,[omega2 omega3],'bandpass');
    h4  = fir1(N ,[omega3 omega4],'bandpass');
    h5  = fir1(N ,[omega4 omega5],'bandpass');
    h6  = fir1(N ,[omega5 omega6],'bandpass');
    h7  = fir1(N ,[omega6 omega7],'bandpass');
    h8  = fir1(N ,[omega7 omega8],'bandpass');
    h9  = fir1(N ,[omega8 omega9],'bandpass');
    
    
    %Filters after amplification
    %f_h0 = k_i1*filter(h0,1,y);
    f_h1 = k_i1*filter(h1,1,y);
    f_h2 = k_i2*filter(h2,1,y);
    f_h3 = k_i3*filter(h3,1,y);
    f_h4 = k_i4*filter(h4,1,y);
    f_h5 = k_i5*filter(h5,1,y);
    f_h6 = k_i6*filter(h6,1,y);
    f_h7 = k_i7*filter(h7,1,y);
    f_h8 = k_i8*filter(h8,1,y);
    f_h9 = k_i9*filter(h9,1,y);
    
    
    %Original filters
    %f_h0 = filter(h0,1,y);
    fo_h1 = filter(h1,1,y);
    fo_h2 = filter(h2,1,y);
    fo_h3 = filter(h3,1,y);
    fo_h4 = filter(h4,1,y);
    fo_h5 = filter(h5,1,y);
    fo_h6 = filter(h6,1,y);
    fo_h7 = filter(h7,1,y);
    fo_h8 = filter(h8,1,y);
    fo_h9 = filter(h9,1,y);
    
    
    %Analyze filters
    
    %%%%%%%%%%%%%%%%First Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h1,1);
    title('1st Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(h1,1);
    plot(imp)
    title('1st Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h1,1);
    plot(step)
    title('1st Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h1,1);
    title('1st Filter Poles and Zeros')
    grid on
    
    
    %%%%%%%%%%%%%%%%Second Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h2,1);
    title('2nd Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(h2,1);
    plot(imp)
    title('2nd Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h2,1);
    plot(step)
    title('2nd Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h2,1);
    title('2nd Filter Poles and Zeros')
    grid on
    
    
    %%%%%%%%%%%%%%%%Third Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h3,1);
    title('3rd Filter Magnitude & Phase response');
    grid on
   
    figure
    subplot(3,2,1)
    imp = impz(h3,1);
    plot(imp)
    title('3rd Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h3,1);
    plot(step)
    title('3rd Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h3,1);
    title('3rd Filter Poles and Zeros')
    grid on
   
    
    %%%%%%%%%%%%%%%%Fourth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h4,1);
    title('4th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(h4,1);
    plot(imp)
    title('4th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h4,1);
    plot(step)
    title('4th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h4,1);
    title('4th Filter Poles and Zeros')
    grid on
  
    
    %%%%%%%%%%%%%%%%Fifth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h5,1);
    title('5th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(h5,1);
    plot(imp)
    title('5th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h5,1);
    plot(step)
    title('5th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h5,1);
    title('5th Filter Poles and Zeros')
    grid on
  
    
    %%%%%%%%%%%%%%%%Sixth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h6,1);
    title('6th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(h6,1);
    plot(imp)
    title('6th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h6,1);
    plot(step)
    title('6th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h6,1);
    title('6th Filter Poles and Zeros')
    grid on
    
    
    %%%%%%%%%%%%%%%%Seventh Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h7,1);
    title('7th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(h7,1);
    plot(imp)
    title('7th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h7,1);
    plot(step)
    title('7th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h7,1);
    title('7th Filter Poles and Zeros')
    grid on

    
    %%%%%%%%%%%%%%%%Eighth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h8,1);
    title('8th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(h8,1);
    plot(imp)
    title('8th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h8,1);
    plot(step)
    title('8th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h8,1);
    title('8th Filter Poles and Zeros')
    grid on

    
    %%%%%%%%%%%%%%%%Ninth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(h9,1);
    title('9th Filter Magnitude & Phase response');
    grid on
    
    figure  
    subplot(3,2,1)
    imp = impz(h9,1);
    plot(imp)
    title('9th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(h9,1);
    plot(step)
    title('9th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(h9,1);
    title('9th Filter Poles and Zeros')
    grid on
       
else
    
    N = 2;
    fn = fs/2;
    omega0 = 1/fn;
    omega1 = 170/fn;
    omega2 = 310/fn;
    omega3 = 600/fn;
    omega4 = 1000/fn;
    omega5 = 3000/fn;
    omega6 = 6000/fn;
    omega7 = 12000/fn;
    omega8 = 14000/fn;
    omega9 = 16000/fn;
    
    [z1,p1] = butter(N ,omega1);
    [z2,p2] = butter(N ,[omega1 omega2]);
    [z3,p3] = butter(N ,[omega2 omega3]);
    [z4,p4] = butter(N ,[omega3 omega4]);
    [z5,p5] = butter(N ,[omega4 omega5]);
    [z6,p6] = butter(N ,[omega5 omega6]);
    [z7,p7] = butter(N ,[omega6 omega7]);
    [z8,p8] = butter(N ,[omega7 omega8]);
    [z9,p9] = butter(N ,[omega8 omega9]);
   
    
    %Filters after amplification
    f_h1 = k_i1*filter(z1,p1,y);
    f_h2 = k_i2*filter(z2,p2,y);
    f_h3 = k_i3*filter(z3,p3,y);
    f_h4 = k_i4*filter(z4,p4,y);
    f_h5 = k_i5*filter(z5,p5,y);
    f_h6 = k_i6*filter(z6,p6,y);
    f_h7 = k_i7*filter(z7,p7,y);
    f_h8 = k_i8*filter(z8,p8,y);
    f_h9 = k_i9*filter(z9,p9,y);
   
    
    %Original filters
    fo_h1 = filter(z1,p1,y);
    fo_h2 = filter(z2,p2,y);
    fo_h3 = filter(z3,p3,y);
    fo_h4 = filter(z4,p4,y);
    fo_h5 = filter(z5,p5,y);
    fo_h6 = filter(z6,p6,y);
    fo_h7 = filter(z7,p7,y);
    fo_h8 = filter(z8,p8,y);
    fo_h9 = filter(z9,p9,y);
    
    
    %Analyze filters
    
    %%%%%%%%%%%%%%%%First Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z1,p1);
    title('1st Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z1,p1);
    plot(imp)
    title('1st Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z1,p1);
    plot(step)
    title('1st Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z1,p1);
    title('1st Filter Poles and Zeros')
    grid on
    
    
    %%%%%%%%%%%%%%%%Second Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z2,p2);
    title('2nd Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z2,p2);
    plot(imp)
    title('2nd Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z2,p2);
    plot(step)
    title('2nd Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z2,p2);
    title('2nd Filter Poles and Zeros')
    grid on
    
    
    %%%%%%%%%%%%%%%%Third Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z3,p3);
    title('3rd Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z3,p3);
    plot(imp)
    title('3rd Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z3,p3);
    plot(step)
    title('3rd Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z3,p3);
    title('3rd Filter Poles and Zeros')
    grid on
    
    %%%%%%%%%%%%%%%%Fourth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z4,p4);
    title('4th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z4,p4);
    plot(imp)
    title('4th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z4,p4);
    plot(step)
    title('4th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z4,p4);
    title('4th Filter Poles and Zeros')
    grid on
    
    %%%%%%%%%%%%%%%%Fifth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z5,p5);
    title('5th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z5,p5);
    plot(imp)
    title('5th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z5,p5);
    plot(step)
    title('5th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z5,p5);
    title('5th Filter Poles and Zeros')
    grid on
  
    
    %%%%%%%%%%%%%%%%Sixth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z6,p6);
    title('6th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z6,p6);
    plot(imp)
    title('6th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z6,p6);
    plot(step)
    title('6th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z6,p6);
    title('6th Filter Poles and Zeros')
    grid on
    
    %%%%%%%%%%%%%%%%Seventh Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z7,p7);
    title('7th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z7,p7);
    plot(imp)
    title('7th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z7,p7);
    plot(step)
    title('7th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z7,p7);
    title('7th Filter Poles and Zeros')
    grid on
    
    %%%%%%%%%%%%%%%%Eighth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z8,p8);
    title('8th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z8,p8);
    plot(imp)
    title('8th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z8,p8);
    plot(step)
    title('8th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z8,p8);
    title('8th Filter Poles and Zeros')
    grid on

    
    %%%%%%%%%%%%%%%%Ninth Filter%%%%%%%%%%%%%%%%
    figure
    freqz(z9,p9);
    title('9th Filter Magnitude & Phase response');
    grid on
    
    figure
    subplot(3,2,1)
    imp = impz(z9,p9);
    plot(imp)
    title('9th Filter Impulse Response');
    grid on
    
    subplot(3,2,2)
    step = stepz(z9,p9);
    plot(step)
    title('9th Filter Step Response');
    grid on
    
    subplot(3,2,3)
    zplane(z9,p9);
    title('9th Filter Poles and Zeros')
    grid on

end

    %Filters Time Domain
    figure
    subplot(3,3,1)
    plot(f_h1);
    title('1st Filter Time Domain');
    grid on
    
    subplot(3,3,2)
    plot(f_h2);
    title('7th Filter Time Domain');
    grid on
    
    subplot(3,3,3)
    plot(f_h3);
    title('3rd Filter Time Domain');
    grid on
    
    subplot(3,3,4)
    plot(f_h4);
    title('4th Filter Time Domain');
    grid on
    
    subplot(3,3,5)
    plot(f_h5);
    title('5th Filter Time Domain');
    grid on
    
    subplot(3,3,6)
    plot(f_h6);
    title('6th Filter Time Domain');
    grid on
    
    subplot(3,3,7)
    plot(f_h7);
    title('7th Filter Time Domain');
    grid on
    
    subplot(3,3,8)
    plot(f_h8);
    title('8th Filter Time Domain');
    grid on
    
    subplot(3,3,9)
    plot(f_h9);
    title('9th Filter Time Domain');
    grid on
    
    %Filters Frequency Domain
    figure
    subplot(3,3,1);
    plot(abs(fftshift(fft(f_h1))));
    title('1st Filter Freq Domain');
    grid on
    
    subplot(3,3,2);
    plot(abs(fftshift(fft(f_h2))));
    title('7th Filter Freq Domain');
    grid on
    
    subplot(3,3,3);
    plot(abs(fftshift(fft(f_h3))));
    title('3rd Filter Freq Domain');
    grid on
    
    subplot(3,3,4);
    plot(abs(fftshift(fft(f_h4))));
    title('4th Filter Freq Domain');
    grid on
    
    subplot(3,3,5);
    plot(abs(fftshift(fft(f_h5))));
    title('5th Filter Freq Domain');
    grid on
    
    subplot(3,3,6);
    plot(abs(fftshift(fft(f_h6))));
    title('6th Filter Freq Domain');
    grid on
    
    subplot(3,3,7);
    plot(abs(fftshift(fft(f_h7))));
    title('7th Filter Freq Domain');
    grid on
    
    subplot(3,3,8);
    plot(abs(fftshift(fft(f_h8))));
    title('8th Filter Freq Domain');
    grid on
    
    subplot(3,3,9);
    plot(abs(fftshift(fft(f_h9))));
    title('9th Filter Freq Domain');
    grid on
    
    %Composite Signal
    composite_signal = f_h1+f_h2+f_h3+f_h4+f_h5+f_h6+f_h7+f_h8+f_h9;
    original_signal = fo_h1+fo_h2+fo_h3+fo_h4+fo_h5+fo_h6+fo_h7+fo_h8+fo_h9;
    sound(composite_signal,fs)
    figure
    subplot(2,1,1);
    plot(original_signal)
    title('Original Signal');
    subplot(2,1,2);
    plot(composite_signal)
    title('New Signal');

    %Comparison of original and composite signal
        figure
        subplot(2,2,1);
        plot(y)
        title('Original Signal Time Domain');
        
        subplot(2,2,2);
        plot(abs(fftshift(fft(y))))
        title('Original Signal Freq Domain ');

        subplot(2,2,3);
        plot(composite_signal)
        title('Composite signal After Gain Time Domain');

        subplot(2,2,4);
        plot(abs(fftshift(fft(composite_signal))))
        title('Composite signal After Gain Freq Domain');


        Half = Output_sample_rate/2;
        composite_signal_half = resample(composite_signal,Half,fs);


        Double =Output_sample_rate*2;
        composite_signal_double = resample(composite_signal,Double,fs);




        figure
        subplot(2,1,1)
        plot(composite_signal_half,'g')
        title('Half Out Rate');

        subplot(2,1,2) 
        plot(composite_signal_double,'g')
        title('Double Out Rate');





       